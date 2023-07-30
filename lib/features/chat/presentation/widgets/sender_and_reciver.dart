import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../data/models/get_all_messages_model.dart';
import 'card_propert_message.dart';

class SenderAndReciverMessage extends StatelessWidget {
  final bool isMine;
  final String? message;
  final String? image;
  final String avatar;
  final String? createAt;
  final String time;
  final bool isRead;
  final PropertyMessage? propertyMessage;
  const SenderAndReciverMessage(
      {Key? key,
      required this.isMine,
      this.message,
      this.image,
      required this.isRead,
      required this.time,
      required this.avatar,
      this.propertyMessage,
      this.createAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentLocal =
        EasyLocalization.of(context)!.currentLocale!.languageCode;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              isMine == true ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            // SizedBox(
            //   width: 5.w,
            // ),
            Column(
              crossAxisAlignment: isMine == false
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.09,
                        maxWidth: MediaQuery.of(context).size.width * 0.77),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: isMine == false
                        ? BoxDecoration(
                            borderRadius: currentLocal == "ar"
                                ? BorderRadius.only(
                                    topRight: Radius.circular(15.r),
                                    bottomLeft: Radius.circular(15.r),
                                    bottomRight: Radius.circular(15.r),
                                  )
                                : BorderRadius.only(
                                    topLeft: Radius.circular(15.r),
                                    bottomLeft: Radius.circular(15.r),
                                    bottomRight: Radius.circular(15.r),
                                  ),
                            color: white,
                          )
                        : BoxDecoration(
                            borderRadius: currentLocal == "ar"
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(15.r),
                                    bottomLeft: Radius.circular(15.r),
                                    bottomRight: Radius.circular(15.r),
                                  )
                                : BorderRadius.only(
                                    topRight: Radius.circular(15.r),
                                    bottomLeft: Radius.circular(15.r),
                                    bottomRight: Radius.circular(15.r),
                                  ),
                            color: iconColor,
                          ),
                    child: propertyMessage != null
                        ? CardPropertyMessage(
                            propertyMessage: propertyMessage!,
                            isMine: isMine,
                          )
                        : Text(
                            message!,
                            style: TextStyle(
                              fontSize: 15,
                              color: isMine == false ? textColorLight : white,
                            ),
                          ),
                    //   ),
                    // ),
                  ),
                ),
                time.isEmpty
                    ? SizedBox()
                    : Align(
                        alignment: isMine == true
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                        child: Text(
                          time,
                          style: TextStyle(
                            fontSize: 8,
                            color: textColorLight,
                          ),
                        ),
                      ),
                // if (isRead)
                //   SvgPicture.asset(
                //     readIconSvg,
                //     color: green,
                //   ),
              ],
            ),
            // SizedBox(
            //   width: 5.w,
            // ),
          ],
        ),
      ],
    );
  }
}
