import '../../../common/entities/user.dart';


abstract class ChatListEvents{
 const ChatListEvents();
}



class MessageEvent extends ChatListEvents{
  final String message;
  const  MessageEvent(this.message);
}

class UserEvent extends ChatListEvents{
  final List<UserItem> users;
  const UserEvent(this.users);
}