import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/common/apis/course_api.dart';
import 'package:vu/global.dart';
import 'package:vu/profile/buy_courses/bloc/buy_courses_bloc.dart';
import 'package:vu/profile/buy_courses/bloc/buy_courses_events.dart';
import 'package:vu/profile/payment_details/cubit/payment_detail_cubits.dart';

class PaymentDetailsController{
  late BuildContext context;
  PaymentDetailsController({required this.context});


  void Init()async{
    context.read<PaymentDetailCubit>().loadingiHistoryPaymentDetails();
     await loadBuyCoursesData();
  }


  Future loadBuyCoursesData()async{
   //  var result = await CourseAPI.getCoursesInUserEnrolled();
   //
   //  if(result.status==200){
   //   if(context.mounted){
   //     context.read<PaymentDetailCubit>().doneLoadingiHistoryPaymentDetails();
   //     Future.delayed(Duration(microseconds: 10),()=>  context.read<PaymentDetailCubit>().historyPaymentDetails());
   //   }
   // }
  }
}