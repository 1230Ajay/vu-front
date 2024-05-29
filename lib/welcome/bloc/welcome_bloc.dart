import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/welcome/bloc/welcome_events.dart';
import 'package:vu/welcome/bloc/welcome_states.dart';

class WelcomeBloc extends Bloc<welcomeEvents,welcomeStates>{
  WelcomeBloc():super(welcomeStates()){
    on<PageEvent>(_welcomeEvent);
  }

  void _welcomeEvent( PageEvent event,Emitter<welcomeStates> emit){
    emit(state.copyWith(page:event.page));
  }
}