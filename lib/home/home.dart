import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vu/common/entities/entities.dart';
import 'package:vu/common/routes/names.dart';
import 'package:vu/common/values/colors.dart';
import 'package:vu/global.dart';
import 'package:vu/home/bloc/home_bloc.dart';
import 'package:vu/home/bloc/home_states.dart';
import 'package:vu/home/controller/home_controller.dart';
import 'package:vu/home/widgets/home_widgets.dart';
import 'package:vu/profile/bloc/profile_bloc.dart';
import 'package:vu/profile/bloc/profile_event.dart';

import '../common/widgets/common_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // _homeController.init();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: HomeAppBar(avatar: profile_data.avatar!),
      body:RefreshIndicator(
        onRefresh: (){
          return HomeController(context: context).init();
        },
        child:  BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {

            if(state.courses!.isEmpty){
              HomeController(context: context).init();
            }

            return Container(
              color: AppColors.primaryElementText,
              margin: EdgeInsets.symmetric(horizontal: 25.w),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: homePageText(text: "Hello", top: 24),
                  ),


                  SliverToBoxAdapter(
                    child: homePageText(
                        text: "${Global.storageService.getUsersName()??""}!",
                        color: AppColors.primaryText),
                  ),


                  SliverToBoxAdapter(
                    child: Container(
                        margin: EdgeInsets.only(top: 24.h), child: serachView(hintText: "Search")),
                  ),


                  SliverToBoxAdapter(
                    child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: sliderView(context, state)),
                  ),


                  SliverToBoxAdapter(
                    child: Container(
                      child: MenuView(),
                    ),
                  ),


                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 6.w,
                          mainAxisSpacing: 6.w,
                          childAspectRatio: 1.6),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return GestureDetector(
                          onTap: () async {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.COURSE_DATAIL, arguments: {
                              "uid": state.courses?.elementAt(index).uid
                            });
                          },
                          child: CourseGrind(state.courses![index]),
                        );
                      }, childCount: state.courses?.length),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}