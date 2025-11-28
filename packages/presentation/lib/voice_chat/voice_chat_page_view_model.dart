import 'dart:async';
import 'dart:convert';

import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:openai_realtime_dart/openai_realtime_dart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:presentation/config/env_config.dart';
import 'package:presentation/page_state.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'voice_chat_page_view_model.g.dart';

/// Voice Chat Page ViewModel
///
/// Manages OpenAI Realtime API connection, audio recording, and playback
@riverpod
class VoiceChatPageViewModel extends _$VoiceChatPageViewModel {
  RealtimeClient? _client;
  AudioRecorder? _recorder;
  AudioPlayer? _player;
  StreamSubscription<Uint8List>? _audioStreamSubscription;
  final _uuid = const Uuid();
  final _dateFormat = DateFormat('HH:mm');

  // Audio buffer for streaming playback
  final List<int> _audioBuffer = [];
  bool _isPlayingAudio = false;

  @override
  PageState<VoiceChatPageUiState, VoiceChatPageAction> build() {
    ref.onDispose(_dispose);
    return PageState(
      uiState: const VoiceChatPageUiState(
        statusMessage: 'Press connect to start',
      ),
      action: VoiceChatPageAction.none(),
    );
  }

  /// Reset action after handling
  void onFinishedAction() {
    state = state.copyWith(action: VoiceChatPageAction.none());
  }

  /// Initialize and check microphone permission
  Future<void> onInitialize() async {
    _recorder = AudioRecorder();
    _player = AudioPlayer();

    final hasPermission = await _recorder!.hasPermission();
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        hasMicPermission: hasPermission,
        statusMessage: hasPermission
            ? 'Press connect to start'
            : 'Microphone permission required',
      ),
    );

    if (!hasPermission) {
      state = state.copyWith(
        action: VoiceChatPageAction.requestMicPermission(),
      );
    }
  }

  /// Request microphone permission
  Future<void> onRequestMicPermission() async {
    final status = await Permission.microphone.request();
    final hasPermission = status.isGranted;

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        hasMicPermission: hasPermission,
        statusMessage: hasPermission
            ? 'Press connect to start'
            : 'Microphone permission denied',
      ),
    );
  }

  /// Connect to OpenAI Realtime API
  Future<void> onConnect() async {
    if (!state.uiState.hasMicPermission) {
      state = state.copyWith(
        action: VoiceChatPageAction.showError('Microphone permission required'),
      );
      return;
    }

    final apiKey = EnvConfig.openAiApiKey;
    if (apiKey.isEmpty) {
      state = state.copyWith(
        action: VoiceChatPageAction.showError('OpenAI API key not configured'),
      );
      return;
    }

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        connectionStatus: ConnectionStatusUi.connecting,
        statusMessage: 'Connecting...',
      ),
    );

    try {
      _client = RealtimeClient(apiKey: apiKey);

      // Set up event handlers
      _setupEventHandlers();

      // Connect
      await _client!.connect();

      // Update session configuration
      await _client!.updateSession(
        voice: Voice.alloy,
        inputAudioTranscription: const InputAudioTranscriptionConfig(
          model: 'whisper-1',
        ),
        turnDetection: TurnDetection(
          type: TurnDetectionType.serverVad,
          threshold: 0.5,
          prefixPaddingMs: 300,
          silenceDurationMs: 500,
        ),
      );

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          connectionStatus: ConnectionStatusUi.connected,
          statusMessage: 'Connected! Hold mic to speak',
        ),
      );
    } catch (e) {
      debugPrint('Connection error: $e');
      state = state.copyWith(
        uiState: state.uiState.copyWith(
          connectionStatus: ConnectionStatusUi.error,
          statusMessage: 'Connection failed',
        ),
        action: VoiceChatPageAction.showError('Connection failed: $e'),
      );
    }
  }

  /// Disconnect from OpenAI Realtime API
  Future<void> onDisconnect() async {
    await _stopRecording();
    await _client?.disconnect();
    _client = null;

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        connectionStatus: ConnectionStatusUi.disconnected,
        statusMessage: 'Disconnected',
        isRecording: false,
        isAiSpeaking: false,
      ),
    );
  }

  /// Start recording when mic button is pressed
  Future<void> onMicPressed() async {
    debugPrint('onMicPressed called');
    debugPrint('connectionStatus: ${state.uiState.connectionStatus}');
    debugPrint('isConnected: ${state.uiState.connectionStatus.isConnected}');
    debugPrint('isAiSpeaking: ${state.uiState.isAiSpeaking}');
    debugPrint('hasMicPermission: ${state.uiState.hasMicPermission}');

    if (!state.uiState.connectionStatus.isConnected) {
      debugPrint('Not connected, returning');
      return;
    }
    if (state.uiState.isAiSpeaking) {
      debugPrint('AI is speaking, returning');
      return;
    }

    try {
      debugPrint('Starting recording...');
      // Start recording with PCM format
      final stream = await _recorder!.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 24000,
          numChannels: 1,
        ),
      );
      debugPrint('Recording stream started');

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          isRecording: true,
          statusMessage: 'Recording...',
        ),
      );

      // Send audio chunks to OpenAI
      _audioStreamSubscription = stream.listen(
        (data) {
          debugPrint('Audio chunk received: ${data.length} bytes');
          if (_client != null && state.uiState.isRecording) {
            _client!.appendInputAudio(data);
          }
        },
        onError: (e) {
          debugPrint('Audio stream error: $e');
        },
      );
    } catch (e) {
      debugPrint('Recording error: $e');
      state = state.copyWith(
        action: VoiceChatPageAction.showError('Recording failed: $e'),
      );
    }
  }

  /// Stop recording when mic button is released
  Future<void> onMicReleased() async {
    debugPrint('onMicReleased called');
    debugPrint('isRecording: ${state.uiState.isRecording}');
    await _stopRecording();

    if (_client != null) {
      // Commit audio buffer and create response
      debugPrint('Creating response...');
      _client!.createResponse();
    }
  }

  Future<void> _stopRecording() async {
    await _audioStreamSubscription?.cancel();
    _audioStreamSubscription = null;
    await _recorder?.stop();

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        isRecording: false,
        statusMessage: state.uiState.connectionStatus.isConnected
            ? 'Processing...'
            : 'Disconnected',
      ),
    );
  }

  void _setupEventHandlers() {
    _client!.on(RealtimeEventType.conversationItemCreated, (event) {
      _handleConversationItemCreated(event);
    });

    _client!.on(RealtimeEventType.responseAudioDelta, (event) {
      _handleAudioDelta(event);
    });

    _client!.on(RealtimeEventType.responseAudioTranscriptDelta, (event) {
      _handleTranscriptDelta(event);
    });

    _client!.on(RealtimeEventType.responseAudioDone, (event) {
      _handleAudioDone();
    });

    _client!.on(RealtimeEventType.inputAudioBufferSpeechStarted, (event) {
      _handleSpeechStarted();
    });

    _client!.on(RealtimeEventType.inputAudioBufferSpeechStopped, (event) {
      _handleSpeechStopped();
    });

    _client!.on(RealtimeEventType.conversationItemInputAudioTranscriptionCompleted, (event) {
      _handleInputTranscriptionCompleted(event);
    });

    _client!.on(RealtimeEventType.error, (event) {
      _handleError(event);
    });
  }

  void _handleConversationItemCreated(RealtimeEvent event) {
    // Handle new conversation item
    debugPrint('Conversation item created: $event');
  }

  void _handleAudioDelta(RealtimeEvent event) {
    debugPrint('Audio delta received: ${event.runtimeType}');
    if (event is RealtimeEventResponseAudioDelta) {
      final audioData = base64Decode(event.delta);
      _audioBuffer.addAll(audioData);

      if (!_isPlayingAudio) {
        state = state.copyWith(
          uiState: state.uiState.copyWith(
            isAiSpeaking: true,
            statusMessage: 'AI is speaking...',
          ),
        );
      }

      // Play audio chunks as they arrive
      _playAudioChunk();
    }
  }

  void _handleTranscriptDelta(RealtimeEvent event) {
    debugPrint('Transcript delta received: ${event.runtimeType}');
    if (event is RealtimeEventResponseAudioTranscriptDelta) {
      debugPrint('Transcript: ${event.delta}');
      // Update or create assistant message with streaming transcript
      final messages = List<ChatMessageUi>.from(state.uiState.messages);
      final lastMessage = messages.isNotEmpty ? messages.last : null;

      if (lastMessage != null &&
          lastMessage.sender == ChatSenderUi.assistant &&
          lastMessage.isStreaming) {
        // Update existing streaming message
        messages[messages.length - 1] = ChatMessageUi(
          id: lastMessage.id,
          sender: ChatSenderUi.assistant,
          content: lastMessage.content + event.delta,
          formattedTime: lastMessage.formattedTime,
          isStreaming: true,
        );
      } else {
        // Create new streaming message
        messages.add(ChatMessageUi(
          id: _uuid.v4(),
          sender: ChatSenderUi.assistant,
          content: event.delta,
          formattedTime: _dateFormat.format(DateTime.now()),
          isStreaming: true,
        ));
      }

      state = state.copyWith(
        uiState: state.uiState.copyWith(messages: messages),
        action: VoiceChatPageAction.scrollToBottom(),
      );
    }
  }

  void _handleAudioDone() {
    // Finalize streaming message
    final messages = List<ChatMessageUi>.from(state.uiState.messages);
    if (messages.isNotEmpty && messages.last.isStreaming) {
      messages[messages.length - 1] = ChatMessageUi(
        id: messages.last.id,
        sender: messages.last.sender,
        content: messages.last.content,
        formattedTime: messages.last.formattedTime,
        isStreaming: false,
      );
    }

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        messages: messages,
        isAiSpeaking: false,
        statusMessage: 'Hold mic to speak',
      ),
    );
  }

  void _handleSpeechStarted() {
    debugPrint('Speech started (VAD detected voice)');
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        statusMessage: 'Listening...',
      ),
    );
  }

  void _handleSpeechStopped() {
    debugPrint('Speech stopped (VAD detected silence)');
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        statusMessage: 'Processing...',
      ),
    );
  }

  void _handleInputTranscriptionCompleted(RealtimeEvent event) {
    debugPrint('Input transcription completed: ${event.runtimeType}');
    if (event is RealtimeEventConversationItemInputAudioTranscriptionCompleted) {
      final transcript = event.transcript;
      debugPrint('User transcript: $transcript');
      if (transcript.isNotEmpty) {
        // Add user message
        final messages = List<ChatMessageUi>.from(state.uiState.messages);
        messages.add(ChatMessageUi(
          id: _uuid.v4(),
          sender: ChatSenderUi.user,
          content: transcript,
          formattedTime: _dateFormat.format(DateTime.now()),
          isStreaming: false,
        ));

        state = state.copyWith(
          uiState: state.uiState.copyWith(
            messages: messages,
            currentTranscript: null,
          ),
          action: VoiceChatPageAction.scrollToBottom(),
        );
      }
    }
  }

  void _handleError(RealtimeEvent event) {
    if (event is RealtimeEventError) {
      debugPrint('Realtime error: ${event.error}');
      state = state.copyWith(
        action: VoiceChatPageAction.showError('Error: ${event.error.message}'),
      );
    }
  }

  Future<void> _playAudioChunk() async {
    if (_isPlayingAudio || _audioBuffer.isEmpty) return;
    _isPlayingAudio = true;

    try {
      // Create WAV header for PCM data
      final wavData = _createWavFromPcm(Uint8List.fromList(_audioBuffer));
      _audioBuffer.clear();

      // Play using just_audio
      await _player?.setAudioSource(
        _BytesAudioSource(wavData),
      );
      await _player?.play();
    } catch (e) {
      debugPrint('Audio playback error: $e');
    } finally {
      _isPlayingAudio = false;
      // Check if more audio arrived while playing
      if (_audioBuffer.isNotEmpty) {
        _playAudioChunk();
      }
    }
  }

  Uint8List _createWavFromPcm(Uint8List pcmData) {
    const sampleRate = 24000;
    const numChannels = 1;
    const bitsPerSample = 16;
    final byteRate = sampleRate * numChannels * bitsPerSample ~/ 8;
    final blockAlign = numChannels * bitsPerSample ~/ 8;
    final dataSize = pcmData.length;
    final fileSize = 36 + dataSize;

    final header = ByteData(44);
    // RIFF header
    header.setUint8(0, 0x52); // R
    header.setUint8(1, 0x49); // I
    header.setUint8(2, 0x46); // F
    header.setUint8(3, 0x46); // F
    header.setUint32(4, fileSize, Endian.little);
    header.setUint8(8, 0x57);  // W
    header.setUint8(9, 0x41);  // A
    header.setUint8(10, 0x56); // V
    header.setUint8(11, 0x45); // E
    // fmt chunk
    header.setUint8(12, 0x66); // f
    header.setUint8(13, 0x6D); // m
    header.setUint8(14, 0x74); // t
    header.setUint8(15, 0x20); // space
    header.setUint32(16, 16, Endian.little); // chunk size
    header.setUint16(20, 1, Endian.little); // audio format (PCM)
    header.setUint16(22, numChannels, Endian.little);
    header.setUint32(24, sampleRate, Endian.little);
    header.setUint32(28, byteRate, Endian.little);
    header.setUint16(32, blockAlign, Endian.little);
    header.setUint16(34, bitsPerSample, Endian.little);
    // data chunk
    header.setUint8(36, 0x64); // d
    header.setUint8(37, 0x61); // a
    header.setUint8(38, 0x74); // t
    header.setUint8(39, 0x61); // a
    header.setUint32(40, dataSize, Endian.little);

    return Uint8List.fromList([
      ...header.buffer.asUint8List(),
      ...pcmData,
    ]);
  }

  void _dispose() {
    _audioStreamSubscription?.cancel();
    _recorder?.dispose();
    _player?.dispose();
    _client?.disconnect();
  }
}

/// Audio source for playing byte data
class _BytesAudioSource extends StreamAudioSource {
  final Uint8List _bytes;

  _BytesAudioSource(this._bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= _bytes.length;
    return StreamAudioResponse(
      sourceLength: _bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(_bytes.sublist(start, end)),
      contentType: 'audio/wav',
    );
  }
}
