import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_ui.freezed.dart';

/// UI model for chat message
@freezed
abstract class ChatMessageUi with _$ChatMessageUi {
  const factory ChatMessageUi({
    required String id,
    required ChatSenderUi sender,
    required String content,
    required String formattedTime,
    @Default(false) bool isStreaming,
  }) = _ChatMessageUi;
}

/// Message sender type
enum ChatSenderUi {
  user,
  assistant;

  bool get isUser => this == ChatSenderUi.user;
  bool get isAssistant => this == ChatSenderUi.assistant;
}
