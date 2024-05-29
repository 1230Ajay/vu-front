import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/common/entities/course.dart';
import 'package:vu/search/bloc/search_bloc.dart';
import 'package:vu/search/bloc/search_events.dart';

import '../common/apis/course_api.dart';

class MySearchController{
  late BuildContext context;
  MySearchController({required this.context});

  Future<void> init() async {
    SearchRequestEntity _searchRequestEntity = SearchRequestEntity(search:context.read<SearchBloc>().state.searchItem);
  var data = await CourseAPI.SearchedCourseList(search:_searchRequestEntity);
  List<CourseItem> SeachResult = data.data??<CourseItem>[];

  context.read<SearchBloc>().add(TriggerSearchEvent(courseItem: SeachResult));
  }
}