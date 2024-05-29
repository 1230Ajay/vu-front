
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/values/colors.dart';
import '../global.dart';
import '../global_web_socket.dart';
import 'application_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int _index = 0;

  late String userId;



  @override
  void didChangeDependencies() {

    GlobalWebSocket.init(context);

    late String userId ;

    if(Global.storageService.getUserAccessToken()!="" && Global.storageService.getUserAccessToken()=="vikash"){
      userId = "d1126a39-c018-45ad-996d-e99489653d09";
    }else{
      userId = "8d3fc4b5-077f-41ea-9e34-1e0ef3128d52";
    }

    GlobalWebSocket.webSocketService.joinChat(userId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(child: buildPage(_index)
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.h),topRight: Radius.circular(20.h),),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                  )
                ]
            ),
            width: 375.w,
            height: 66.h,
            child: BottomNavigationBar(
              currentIndex: _index,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: AppColors.primaryElement,
              unselectedItemColor: AppColors.primaryFourElementText,
              onTap: (value){
                setState(() {
                  _index = value;
                });
              },

              items: bottomBarsItem,
            ),
          )
      ),
    );
  }
}