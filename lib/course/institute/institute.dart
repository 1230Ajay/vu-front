import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vu/common/values/colors.dart';
import 'package:vu/common/values/constant.dart';
import 'package:vu/common/widgets/common_widgets.dart';
import 'package:vu/course/institute/cubit/Institute_states.dart';
import 'package:vu/course/institute/cubit/institute_cubit.dart';
import 'package:vu/course/institute/institute_controller.dart';

import '../../application/application_widgets.dart';

class InstitutePage extends StatefulWidget {
  const InstitutePage({super.key});

  @override
  State<InstitutePage> createState() => _InstitutePageState();
}

class _InstitutePageState extends State<InstitutePage> {
  late InstituteController _instituteController;

  @override
  void didChangeDependencies() {
    _instituteController = InstituteController(context);
    _instituteController.Init();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<InstituteCubits, InstituteStates>(
            builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 240.h,
                    child: Stack(
                      children: [
                        // Container(
                        //   height: 180,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(18),
                        //       image: const DecorationImage(
                        //           fit: BoxFit.fitHeight,
                        //           image: AssetImage("assets/icons/background.png"))),
                        // ),
                        Positioned(
                            left: 0,
                            bottom: 2.h,
                            child: authorview(context, state)),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h,),
                  reUsableText(text: "About me",color: AppColors.primaryText,fontSize: 16),
                  reUsableText(text: state.authorItem!.description??"No Description found"),
                  SizedBox(height: 16.h,),
                  PrimaryButtons(btnName: "GO Chat", btnType: "Go Chat", onPress: (){

                  }),
                  SizedBox(height: 16.h,),
                  reUsableText(text: "My Course list",color: AppColors.primaryText,fontSize: 16),

                  ReusableCouresesList(state: state, context: context,isMediaUrlFull: false)

                ],
              ),
            ),
          );
        }));
  }

}

Widget authorview(BuildContext context ,InstituteStates state){
  var image_part = state.authorItem?.avatar?.split("8080/");
  print(image_part);
  return Row(
    children: [
      Container(
        margin: EdgeInsets.only(left: 12.w),
        // child: CircularLayoutAvatar(url: ,radius: 50),
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          height: 96.w,
          width: 96.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56.w),
            image: DecorationImage(image: NetworkImage("${AppConstants.BASE_URL}/${image_part![1]}"))
          ),

        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 16.h,left: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            reUsableText(text:state.authorItem!.name??"Anonymous",color: AppColors.primaryText,fontSize: 16),
            reUsableText(text:state.authorItem!.job??"Instructor",color: AppColors.primarySecondaryElementText),
            Row(
              children: [
                iconNum(iconPath: "assets/icons/people.png",num: 42,space: 0,size: 16),
                iconNum(iconPath: "assets/icons/star.png", num: 12,space: 12,size: 16),
                iconNum(iconPath: "assets/icons/download.png", num: 12,space: 12,size: 16),
              ],
            )
          ],
        ),
      )
    ],
  );
}



