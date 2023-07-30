import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/util/navigator.dart';
import '../../../../core/widgets/appbar_generic.dart';
import '../../../../core/widgets/error_screen.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../injection_container.dart';
import '../../../home_buyer/presentation/cubit/home_buyer_cubit/home_buyer_cubit.dart';
import '../../../seller_pages/home_seller/presentation/cubit/home_cubit.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/remove_list_cubit/remove_list_cubit.dart';
import '../widgets/chat_hader_card.dart';
import '../widgets/delete_all_chat_dialog.dart';
import '../widgets/delete_chat_dialog.dart';
import '../widgets/empty_chat_widget.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modeUser =
        context.read<BlocMainCubit>().repository.loadAppData()!.modeUserNow;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<ChatCubit>()..fGetListChat(),
        ),
        BlocProvider(
          create: (BuildContext context) => sl<RemoveListCubit>(),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          modeUser == "seller"
              ? context.read<HomeSellerCubit>().setcurrentIndexSellerHome = 0
              : context.read<HomeBuyerCubit>().setcurrentIndexBuyerHome = 0;
          return false;
        },
        child: Scaffold(
          appBar: AppBarGeneric(
            title: tr("message"),
            titleColor: textColor,
            onPressed: () {
              modeUser == "seller"
                  ? context.read<HomeSellerCubit>().setcurrentIndexSellerHome =
                      0
                  : context.read<HomeBuyerCubit>().setcurrentIndexBuyerHome = 0;
            },
            actions: [
              InkWell(
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0.r))),
                          content: const DeleteAllChatDialog(),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(DeleteSvg),
                ),
              )
            ],
          ),
          body: BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is ChatListLoadingState) {
                return const Center(
                  child: Loading(),
                );
              }
              if (state is ChatListSuccessLoadingState) {
                return context.watch<ChatCubit>().channels.isEmpty
                    ? const EmptyChatWidget()
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: RefreshIndicator(
                          backgroundColor: white,
                          color: textColorLight,
                          triggerMode: RefreshIndicatorTriggerMode.onEdge,
                          onRefresh: () => context
                              .read<ChatCubit>()
                              .fGetListChat(isPulled: true),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                context.watch<ChatCubit>().channels.length,
                            itemBuilder: (context, index) {
                              var item =
                                  context.watch<ChatCubit>().channels[index];
                              // var item = users[index];
                              return InkWell(
                                onTap: () async {
                                  await BlocProvider.of<ChatCubit>(context,
                                          listen: false)
                                      .initPusher(
                                          context: context,
                                          channelID: item.onChannelId);

                                  // // ignore: use_build_context_synchronously
                                  // await BlocProvider.of<ChatCubit>(context,
                                  //         listen: false)
                                  //     .initChannelAndEvent(
                                  //         chanelId: item.onChannelId);

                                  await sl<AppNavigator>().push(
                                      screen: ChatScreen(
                                    channelID: item.onChannelId,
                                    fromChatList: true,
                                    name: item.chatWith.name,
                                    imagePath:
                                        item.chatWith.profilePhotoPath ?? "",
                                  ));
                                  modeUser == "seller"
                                      ? context
                                          .read<HomeSellerCubit>()
                                          .setcurrentIndexSellerHome = 0
                                      : context
                                          .read<HomeBuyerCubit>()
                                          .setcurrentIndexBuyerHome = 0;
                                },
                                child: Dismissible(
                                  key: UniqueKey(),
                                  behavior: HitTestBehavior.translucent,
                                  onDismissed: (direction) {
                                    String action;
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      action = "deleted";
                                    } else {
                                      action = "archived";
                                    }
                                  },
                                  confirmDismiss: (direction) async {
                                    return await showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0.r))),
                                            content: DeleteChat(
                                              channelId: item.onChannelId,
                                            ),
                                          );
                                        });
                                  },
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: ChatHeaderCard(
                                      message: item.lastMsg.body,
                                      name: item.chatWith.name,
                                      date: item.lastMsg.time.toString(),
                                      count: item.unseenCount.toString(),

                                      // date: DateFormat('kk:mm:a')
                                      //     .format(item.lastMsg.createdAt),
                                      image:
                                          item.chatWith.profilePhotoPath ?? ""),
                                ),
                              );
                            },
                          ),
                        ),
                      );
              } else {
                return const ErrorScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
