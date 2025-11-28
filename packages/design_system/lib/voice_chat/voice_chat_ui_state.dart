import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_message_ui.dart';

part 'voice_chat_ui_state.freezed.dart';

/// Voice Chat Page UI State
/// Persistent data displayed on screen
@freezed
abstract class VoiceChatPageUiState with _$VoiceChatPageUiState {
  const factory VoiceChatPageUiState({
    @Default(ConnectionStatusUi.disconnected) ConnectionStatusUi connectionStatus,
    @Default([]) List<ChatMessageUi> messages,
    @Default(false) bool isRecording,
    @Default(false) bool isAiSpeaking,
    @Default('') String statusMessage,
    @Default(false) bool hasMicPermission,
    String? currentTranscript,
  }) = _VoiceChatPageUiState;
}

/// Voice Chat Page Actions
/// One-time events (dialogs, navigation, etc.)
@freezed
abstract class VoiceChatPageAction with _$VoiceChatPageAction {
  factory VoiceChatPageAction.none() = _None;
  factory VoiceChatPageAction.showError(String message) = _ShowError;
  factory VoiceChatPageAction.requestMicPermission() = _RequestMicPermission;
  factory VoiceChatPageAction.scrollToBottom() = _ScrollToBottom;
}

/// Connection status for UI
enum ConnectionStatusUi {
  disconnected,
  connecting,
  connected,
  error;

  String get displayName {
    switch (this) {
      case ConnectionStatusUi.disconnected:
        return 'Disconnected';
      case ConnectionStatusUi.connecting:
        return 'Connecting...';
      case ConnectionStatusUi.connected:
        return 'Connected';
      case ConnectionStatusUi.error:
        return 'Error';
    }
  }

  bool get isConnected => this == ConnectionStatusUi.connected;
}
