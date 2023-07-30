import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/custom_network.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../../chat/presentation/pages/chat_screen.dart';
import '../../../listining_seller/presentation/pages/property_details.dart';
import '../../../listining_seller/presentation/widgets/rate_shooting/dialog_rating_shoot.dart';
import '../../../payment/presentation/widget/dialog_select_shoting.dart';
import '../../data/models/home_seller_model.dart';

class RecentActivityWidget extends StatelessWidget {
  RecentActivityWidget({super.key, required this.recentlyNotificationHome});
  final List<RecentlyNotificationHome> recentlyNotificationHome;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: recentlyNotificationHome.length,
        itemBuilder: (context, index) {
          var item = recentlyNotificationHome[index];
          return InkWell(
            onTap: item.destination == "Chat"
                ? null
                : () {
                    if (item.destination == "Property") {
                      sl<AppNavigator>().push(
                          screen: PropertyDetails(
                              listingId: item.destinationId.toString()));
                    } else if (item.destination == "RateShooting") {
                      showDialog(
                          // barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15.0.r))),
                              content: DialogRateShotting(
                                propertyId: item.destinationId!,
                              ),
                            );
                          });
                    } else if (item.destination == "ShootingDate") {
                      showDialog(
                          // barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15.0.r))),
                              content: DialogSelectShotting(
                                listingId: item.destinationId.toString(),
                              ),
                            );
                          });
                    }
                  },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //height: 110.h,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: cardBackground,
                    borderRadius: BorderRadius.circular(16.r)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: white,
                      child: item.profilePhotoPath == null
                          ? CircleAvatar(
                              radius: 28.r,
                              backgroundImage: AssetImage(appIcon),
                            )
                          : CircleAvatar(
                              radius: 28.r,
                              backgroundImage: NetworkImage(
                                  item.profilePhotoPath!.contains("http")
                                      ? item.profilePhotoPath!
                                      : EndPoints.baseImages +
                                          item.profilePhotoPath!),
                            ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            item.name,
                            style: TextStyles.textViewMedium14
                                .copyWith(color: textColor),
                          ),
                          item.destination == "Chat"
                              ? RichText(
                                  text: TextSpan(
                                      text: tr("just_message_you_check"),
                                      style: TextStyles.textViewMedium12
                                          .copyWith(color: textColorLight),
                                      children: [
                                        TextSpan(
                                            text: tr("message_tap"),
                                            style: TextStyles
                                                .textViewMedium12Underline
                                                .copyWith(color: textColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                if (item.destination ==
                                                    "Chat") {
                                                  sl<AppNavigator>().push(
                                                      screen: ChatScreen(
                                                    channelID:
                                                        item.destinationId!,
                                                    name: item.name,
                                                    imagePath:
                                                        item.profilePhotoPath ??
                                                            "",
                                                  ));
                                                }
                                              })
                                      ]),
                                )
                              : RichText(
                                  text: TextSpan(
                                      text: "",
                                      style: TextStyles.textViewMedium12
                                          .copyWith(color: textColorLight),
                                      children: [
                                        TextSpan(
                                          text: "${item.body} ",
                                          style: TextStyles.textViewMedium12
                                              .copyWith(color: textColor),
                                        )
                                      ]),
                                ),
                          // Spacer(),
                          Text(
                            item.sendAt,
                            style: TextStyles.textViewMedium12
                                .copyWith(color: gray2),
                          )
                        ],
                      ),
                    ),
                    item.imagePath == null
                        ? SizedBox()
                        : Center(
                            child: Container(
                              height: 60.h,
                              width: 72.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: white,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: CustomImageWidgegt(
                                  image:
                                      EndPoints.baseImages + item.imagePath!),
                            ),
                          )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class RecentActive {
  final String? title;
  final String? imagePerson;
  final String? image;
  final String? descrption;
  final String? time;
  final String? type;

  RecentActive(
      {this.title,
      this.imagePerson,
      this.image,
      this.descrption,
      this.time,
      this.type});
}
