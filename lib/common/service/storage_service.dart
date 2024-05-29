import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vu/common/entities/entities.dart';
import 'package:vu/common/values/constant.dart';

class StorageService{

  late final SharedPreferences _preferences;
  Future<StorageService> init()async{
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBools({required String key, required bool value}){
    return _preferences.setBool(key, value);
  }

  bool getBools({required String key}){
    return _preferences.getBool(key)??false;
  }


  Future<bool> setUserToken(String value){
    return _preferences.setString(AppConstants.STORAGE_USER_ACCESS_TOKEN, value);
  }

  Future<bool> setUserRefreshToken(String value){
    return _preferences.setString(AppConstants.STORAGE_USER_REFRESH_TOKEN, value);
  }

  Future<bool> remove({required String key}){
    return _preferences.remove(key);
  }


  String? getUserAccessToken(){
    var userAccessToken = _preferences.getString(AppConstants.STORAGE_USER_ACCESS_TOKEN);
    return userAccessToken;
  }

  String getUserRefreshToken(){
    var userRefreshToken = _preferences.getString(AppConstants.STORAGE_USER_REFRESH_TOKEN);
    return userRefreshToken??"";
  }

  Future<void> setUsersName(String value){
    return _preferences.setString(AppConstants.USERS_NAME, value);
  }

  Future<void> setUserUid(String value){
    return _preferences.setString(AppConstants.USERS_UID, value);
  }

  Future<void> setUsersEmail(String value){
    return _preferences.setString(AppConstants.USERS_EMAIL, value);
  }

  Future<void> setUsersAvatar(String value){
    return _preferences.setString(AppConstants.USERS_AVATAR, value);
  }

  String? getUsersName(){
    return _preferences.getString(AppConstants.USERS_NAME);
  }

  String? getUserUid(){
    return _preferences.getString(AppConstants.USERS_UID);
  }

  String? getUsersEmail(){
    return _preferences.getString(AppConstants.USERS_EMAIL);
  }

  String? getUsersAvatar(){
    return _preferences.getString(AppConstants.USERS_AVATAR);
  }

}