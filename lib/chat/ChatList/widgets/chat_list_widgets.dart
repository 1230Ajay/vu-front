import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vu/common/values/constant.dart';

import '../../../common/values/colors.dart';
import '../../../common/widgets/common_widgets.dart';

Widget chatListTile({required String name,required String message,int pending_messages =0,String last_message_time=""}){
  return Container(
    margin: EdgeInsets.only(bottom: 4.h,left: 12.w,right: 12.w),
    padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
    decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1,1)
          )
        ],
        borderRadius: BorderRadius.circular(8.w)
    ),
    height: 58.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Container(
            //   height: 48.w,
            //   width: 48.w,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(28.w),
            //       image: DecorationImage(
            //           alignment: Alignment.center,
            //           image: NetworkImage("${AppConstants.BASE_URL}/${avatar.split("8080/")[1]}"))
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 6.h,left: 12.w),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: TextStyle(color: AppColors.primarySecondaryElementText,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                  reUsableText(text: "Abe Saale Gand fad dunga teri",color: AppColors.primarySecondaryElementText,fontSize: 12),
                ],
              ),
            )
          ],
        ),
        Container(
          width: 72.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              reUsableText(text: "12:05 PM",fontSize: 10),
              Container(
                width: 24.w,
                height: 16.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.sp),
                  color: AppColors.primaryElement,
                ),
                child: Center(
                  child: Text("10",style: TextStyle(color: AppColors.primaryElementText,fontSize: 10.sp),),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}