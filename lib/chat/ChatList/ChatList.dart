
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/chat/ChatList/widgets/chat_list_widgets.dart';

import '../../common/routes/names.dart';
import '../chat/bloc/bloc/ChatBloc.dart';
import '../chat/bloc/bloc/ChatEvents.dart';
import 'bloc/ChatListBloc.dart';
import 'bloc/ChatListStates.dart';
import 'chatController.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
 late ChatController chatController;
 @override
  void didChangeDependencies() {
   chatController = ChatController(context);
   chatController.init();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: BlocBuilder<ChatListBloc,ChatListState>(builder: (context,state){
      return Container(
          child: ListView.builder(
              itemCount: state.users?.length,
              itemBuilder: (context,index){
                print(state.users![index].firstname);
            return GestureDetector(
                onTap: (){
                  context.read<ChatBloc>().add(FreindUserItemEvent(state.users![index]));
                  Navigator.of(context).pushNamed(AppRoutes.CHAT_PAGE,arguments: {"uid": state.users?.elementAt(index).uid});
                },
                child: chatListTile(name:"${state.users![index].firstname} ${state.users![index].lastname}",message: "Hello, How are you",pending_messages: 0,last_message_time: "12:30 AM",));
          }),
      );
    },),
    );

  }
}
