import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/end_points.dart';

class ChatHeaderCard extends StatelessWidget {
  final String name;
  final String date;
  final String image;
  final String message;
  final String count;
  const ChatHeaderCard({
    Key? key,
    required this.name,
    required this.date,
    required this.image,
    required this.message,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final mainCubit = BlocProvider.of<BlocMainCubit>(context, listen: false)
    //     .repository
    //     .loadAppData()!;
    double radius = 25;
    var currentLocal =
        EasyLocalization.of(context)!.currentLocale!.languageCode;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 85.h,
        decoration: BoxDecoration(
            color: Color(0xffF5F4F8),
            borderRadius: BorderRadius.circular(15.r)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: radius,
                        backgroundColor: white,
                        child: image.isEmpty
                            ? CircleAvatar(
                                radius: radius,
                                backgroundImage: AssetImage(person1))
                            : CircleAvatar(
                                radius: radius,
                                backgroundImage: NetworkImage(
                                    image.contains("http")
                                        ? image
                                        : EndPoints.baseImages + image),
                              ),
                      ),
                      // Positioned(
                      //   right: 0.0,
                      //   top: 0.0,
                      //   child: SvgPicture.asset(activeIconsSvg),
                      // ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        name,
                        style: TextStyles.textViewMedium16
                            .copyWith(color: textColor),
                      ),
                      Container(
                        width: 200.w,
                        child: Text(
                          message,
                          maxLines: 2,
                          style: (count.isEmpty || count == "0")
                              ? TextStyles.textViewMedium14
                                  .copyWith(color: textColor)
                              : TextStyles.textViewBold14
                                  .copyWith(color: textColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment:
                  currentLocal == "ar" ? Alignment.topLeft : Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      date,
                      style:
                          TextStyles.textViewMedium8.copyWith(color: textColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    (count.isEmpty || count == "0")
                        ? SizedBox()
                        : Container(
                            height: 15.h,
                            width: 15.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: primary, shape: BoxShape.circle),
                            child: Text(
                              count,
                              style: TextStyles.textViewRegular10
                                  .copyWith(color: white),
                            ),
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
