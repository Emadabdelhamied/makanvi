import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/custom_network.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../../chat/presentation/pages/chat_screen.dart';
import '../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../listining_seller/presentation/pages/property_details.dart';
import '../../../listining_seller/presentation/widgets/rate_shooting/dialog_rating_shoot.dart';
import '../../../payment/presentation/widget/dialog_select_shoting.dart';
import '../../data/models/notification_model.dart';

class CardNotication extends StatelessWidget {
  CardNotication({super.key, required this.notifcationCalss});
  final NotifcationCalss notifcationCalss;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: notifcationCalss.destination == "Chat"
          ? null
          : () {
              if (notifcationCalss.destination == "Property") {
                sl<AppNavigator>().push(
                    screen: PropertyDetails(
                        listingId: notifcationCalss.destinationId.toString()));
              } else if (notifcationCalss.destination == "RateShooting") {
                showDialog(
                    // barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0.r))),
                        content: DialogRateShotting(
                          propertyId: notifcationCalss.destinationId!,
                        ),
                      );
                    });
              } else if (notifcationCalss.destination == "ShootingDate") {
                showDialog(
                    // barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0.r))),
                        content: DialogSelectShotting(
                          listingId: notifcationCalss.destinationId.toString(),
                        ),
                      );
                    });
              } else if (notifcationCalss.destination == "Home") {
                context.read<HomeSellerCubit>().setcurrentIndexSellerHome = 0;
              }
            },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: 110.h,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: cardBackground, borderRadius: BorderRadius.circular(16.r)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: white,
                child: notifcationCalss.profilePhotoPath == null
                    ? CircleAvatar(
                        radius: 28.r,
                        backgroundImage: AssetImage(appIcon),
                      )
                    : CircleAvatar(
                        radius: 28.r,
                        backgroundImage: NetworkImage(
                            notifcationCalss.profilePhotoPath!.contains("http")
                                ? notifcationCalss.profilePhotoPath!
                                : EndPoints.baseImages +
                                    notifcationCalss.profilePhotoPath!),
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
                      notifcationCalss.title,
                      style: TextStyles.textViewMedium14
                          .copyWith(color: textColor),
                    ),
                    notifcationCalss.destination == "Chat"
                        ? RichText(
                            text: TextSpan(
                                text:
                                    "Just messaged you. Check the message in ",
                                style: TextStyles.textViewMedium12
                                    .copyWith(color: textColorLight),
                                children: [
                                  TextSpan(
                                      text: "message tab.",
                                      style: TextStyles
                                          .textViewMedium12Underline
                                          .copyWith(color: textColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          if (notifcationCalss.destination ==
                                              "Chat") {
                                            sl<AppNavigator>().push(
                                                screen: ChatScreen(
                                              channelID: notifcationCalss
                                                  .destinationId!,
                                              name: notifcationCalss.name,
                                              imagePath: notifcationCalss
                                                      .profilePhotoPath ??
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
                                    text: notifcationCalss.body,
                                    style: TextStyles.textViewMedium12
                                        .copyWith(color: textColor),
                                  )
                                ]),
                          ),
                    // Spacer(),
                    Text(
                      notifcationCalss.sendAt,
                      style: TextStyles.textViewMedium12.copyWith(color: gray2),
                    )
                  ],
                ),
              ),
              notifcationCalss.imagePath == null
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
                            image: EndPoints.baseImages +
                                notifcationCalss.imagePath!),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class NoticationCalssTest {
  final String? title;
  final String? imagePerson;
  final String? image;
  final String? descrption;
  final String? time;
  final String? type;

  NoticationCalssTest(
      {this.title,
      this.imagePerson,
      this.image,
      this.descrption,
      this.time,
      this.type});
}
