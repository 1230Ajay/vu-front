import 'package:vu/common/entities/entities.dart';
import 'package:vu/common/values/constant.dart';
import 'package:vu/global.dart';

import '../utils/http_utils.dart';

class UserAPI{
 static login({LoginEntity? params}) async {
 try{
   var res = await HttpUtil().auth(
       path: 'auth/authenticate',
       data:params?.toJson()
   );
   print(res);
   return UserLoginResponseEntity.fromJson(code: res.statusCode!, data: res.data);
 }catch(e){
   print(e);
 }
  }

 static register({RegisterEntity? params}) async {
   var res = await HttpUtil().auth(
       path: 'auth/register',
       data:params?.toJson(),
   );
   print("data : ${params?.toJson()} ${res.statusCode}");
 }

 static Future<UserResponse> findConncetedUsers() async {
      var res =await HttpUtil().get(path: "/user/connected/users");
      print("${res.statusCode}  ${res.data}");
      Map<String,dynamic> data = {"data":res.data};
      return UserResponse.fromJson(status: res.statusCode??404,data:data);
 }
 
}

