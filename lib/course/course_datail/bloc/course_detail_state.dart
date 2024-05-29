import 'package:vu/common/entities/course.dart';

class CourseDetailsState{

  const CourseDetailsState({this.courseItem,this.videos});
  final CourseItem? courseItem;
  final List<VideoItem>? videos;

  CourseDetailsState copyWith({CourseItem? courseItem,List<VideoItem>? videos}){
    return CourseDetailsState(courseItem: courseItem??this.courseItem,videos: videos??this.videos);
  }

}