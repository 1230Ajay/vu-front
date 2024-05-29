
import 'package:vu/common/entities/entities.dart';

import '../../../../common/entities/user.dart';

abstract class ChatEvents{
 const ChatEvents();
}



class MediaButtonStateEvent extends ChatEvents{
  final bool mediaButtonState;
  const MediaButtonStateEvent(this.mediaButtonState);
}

class FreindUserItemEvent extends ChatEvents{
  final UserItem freindUser;
  const FreindUserItemEvent(this.freindUser);
}

class ChatMessageEvent extends ChatEvents{
  final String chatMessage;
  const ChatMessageEvent(this.chatMessage);
}

class ChatMessagesEvent extends ChatEvents{
  final List<ChatMessage> messages;
  const ChatMessagesEvent(this.messages);
}

class UpdateChateMessageEvent extends ChatEvents{
  final ChatMessage message_to_update;
  const UpdateChateMessageEvent(this.message_to_update);
}