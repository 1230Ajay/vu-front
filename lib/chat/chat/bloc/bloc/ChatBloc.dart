
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/common/entities/chat.dart';

import 'ChatEvents.dart';
import 'ChatStates.dart';


class ChatBloc extends Bloc<ChatEvents,ChatState> with ChangeNotifier{
  ChatBloc():super(ChatState()){
   on<MediaButtonStateEvent>(_mediaButtonStateEvent);
   on<FreindUserItemEvent>(_freindUserItem);
   on<ChatMessageEvent>(_chatMessageEvent);
   on<ChatMessagesEvent>(_chatMessagesEvent);
   on<UpdateChateMessageEvent>(_updateChateMessageEvent);
  }


  void _mediaButtonStateEvent(MediaButtonStateEvent event,Emitter<ChatState> emit){
    emit(state.copyWith(mediaButtonState: event.mediaButtonState));
  }

  void _freindUserItem(FreindUserItemEvent event,Emitter<ChatState> emit){
    emit(state.copyWith(freindUser: event.freindUser));
  }

  void _chatMessageEvent(ChatMessageEvent event,Emitter<ChatState> emitter){
    emit(state.copyWith(chatMessage: event.chatMessage));
  }

  void _chatMessagesEvent(ChatMessagesEvent event,Emitter<ChatState> emitter){
    emit(state.copyWith(messages: event.messages));
    notifyListeners();
  }

  void _updateChateMessageEvent(UpdateChateMessageEvent event, Emitter<ChatState> emitter) {
    List<ChatMessage> messages = List.from(state.messages ?? <ChatMessage>[]); // Create a mutable copy
    messages.add(event.message_to_update);
    emit(state.copyWith(messages: messages));
    notifyListeners();
  }

}