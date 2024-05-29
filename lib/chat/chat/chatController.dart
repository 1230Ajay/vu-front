

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/chat/chat/bloc/bloc/ChatBloc.dart';
import 'package:vu/chat/chat/bloc/bloc/ChatEvents.dart';
import 'package:vu/chat/chat/bloc/bloc/ChatStates.dart';
import 'package:vu/common/apis/chat_api.dart';
import 'package:vu/common/entities/entities.dart';
import '../../global.dart';
import '../../global_web_socket.dart';

class ChatController{
 final BuildContext context;
 ChatController(this.context);


 Future<void> getChatList({required String reciverId, required String senderId}) async {
    ChatListRequestEntity chatListRequestEntity = ChatListRequestEntity(senderId: senderId, recieverId: reciverId);
    ChatMessageRes res= await ChatApi.getChatList(chatListRequestEntity);
    List<ChatMessage> messages = res.messages??[];
    context.read<ChatBloc>().add(ChatMessagesEvent(messages));
 }


 void sendMessage(String message,ChatBloc chatBloc,String reciver_ids){

    late String userId = Global.storageService.getUserUid()??"";
    String reciver_id = reciver_ids;

    ChatMessage chat_message = ChatMessage();
    chat_message.content= message;
    chat_message.time_stamp = DateTime.now();
    chat_message.recipientId=reciver_id;
    chat_message.senderId=userId;
    if(message!=null && message!=""){
      print("Chat message is : $chat_message");
      chatBloc.add(UpdateChateMessageEvent(chat_message));
      GlobalWebSocket.webSocketService.sendMessage(reciverUid: reciver_id, message: message, senderUid: userId);
    }
 }


}