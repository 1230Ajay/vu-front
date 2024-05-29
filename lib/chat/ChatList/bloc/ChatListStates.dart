import 'package:vu/common/entities/entities.dart';


class ChatListState{
  final List<UserItem>? users;
  final bool? mediaButtonState;

  const ChatListState({this.users ,this.mediaButtonState=false});

  ChatListState copyWith({List<UserItem> users=const [],bool? mediaButtonState,UserItem? freindUser}){
    return ChatListState(users: users, mediaButtonState: mediaButtonState);
  }

}