import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/common/service/storage_service.dart';
import 'package:vu/common/service/web_socket.dart';
import 'package:vu/sign_in/bloc/sign_in_bloc.dart';
import 'common/routes/bloc_obsever.dart';

class Global{
  static late StorageService storageService;

  static Future init() async{

    Bloc.observer =await MyGlobalObserver();
    storageService = await StorageService().init();
  }
}

