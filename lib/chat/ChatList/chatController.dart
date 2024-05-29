

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/chat/ChatList/bloc/ChatListBloc.dart';

import 'package:vu/common/apis/user_api.dart';
import 'package:vu/common/entities/entities.dart';

import 'bloc/ChatListEvents.dart';


class ChatController{
  late BuildContext context;
  ChatController(this.context);

  Future<void> init() async {
   var res = await UserAPI.findConncetedUsers();
   List<UserItem> users = res.users??[];
   context.read<ChatListBloc>().add(UserEvent(users));
  }
}