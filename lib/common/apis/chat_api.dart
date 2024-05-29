
import 'package:vu/common/entities/entities.dart';
import 'package:vu/common/utils/http_utils.dart';

class ChatApi{
  static Future<ChatMessageRes> getChatList(ChatListRequestEntity chatListRequestEntity)async {
    var res =await HttpUtil().get(path: "/chat/message/${chatListRequestEntity.senderId}/${chatListRequestEntity.recieverId}");
    Map<String,dynamic> data = {"data":res.data};
    print(data["data"]);
    return ChatMessageRes.fromJson(res.statusCode!,data );
  }
}