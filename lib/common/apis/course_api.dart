import 'package:vu/common/entities/course.dart';
import 'package:vu/common/entities/entities.dart';
import 'package:vu/common/utils/http_utils.dart';
import 'package:vu/global.dart';

class CourseAPI{
  static Future<CourseListResponseEntity> CourseList() async {

    print("-------------- tryign to get courses list");
    print("users access token is : ${Global.storageService.getUserAccessToken()}");
    var res = await HttpUtil().get(path: "/course/courses");
    print("res : ${res.statusCode}");
    Map<String,dynamic> data = {"data":res.data};
    print("${res.statusCode} ${res.data}");
    return CourseListResponseEntity.fromJson(data: data, status: res.statusCode!);
  }


  static Future<CourseListResponseEntity> SearchedCourseList({required SearchRequestEntity search}) async {
    var res = await HttpUtil().get(path: "course/search",queryParameters: search.toJson());
    Map<String,dynamic> data = {"data":res.data};
    print("res is ----------------: ${res.statusCode}");
    return CourseListResponseEntity.fromJson(data: data, status: res.statusCode!);
  }

  static Future<CourseListDetailResponseEntity> CourseDetail({required CourseRequestEntity courseRequestEntity}) async {
    var res = await HttpUtil().get(path: "/course/course/${courseRequestEntity.toJson()["uid"]}");
    var vidRes = await HttpUtil().get(path: "/course/videos/${courseRequestEntity.toJson()["uid"]}");
    // print("-----------got videos list----------------- // ${vidRes.data.toString()}");
    Map<String,dynamic> data = res.data;
    Map<String,dynamic> videos = {"videos":vidRes.data};
    return CourseListDetailResponseEntity.fromJson(data:data,videos:videos,status: res.statusCode!);
  }
  //
  // static Future<LessonDetailResponseEntity> lessonDetail({required LessonRequestEntity lessonRequestEntity}) async {
  //   var res = await HttpUtil().get(path: "course/lesson/${lessonRequestEntity.toJson()["uid"]}");
  //   Map<String,dynamic> lesson = {"videos":res.data};
  //   return LessonDetailResponseEntity.fromJson(data:lesson,code: res.statusCode!);
  // }
  //
  static Future<CourseListResponseEntity> getCoursesInUserEnrolled() async {
    // print("trying to gett courses for users-----------------------");
    var res = await HttpUtil().get(path: "/user/enrolled/courses/5bd4a8c5-0983-446e-866d-4d5f051f7bf4");
    Map<String,dynamic> data = {"data":res.data};
    // print("fetching user courses ================================");
    // print(res.data);
    return CourseListResponseEntity.fromJson(data: data, status: res.statusCode!);
  }
  //
  static Future<AuthorResponseEntity> getAuthorDetails(AuthorRequestEntity authorRequestEntity) async {
    var res = await HttpUtil().get(path: "/user/user/${authorRequestEntity.uid}");
    var ownedcourses = await HttpUtil().get(path: "/user/ownedcourses/${authorRequestEntity.uid}");

    print("-----------------user owns these : $ownedcourses");
    Map<String,dynamic> data = res.data;
    print("---------------------User Data-----------${data}");
    Map<String,dynamic> courses = {"courses":ownedcourses.data};
    return AuthorResponseEntity.fromJson(data:data,courses: courses,status:res.statusCode!);
  }

}