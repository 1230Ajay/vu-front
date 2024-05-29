import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/application/application_page.dart';
import 'package:vu/application/bloc/applicationBloc.dart';
import 'package:vu/chat/chat/bloc/bloc/ChatBloc.dart';
import 'package:vu/chat/chat/chat.dart';
import 'package:vu/common/values/constant.dart';
import 'package:vu/course/institute/institute.dart';
import 'package:vu/profile/buy_courses/bloc/buy_courses_bloc.dart';
import 'package:vu/profile/buy_courses/buy_courses.dart';
import 'package:vu/profile/my_courses/course.dart';
import 'package:vu/course/course_datail/course_detail.dart';
import 'package:vu/course/course_pay_web_view/bloc/course_pay_web_bloc.dart';
import 'package:vu/course/course_pay_web_view/course_pay_web.dart';
import 'package:vu/course/lesson/bloc/lesson_bloc.dart';
import 'package:vu/course/lesson/lesson.dart';
import 'package:vu/global.dart';
import 'package:vu/home/bloc/home_bloc.dart';
import 'package:vu/home/home.dart';
import 'package:vu/profile/bloc/profile_bloc.dart';
import 'package:vu/profile/payment_details/payment_detail.dart';
import 'package:vu/profile/payment_details/cubit/payment_detail_cubits.dart';
import 'package:vu/profile/profile.dart';
import 'package:vu/register/bloc/register_bloc.dart';
import 'package:vu/register/register.dart';
import 'package:vu/settings/settings.dart';
import 'package:vu/sign_in/bloc/sign_in_bloc.dart';
import 'package:vu/sign_in/sign_in.dart';
import 'package:vu/welcome/bloc/welcome_bloc.dart';
import 'package:vu/welcome/welcome.dart';
import '../../course/course_datail/bloc/course_detail_bloc.dart';
import '../../course/institute/cubit/institute_cubit.dart';
import '../../profile/my_courses/bloc/my_courses_bloc.dart';
import 'names.dart';


class AppPages{
  static List<PageEntity> Routes(){
    return [
      PageEntity(route: AppRoutes.INITIAL, page: const welcomePage(),bloc: BlocProvider(create: (_)=>WelcomeBloc(),)),
      PageEntity(route: AppRoutes.SIGN_IN, page: const SignInPage(),bloc:BlocProvider(create: (_)=>SignInBloc(),) ),
      PageEntity(route: AppRoutes.REGISTER, page: const RegisterPage(),bloc:BlocProvider(create: (_)=>RegisterBloc(),) ),
      PageEntity(route: AppRoutes.APPLICATION, page: const ApplicationPage(),bloc: BlocProvider(create: (_)=>ApplicationBloc(),)),
      PageEntity(route: AppRoutes.HOME, page: const HomePage(),bloc: BlocProvider(create: (_)=>HomePageBloc(),)),
      PageEntity(route: AppRoutes.SETTINGS, page: const SettingsPage()),
      PageEntity(route: AppRoutes.COURSE_DATAIL, page: const CouseDetail(),bloc: BlocProvider(create: (_)=>CourseDetailBloc(),)),
      PageEntity(route: AppRoutes.PAYMENT_WEB_VIEW, page: const PayView(),bloc: BlocProvider(create: (_)=>PayWebViewBloc(),)),
      PageEntity(route: AppRoutes.LESSON_DETAIL, page:const LessonDetail(),bloc: BlocProvider(create: (_)=>LessonBloc(),)),
      PageEntity(route: AppRoutes.PROFILE, page: const ProfilePage(),bloc: BlocProvider(create: (_)=>ProfileBloc(),)),
      PageEntity(route: AppRoutes.MY_COURSES, page: const MyCoursers(),bloc: BlocProvider(create: (_)=>MyCoursesBloc(),)),
      PageEntity(route: AppRoutes.BUY_COURSES, page: const BuyCourses(),bloc: BlocProvider(create: (_)=>BuyCoursesBloc(),)),
      PageEntity(route: AppRoutes.PAYMENT_DETAILS, page: PaymentDetails(),bloc:BlocProvider(create: (_)=>PaymentDetailCubit(),)),
      PageEntity(route: AppRoutes.INSTITUTE_PAGE, page: InstitutePage(),bloc:BlocProvider(create: (_)=>InstituteCubits(),)),
      PageEntity(route: AppRoutes.CHAT_PAGE, page: const ChatPage(),bloc: BlocProvider(create: (_)=>ChatBloc(),))
    ];
  }

  static List<BlocProvider> allBlocProviders(BuildContext context){
    List<BlocProvider> blocProviders = <BlocProvider>[];
    for (var bloc in Routes()){
      if(bloc.bloc!=null){
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  //a model that covers entire screen as we click on object
  static MaterialPageRoute GenrageRouteSettings(RouteSettings settings){

    if(settings.name!=null){
      //route name is matching or not when navigator is triggered
      var result = Routes().where((element) => element.route==settings.name);
      if(result.isNotEmpty){
        bool isNotFirstLogin = Global.storageService.getBools(key:AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME);
        if(result.first.route== AppRoutes.INITIAL && isNotFirstLogin){
          bool isLoggedIn = Global.storageService.getUserAccessToken()==null?false:true;
          if(isLoggedIn){
            return MaterialPageRoute(builder: (_)=>const ApplicationPage(),settings: settings);
          }{
            return MaterialPageRoute(builder: (_)=>const SignInPage(),settings: settings);
          }
        }
        return MaterialPageRoute(builder: (_)=>result.first.page,settings:settings );
      }
    }
    return MaterialPageRoute(builder: (_)=>const HomePage(),settings: settings);
  }
}

class PageEntity{
  String route;
  Widget page;
  dynamic bloc;
  PageEntity({required this.route,required this.page,this.bloc});
}