

import 'package:vu/application/bloc/applicationEvents.dart';
import 'package:vu/application/bloc/applicationStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationBloc extends Bloc<ApplicationPageEvents,ApplicationPageStates>{
  ApplicationBloc():super(ApplicationPageStates()){
   on<PageEvent>(_applicationPageEvent);
  }
  void _applicationPageEvent (PageEvent event , Emitter<ApplicationPageStates> emit){
    emit(state.copyWith(page: event.page));
  }
}