import 'package:vu/common/entities/entities.dart'; // Import necessary entities

class ChatState {
  final bool? mediaButtonState;
  final UserItem? freindUser; // Changed to non-nullable
  final String? chatMessage;
  final List<ChatMessage> messages;

  const ChatState({
    this.mediaButtonState,
    this.freindUser, // Made freindUser non-nullable
    this.chatMessage,
    this.messages = const <ChatMessage>[],
  });

  ChatState copyWith({
    bool? mediaButtonState,
    UserItem? freindUser,
    String? chatMessage,
    List<ChatMessage>? messages,
  }) {
    return ChatState(
      mediaButtonState: mediaButtonState ?? this.mediaButtonState,
      freindUser: freindUser ?? this.freindUser, // Updated to use provided value or current value
      chatMessage: chatMessage ?? this.chatMessage,
      messages: messages ?? this.messages,
    );
  }
}
