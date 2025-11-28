import 'package:flutter/material.dart';

import 'chat_bubble.dart';
import 'chat_message_ui.dart';
import 'voice_chat_ui_state.dart';
import 'voice_input_button.dart';

/// Voice Chat Page Template
/// Pure UI layout without any state management
class VoiceChatPageTemplate extends StatelessWidget {
  const VoiceChatPageTemplate({
    super.key,
    required this.uiState,
    required this.scrollController,
    required this.onConnectPressed,
    required this.onDisconnectPressed,
    required this.onMicPressed,
    required this.onMicReleased,
  });

  final VoiceChatPageUiState uiState;
  final ScrollController scrollController;
  final VoidCallback onConnectPressed;
  final VoidCallback onDisconnectPressed;
  final VoidCallback onMicPressed;
  final VoidCallback onMicReleased;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Chat'),
        actions: [
          _buildConnectionStatusChip(context),
          const SizedBox(width: 8),
          _buildConnectionButton(context),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(context),
          ),
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildConnectionStatusChip(BuildContext context) {
    final status = uiState.connectionStatus;
    final color = switch (status) {
      ConnectionStatusUi.connected => Colors.green,
      ConnectionStatusUi.connecting => Colors.orange,
      ConnectionStatusUi.error => Colors.red,
      ConnectionStatusUi.disconnected => Colors.grey,
    };

    return Chip(
      avatar: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      label: Text(
        status.displayName,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildConnectionButton(BuildContext context) {
    final isConnected = uiState.connectionStatus.isConnected;
    final isConnecting =
        uiState.connectionStatus == ConnectionStatusUi.connecting;

    return IconButton(
      onPressed: isConnecting
          ? null
          : (isConnected ? onDisconnectPressed : onConnectPressed),
      icon: Icon(
        isConnected ? Icons.link_off : Icons.link,
      ),
      tooltip: isConnected ? 'Disconnect' : 'Connect',
    );
  }

  Widget _buildMessageList(BuildContext context) {
    if (uiState.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Start a conversation',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hold the microphone button to speak',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: uiState.messages.length + (uiState.currentTranscript != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < uiState.messages.length) {
          return ChatBubble(message: uiState.messages[index]);
        }
        // Show current transcript as streaming message
        return ChatBubble(
          message: ChatMessageUi(
            id: 'current_transcript',
            sender: ChatSenderUi.user,
            content: uiState.currentTranscript!,
            formattedTime: '',
            isStreaming: true,
          ),
        );
      },
    );
  }

  Widget _buildInputArea(BuildContext context) {
    final isConnected = uiState.connectionStatus.isConnected;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Status message
            if (uiState.statusMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  uiState.statusMessage,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            // Recording indicator
            if (uiState.isRecording)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Recording...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            // AI speaking indicator
            if (uiState.isAiSpeaking)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.volume_up,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'AI is speaking...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            // Microphone button
            VoiceInputButton(
              isRecording: uiState.isRecording,
              isEnabled: isConnected && !uiState.isAiSpeaking,
              onPressed: onMicPressed,
              onReleased: onMicReleased,
            ),
            const SizedBox(height: 8),
            // Help text
            Text(
              isConnected
                  ? 'Hold to speak'
                  : 'Connect to start',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
