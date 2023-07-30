import 'package:easy_localization/easy_localization.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../injection_container.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/dend_message_cubit/send_message_cubit.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, this.onSend, required this.channelId});
  final Function()? onSend;
  final int channelId;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  @override
  Widget build(BuildContext context) {
    var chatCubit = context.read<ChatCubit>();
    var sendMesageCubit = context.read<SendMessageCubit>();

    return SizedBox(
      height: context.watch<ChatCubit>().emojiShowing ? 250 : 61,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                    color: context.watch<ChatCubit>().emojiShowing
                        ? primary
                        : disabeldColor,
                    shape: BoxShape.circle),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      FocusManager.instance.primaryFocus?.unfocus();
                      chatCubit.emojiShowing = !chatCubit.emojiShowing;
                    });
                  },
                  child: Center(
                    child: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                  ],
                ),
                child: TextField(
                  controller: sendMesageCubit.messageController,
                  onTap: () {
                    if (context.watch<ChatCubit>().emojiShowing) {
                      chatCubit.emojiShowing = !chatCubit.emojiShowing;
                    }
                  },
                  cursorColor: black,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: tr("typing"),
                      hintStyle: TextStyle(color: textColor),
                      border: InputBorder.none),
                ),
              )),
              const SizedBox(width: 15),
              BlocConsumer<SendMessageCubit, SendMessageState>(
                listener: (context, state) {
                  if (state is AddMessageSuccessLoadingState) {
                    sl<ChatCubit>().fGetListChat();
                  }
                },
                builder: (context, state) {
                  if (state is AddMessageLoadingState) {
                    return Localizations.localeOf(context).languageCode == "en"
                        ? SizedBox(
                            height: 50.h,
                            width: 50.h,
                            child: Lottie.asset('assets/images/send.json'))
                        : RotatedBox(
                            quarterTurns: 2,
                            child: SizedBox(
                                height: 50.h,
                                width: 50.h,
                                child:
                                    Lottie.asset('assets/images/send.json')));
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 40.h,
                      width: 40.h,
                      decoration: const BoxDecoration(
                          color: primary, shape: BoxShape.circle),
                      child: InkWell(
                        onTap: () {
                          if (sendMesageCubit
                              .messageController.text.isNotEmpty) {
                            context.read<SendMessageCubit>().faddMessage(
                                  channelId: widget.channelId,
                                  reciverIsOnline:
                                      chatCubit.getCountMember == 2 ? 1 : 0,
                                  seen: chatCubit.getCountMember == 2 ? 1 : 0,
                                );
                          }
                        },
                        child: Center(
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Offstage(
            offstage: !chatCubit.emojiShowing,
            child: SizedBox(
                height: 190.h,
                // width: 200,
                child: EmojiPicker(
                  textEditingController: sendMesageCubit.messageController,
                  config: Config(
                    columns: 7,
                    emojiSizeMax: 32 *
                        (foundation.defaultTargetPlatform == TargetPlatform.iOS
                            ? 1.30
                            : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    gridPadding: EdgeInsets.zero,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    backspaceColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    showRecentsTab: true,
                    recentsLimit: 28,
                    replaceEmojiOnLimitExceed: false,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                    loadingIndicator: const SizedBox.shrink(),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL,
                    checkPlatformCompatibility: true,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
