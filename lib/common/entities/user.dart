
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vu/common/entities/entities.dart';



class LoginEntity{
  String? email;
  String? password;

  LoginEntity({this.password,this.email});

  Map<String,dynamic> toJson ()=> {
    "email":email,
    "password":password
  };
}


class VerifyResponseEntity{
  int? code;
  Map<String,dynamic>? data;

  VerifyResponseEntity({
    this.code,
    this.data,
  });

  factory VerifyResponseEntity.fromJson({required int code,required Map<String, dynamic> data}) =>
      VerifyResponseEntity(
        code: code,
        data: data,
      );
}


class RegisterEntity {
  String? first_name;
  String? last_name;
  String? email;
  String? password;


  RegisterEntity({
    this.first_name,
    this.last_name,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => {
    "firstname": first_name,
    "lastname": last_name,
    "email": email,
    "password":password,
  };
}

//api post response msg
class UserLoginResponseEntity {
  int? code;
  Map<String,dynamic>? data;

  UserLoginResponseEntity({
    this.code,
    this.data,
  });

  factory UserLoginResponseEntity.fromJson({required int code,required Map<String, dynamic> data}) =>
      UserLoginResponseEntity(
        code: code,
        data: data,
      );
}




// login result
class UserItem {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  int? phone;
  String? avatar;


  UserItem({
    this.uid,
    this.firstname,
    this.lastname,
    this.phone,
    this.email,
    this.avatar,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) =>
      UserItem(
        uid: json["uid"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["image"],
      );

  Map<String, dynamic> toJson() => {
    "uid":uid,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "avatar": avatar,
  };
}

class UserData {
  final String? token;
  final String? name;
  final String? avatar;
  final String? description;
  final int? online;

  UserData({
    this.token,
    this.name,
    this.avatar,
    this.description,
    this.online,
  });

  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return UserData(
      token: data?['token'],
      name: data?['name'],
      avatar: data?['avatar'],
      description: data?['description'],
      online: data?['online'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (token != null) "token": token,
      if (name != null) "name": name,
      if (avatar != null) "avatar": avatar,
      if (description != null) "description": description,
      if (online != null) "online": online,
    };
  }
}

class UserResponse{
  int? code;
  List<UserItem>? users;

  UserResponse({this.code, this.users});

  factory UserResponse.fromJson({required int status, required Map<String, dynamic> data})=>UserResponse(code: status,users:  data["data"] == null
      ? []
      : List<UserItem>.from(data["data"].map((x)=>UserItem.fromJson(x))));
}


class ChatListRequestEntity{
  final String senderId;
  final String recieverId;

  ChatListRequestEntity({required this.senderId,required this.recieverId});

  Map<String,dynamic> toJson(){
    return {"senderId":this.senderId,"recieverId":this.recieverId};
  }

}

