import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/service/web_socket.dart';

class GlobalWebSocket{
  static late WebSocketService webSocketService;
  static Future init(BuildContext context) async {
    webSocketService =WebSocketService(context);
    await webSocketService.init();
  }
}