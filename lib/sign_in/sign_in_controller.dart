import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:vu/common/entities/entities.dart';
import 'package:vu/common/routes/names.dart';
import 'package:vu/common/values/constant.dart';
import 'package:vu/common/widgets/flutter_toast.dart';
import 'package:vu/global.dart';
import 'package:vu/home/controller/home_controller.dart';
import 'package:vu/sign_in/bloc/sign_in_bloc.dart';

import '../common/apis/user_api.dart';

class SignInController{

  final  BuildContext context;
  SignInController({required this.context});

  Future<void> SignIn()async {
    final state = context.read<SignInBloc>().state;
    try{

      LoginEntity loginEntity = LoginEntity();
      loginEntity.email =state.email;
      loginEntity.password =state.password;

      await asyncPostAllData(loginEntity);

      if(context.mounted){
        await HomeController(context: context).init();
      }

    }catch(e){
      print("error $e");
    }

  }

  Future<void> asyncPostAllData(LoginEntity loginEntity) async {

    var res = await UserAPI.login(params:loginEntity);

    try{
      if(res.code==200){
        String token = res.data["token"];
        Global.storageService.setUserToken(res.data["token"]);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        print(decodedToken["name"]);

        Global.storageService.setUsersName(decodedToken["name"].toString());
        Global.storageService.setUserUid(decodedToken["uid"].toString());
        Global.storageService.setUsersEmail(decodedToken["sub"].toString());
        Global.storageService.setUsersAvatar(decodedToken["avatar"].toString());

        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.APPLICATION, (route) => false);
      }else{
        toastInfo(msg: "Credential not Found!");
      }
    }catch(e){
      print("error is there $e");
    }

  }

}