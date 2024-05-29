import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/common/entities/course.dart';
import 'package:vu/common/entities/institute.dart';
import 'package:vu/course/institute/cubit/Institute_states.dart';

class InstituteCubits extends Cubit<InstituteStates>{
  InstituteCubits():super(InstituteStates());

    void TriggerInstituteDetail(InstituteItem instituteItem){
      emit(state.copyWith(instituteItem:instituteItem));
    }

   void  TriggerTutorDetail(AuthorItem authorItem){
      emit(state.copyWith(authorItem:authorItem));
    }

   void TriggerCourseDetail(List<CourseItem> courseItem){
      emit(state.copyWith(courseItem:courseItem));
    }

}