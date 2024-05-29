import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/appbars.dart';
import '../../common/widgets/common_widgets.dart';
import '../../common/widgets/text_field.dart';
import '../../global.dart';
import 'bloc/bloc/ChatBloc.dart';
import 'bloc/bloc/ChatEvents.dart';
import 'bloc/bloc/ChatStates.dart';
import 'chatController.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController _textEditingController;
  late ScrollController scrollController;
  late ChatController chatController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _textEditingController = TextEditingController();
  }

  @override
  Future<void> didChangeDependencies() async {
    chatController = ChatController(context);
    await chatController.getChatList(reciverId: context.read<ChatBloc>().state.freindUser?.uid??"", senderId: Global.storageService.getUserUid()??"");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    scrollController.dispose(); // Dispose of the ScrollController
    super.dispose();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        WidgetsBinding.instance!.addPostFrameCallback((_) => scrollToBottom());
        return Scaffold(
          appBar: chatAppBar(state),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(bottom: 90.h),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              return Row(
                                mainAxisAlignment: state.messages![index].senderId != Global.storageService.getUserUid() ? MainAxisAlignment.start : MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 8.h, left: 8.w, right: 8.h),
                                    margin: EdgeInsets.only(bottom: 8,top: 8),
                                    decoration: BoxDecoration(
                                      color: state.messages![index].senderId != Global.storageService.getUserUid()? AppColors.primaryElementText : AppColors.primaryElement,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(1, 1),
                                        )
                                      ],
                                    ),
                                    child: reUsableText(
                                      text: state.messages![index].content ?? "",
                                      color: state.messages![index].senderId != Global.storageService.getUserUid() ? AppColors.primaryElement : AppColors.primaryElementText,
                                    ),
                                    constraints: BoxConstraints(maxWidth: 248.w),
                                  ),
                                ],
                              );
                            },
                            childCount: state.messages!.isNotEmpty ? state.messages!.length : 0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0.h,
                width: 360.w,
                child: Container(
                  color: AppColors.primaryBackground,
                  constraints: BoxConstraints(maxHeight: 170.h, minHeight: 70.h),
                  padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 270.w,
                        constraints: BoxConstraints(minHeight: 50.h, maxHeight: 170.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          border: Border.all(color: AppColors.primaryFourElementText),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Container(
                              constraints: BoxConstraints(minHeight: 30.h, maxHeight: 150.h),
                              padding: EdgeInsets.only(left: 5.w),
                              width: 220.w,
                              child: appTextField("Message..", onChange: (value) {
                                context.read<ChatBloc>().add(ChatMessageEvent(value));
                              },controller:_textEditingController),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<ChatBloc>().add(MediaButtonStateEvent(state.mediaButtonState != null && state.mediaButtonState! ? false : true));
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: 40.w,
                                height: 40.w,
                                child: Image.asset("assets/icons/05.png"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          chatController.sendMessage(
                            context.read<ChatBloc>().state.chatMessage ?? "",
                            context.read<ChatBloc>(),
                            state.freindUser?.uid ?? "",
                          );
                            context.read<ChatBloc>().add(ChatMessageEvent(""));
                            _textEditingController.clear();
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryElement,
                            borderRadius: BorderRadius.circular(8.w),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                          child: Image.asset("assets/icons/send2.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              state.mediaButtonState != null && state.mediaButtonState!
                  ? Positioned(
                bottom: 82.h,
                right: 88.w,
                child: Container(
                  height: 96.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          border: Border.all(color: AppColors.primaryFourElementText),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Image.asset("assets/icons/file.png", color: AppColors.primaryElement),
                        height: 40.h,
                        width: 40.h,
                        padding: EdgeInsets.all(12.h),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          border: Border.all(color: AppColors.primaryFourElementText),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Image.asset("assets/icons/a_photo.png", color: AppColors.primaryElement),
                        height: 40.h,
                        width: 40.h,
                        padding: EdgeInsets.all(10.h),
                      ),
                    ],
                  ),
                ),
              )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
