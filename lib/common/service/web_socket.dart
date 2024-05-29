import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:vu/chat/chat/bloc/bloc/ChatBloc.dart';
import 'package:vu/chat/chat/bloc/bloc/ChatEvents.dart';
import 'package:vu/common/entities/entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../global.dart';
import '../values/constant.dart';


class WebSocketService {
  late BuildContext context;
  late final StompClient client;
  WebSocketService(this.context);

  Future<void> init() async {

    print("uid for stom ${Global.storageService.getUserUid()}");
    client = StompClient(

        config:await StompConfig(
          url: AppConstants.WEB_SOCKET_URL,
          onConnect: (da) {
            print("-------------------------- : connected to websocket");
            client.subscribe(destination: "/user/public", callback: (message)=>onMessageRecived(message));
            client.subscribe(destination: "/user/${Global.storageService.getUserUid()}/queue/message", callback: (message)=>onMessageRecived(message));

          },
          stompConnectHeaders: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Global.storageService.getUserAccessToken()}',
          },
          beforeConnect: () async {
            print('waiting to connect...');
            await Future.delayed(const Duration(milliseconds: 200));
            print('connecting...');
          },
          onWebSocketError: (dynamic error) => print(error.toString()),
        )
    );

     client.activate(); // Activate the client after initialization

  }

  Future<void> joinChat(String uid)async {
    print("trying to join Chat");
    print(client.isActive);
    client.send(destination:"/app/user.joinChat" ,body: json.encode({"uid":Global.storageService.getUserUid()}));
    print(client.isActive);
  }





  void fetUserChats({required String reciverUid,required String senderUid}){

  }

  void sendMessage({required String reciverUid,required String message,required String senderUid}){
    Map<String,dynamic> chatMessage = {
      "senderId":senderUid,
      "recipientId":reciverUid,
      "content":message
    };

    print(chatMessage);

    client.send(destination: "/app/chat",body: json.encode(chatMessage));
  }

  void onMessageRecived(StompFrame message){
   ChatMessage chatMessage = ChatMessage.fromJson(json.decode(message.body??"{}"));
   context.read<ChatBloc>().add(UpdateChateMessageEvent(chatMessage));
   print("i---------------------------------we got message-------------------------------i");
   print(message.body);
  }


}
