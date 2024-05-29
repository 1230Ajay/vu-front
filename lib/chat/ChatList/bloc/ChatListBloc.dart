
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ChatListEvents.dart';
import 'ChatListStates.dart';


class ChatListBloc extends Bloc<ChatListEvents,ChatListState>{
  ChatListBloc():super(ChatListState()){
   on<UserEvent>(_userEvent);
  }

  void _userEvent(UserEvent event,Emitter<ChatListState> emit){
    emit(state.copyWith(users: event.users));
  }

}