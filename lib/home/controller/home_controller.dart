import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/home/bloc/home_bloc.dart';
import 'package:vu/home/bloc/home_events.dart';


import '../../common/apis/course_api.dart';
import '../../global.dart';


class HomeController{

  late BuildContext context;

  static final HomeController homeController =  HomeController._internal();
  HomeController._internal();



  factory HomeController({required BuildContext context}){
    homeController.context = context;
    return homeController;
  }

  Future<void> init() async {

   if(Global.storageService.getUserAccessToken() !=null){
     var courseList= await CourseAPI.CourseList();
 
     if(courseList.status==200){
       if(context.mounted){
         context.read<HomePageBloc>().add(HomePageCourseItem(courseList.data??[]));
         return;
       }
     }else{
       if (kDebugMode) {
         return;
       }
     }
     return;
   }else{
     if (kDebugMode) {
       print("user already logged out");
       return;
     }
   }

   return;
  }

}