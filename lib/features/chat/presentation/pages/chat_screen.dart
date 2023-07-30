// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/bloc/main_cubit/bloc_main_cubit.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';
import 'package:makanvi_web/core/constant/styles/styles.dart';
import 'package:makanvi_web/core/pusher/pusher.dart';
import 'package:makanvi_web/core/util/end_points.dart';
import 'package:makanvi_web/core/widgets/error_screen.dart';
import 'package:makanvi_web/core/widgets/loading.dart';
import 'package:makanvi_web/features/chat/presentation/cubit/chat_cubit.dart';
import '../../../../core/util/navigator.dart';
import '../../../../core/util/paginate_loading.dart';
import '../../../../injection_container.dart';
import '../../../home_buyer/presentation/cubit/home_buyer_cubit/home_buyer_cubit.dart';
import '../../../home_buyer/presentation/pages/home_main_buyer.dart';
import '../../../seller_pages/home_seller/presentation/cubit/home_cubit.dart';
import '../../../seller_pages/home_seller/presentation/pages/home_main_seller.dart';
import '../widgets/chat_appbar.dart';
import '../widgets/chat_field.dart';
import '../widgets/sender_and_reciver.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
      {super.key,
      required this.channelID,
      required this.name,
      this.propertyId,
      this.fromChatList = false,
      required this.imagePath});
  final int channelID;
  final String name;
  final bool fromChatList;
  final String imagePath;
  int? propertyId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = ScrollController();
  bool showbtn = false;
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().removeMessage();
    context.read<ChatCubit>().fGetAllMessageChat(
        channelId: widget.channelID,
        first: true,
        propertyId: widget.propertyId);

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    // await Future.delayed(const Duration(seconds: 2));
    // await PusherClient.client.subscribe("presence-chat.${widget.channelID}");
    // });
    PusherClient.client?.close();
    BlocProvider.of<ChatCubit>(context, listen: false)
        .initPusher(context: context, channelID: widget.channelID);
    // BlocProvider.of<ChatCubit>(context, listen: false)
    // .initChannelAndEvent(chanelId: widget.channelID);
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop =
            _controller.position.maxScrollExtent == _controller.position.pixels;
        if (isTop) {
          log('At the top');
          context
              .read<ChatCubit>()
              .fGetAllMessageChat(channelId: widget.channelID, ifIsMore: true);
        } else {
          log('At the bottom');
        }
      }
    });
    _controller.addListener(() {
      //scroll listener
      double showoffset =
          10.0; //Back to top botton will show on scroll offset 10.0

      if (_controller.offset > showoffset) {
        showbtn = true;
        setState(() {
          //update state
        });
      } else {
        showbtn = false;
        setState(() {
          //update state
        });
      }
    });
    // handleScroll();
  }

  @override
  void dispose() {
    PusherClient.client?.unsubscribe("presence-chat.${widget.channelID}");
    PusherClient.client?.close();

    super.dispose();
  }

  // function to convert time stamp to date
  static DateTime returnDateAndTimeFormat(String time) {
    var dt = DateTime.parse((time.toString()));
    return DateTime(dt.year, dt.month, dt.day);
  }

  @override
  Widget build(BuildContext context) {
    String groupMessageDateAndTime(String time) {
      var dt = DateTime.parse((time.toString()));
      final todayDate = DateTime.now();

      final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
      final yesterday =
          DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
      String difference = '';
      final aDate = DateTime(dt.year, dt.month, dt.day);

      if (aDate == today) {
        difference = tr("Today");
      } else if (aDate == yesterday) {
        difference = tr("Yesterday");
      } else {
        difference =
            DateFormat.yMMMd(Localizations.localeOf(context).languageCode)
                .format(dt)
                .toString();
      }

      return difference;
    }

    var mainCubit = context.read<BlocMainCubit>();
    var chatCubit = context.watch<ChatCubit>();
    return WillPopScope(
      onWillPop: () async {
        if (chatCubit.emojiShowing) {
          setState(() {
            chatCubit.emojiShowing = false;
          });

          return false;
        }
        if (widget.fromChatList) {
          chatCubit.emojiShowing = false;
          context.read<BlocMainCubit>().repository.loadAppData()!.modeUserNow ==
                  "seller"
              ? context.read<HomeSellerCubit>().setcurrentIndexSellerHome = 3
              : context.read<HomeBuyerCubit>().setcurrentIndexBuyerHome = 3;
          context.read<BlocMainCubit>().repository.loadAppData()!.modeUserNow ==
                  "seller"
              ? await sl<AppNavigator>()
                  .pushToFirst(screen: const HomeMainSeller())
              : await sl<AppNavigator>()
                  .pushToFirst(screen: const HomeMainBuyer());

          return false;
        } else {
          sl<AppNavigator>().pop();
          return false;
        }
      },
      child: Scaffold(
        floatingActionButton: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
            ),
            SizedBox(
              width: 35,
              height: 35,
              child: AnimatedOpacity(
                duration:
                    const Duration(milliseconds: 1000), //show/hide animation
                opacity:
                    showbtn ? 1.0 : 0.0, //set obacity to 1 on visible, or hide
                child: FloatingActionButton(
                  onPressed: () {
                    _controller.animateTo(
                        //go to top of scroll
                        0, //scroll offset to go
                        duration: const Duration(
                            milliseconds: 500), //duration of scroll
                        curve: Curves.fastOutSlowIn //scroll type
                        );
                  },
                  backgroundColor: iconColor,
                  child: Icon(Icons.keyboard_double_arrow_down_outlined),
                ),
              ),
            ),
          ],
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: ChatAppBar(
          title: widget.name,
          fromChat: widget.fromChatList,
          image: widget.imagePath.isEmpty
              ? EndPoints.placeholder
              : widget.imagePath.contains("http")
                  ? widget.imagePath
                  : EndPoints.baseImages + widget.imagePath,
          status: chatCubit.getCountMember != 2 ? 'Offline' : 'Online',
          name: widget.name,
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatListAllMessageLoadingState) {
              return const Center(
                child: Loading(),
              );
            } else {
              if (state is ChatListAllMessageSuccessLoadingState ||
                  state is AddMessageToModelState ||
                  state is ChatListAllMessagePaginationLoadingState) {
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.r),
                            color: cardBackground),
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: chatCubit.getMessages.isEmpty
                                  ? const Center(child: Text("No Message Yet"))
                                  : SingleChildScrollView(
                                      controller: _controller,
                                      physics: const BouncingScrollPhysics(),
                                      reverse: true,
                                      child: ListView.builder(
                                          // controller: _controller,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          reverse: true,
                                          itemCount:
                                              chatCubit.getMessages.length,
                                          itemBuilder: (context, index) {
                                            bool isSameDate = false;
                                            String? newDate = '';

                                            if (index == 0 &&
                                                chatCubit.getMessages.length ==
                                                    1) {
                                              newDate = groupMessageDateAndTime(
                                                      chatCubit
                                                          .getMessages[index]
                                                          .date
                                                          .toString())
                                                  .toString();
                                            } else if (index ==
                                                chatCubit.getMessages.length -
                                                    1) {
                                              newDate = groupMessageDateAndTime(
                                                      chatCubit
                                                          .getMessages[index]
                                                          .date
                                                          .toString())
                                                  .toString();
                                            } else {
                                              final DateTime date =
                                                  returnDateAndTimeFormat(
                                                      chatCubit
                                                          .getMessages[index]
                                                          .date
                                                          .toString());
                                              final DateTime prevDate =
                                                  returnDateAndTimeFormat(
                                                      chatCubit
                                                          .getMessages[
                                                              index + 1]
                                                          .date
                                                          .toString());
                                              isSameDate = date
                                                  .isAtSameMomentAs(prevDate);

                                              newDate = isSameDate
                                                  ? ''
                                                  : groupMessageDateAndTime(
                                                          chatCubit
                                                              .getMessages[
                                                                  index]
                                                              .date
                                                              .toString())
                                                      .toString();
                                            }
                                            if (chatCubit.getMessages.length ==
                                                index) {
                                              if (state
                                                  is ChatListAllMessagePaginationLoadingState) {
                                                return const Loading();
                                              } else {
                                                return const SizedBox();
                                              }
                                            }
                                            if (index ==
                                                chatCubit.getMessages.length) {
                                              if (state
                                                  is ChatListAllMessagePaginationLoadingState) {
                                                return const PaginateLoading();
                                              } else {
                                                return const SizedBox();
                                              }
                                            }
                                            var item =
                                                chatCubit.getMessages[index];
                                            var itemPrev = chatCubit
                                                    .getMessages[
                                                index - 1 < 0 ? 0 : index - 1];

                                            return Column(
                                              children: [
                                                if (newDate.isNotEmpty)
                                                  Center(
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xffE3D4EE),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        12),
                                                            child: Text(
                                                              newDate,
                                                              style: TextStyles
                                                                  .textViewMedium14
                                                                  .copyWith(
                                                                      color:
                                                                          black),
                                                            ),
                                                          ))),
                                                SenderAndReciverMessage(
                                                  isRead: item.id.isEven,
                                                  avatar: widget
                                                          .imagePath.isEmpty
                                                      ? EndPoints.placeholder
                                                      : widget.imagePath
                                                              .contains("https")
                                                          ? widget.imagePath
                                                          : EndPoints
                                                                  .baseImages +
                                                              widget.imagePath,
                                                  isMine: (mainCubit.repository
                                                              .loadAppData()!
                                                              .id ==
                                                          item.senderId
                                                              .toString())
                                                      ? true
                                                      : false,
                                                  time: (itemPrev.time ==
                                                              item.time &&
                                                          itemPrev.senderId ==
                                                              item.senderId &&
                                                          itemPrev.receiverId ==
                                                              item.receiverId)
                                                      ? ''
                                                      : item.time,
                                                  message: item.body,
                                                  propertyMessage:
                                                      item.property,
                                                  createAt: item.createdAt,
                                                  // image: "", isMine: mesaage[index].isMe,
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                            ),
                            ChatTextField(
                              channelId: widget.channelID,
                              onSend: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const ErrorScreen();
              }
            }
          },
        ),
        // ),
      ),
    );
  }
}

class MessagTest {
  final String message;
  final bool isMe;
  final String type;

  MessagTest({required this.message, required this.isMe, required this.type});
}
