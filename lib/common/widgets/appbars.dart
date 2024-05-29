import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vu/common/widgets/common_widgets.dart';

import '../../chat/ChatList/bloc/ChatListStates.dart';
import '../../chat/chat/bloc/bloc/ChatStates.dart';
import '../values/colors.dart';

AppBar buildAppBar({required String type}) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: AppColors.primarySecondaryBackground,
        height: 1.0,
        //hiegh defines to thickness of line
      ),
    ),
    title: Center(
        child: Text(
          type,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryText),
        )),
  );
}

AppBar chatAppBar(ChatState state, {void Function()? onCall ,void Function()? onVideoCall ,void Function()? onProfile }){
 print(state.freindUser?.email);
  return AppBar(
    title:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _leftAppBar(name:"${state.freindUser?.firstname} ${state.freindUser?.lastname}", image: "${state.freindUser?.avatar}", status: true),
        _rightAppBar()
      ],
    ),
  );
}

Widget _leftAppBar({required String image,required String name,required bool status}){
  return  Container(
    child: Row(
      children: [
        Container(
          child: Container(),
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(24.w),
            image: DecorationImage(image: AssetImage("assets/icons/01.png")),
          ),
          width: 48.w,
          height: 48.w,
        ),
        Container(
          margin: EdgeInsets.only(top: 8.h,left: 12.w),
          height: 37.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: AppColors.primarySecondaryElementText),),
              reUsableText(text: status?"online":"offline",fontSize: 12)
            ],
          ),
        )
      ],
    ),
  );
}

Widget _rightAppBar(){
  return  Container(
    margin: EdgeInsets.only(right: 12.w),
    width: 64.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       GestureDetector(
         child: Image.asset("assets/icons/b_video.png",height: 28.w,width: 28.w,color: AppColors.primaryThreeElementText),
       ),
        GestureDetector(
          child: Image.asset("assets/icons/b_telephone.png",height: 28.w,width: 28.w,color: AppColors.primaryThreeElementText,),
        )
      ],
    ),
  );
}