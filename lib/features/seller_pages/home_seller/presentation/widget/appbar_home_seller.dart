import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../../settings/presentation/pages/profile_page.dart';
import '../../../../settings/presentation/pages/settings.dart';

class AppBarHomeSeller extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeSeller(
      {super.key,
      this.title,
      this.isback,
      this.onPressed,
      this.titleColor = white,
      this.backGroundColor = Colors.transparent,
      this.style});
  final String? title;
  final bool? isback;
  final Color backGroundColor;
  final Color titleColor;
  final TextStyle? style;
  final Function()? onPressed;
  @override
  Size get preferredSize => const Size.fromHeight(120);
  @override
  Widget build(BuildContext context) {
    var maincubit = context.watch<BlocMainCubit>();
    var image = maincubit.repository.loadAppData()!.photoUrl!;
    log(EndPoints.baseImages + image);
    return AppBar(
      backgroundColor: backGroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      elevation: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 130.h,
        color: transparentColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    sl<AppNavigator>().push(screen: ProfilePage());
                  },
                  child: CircleAvatar(
                    // height: 70.h,
                    // width: 70.w,
                    // decoration: BoxDecoration(
                    //     color: Color(0xffA1A5C1), shape: BoxShape.circle),
                    radius: 33.r,
                    backgroundColor: Color(0xffA1A5C1).withOpacity(0.1),
                    child: Container(
                      height: 55.h,
                      width: 55.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: iconColor),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: (image.isNotEmpty)
                                  ? NetworkImage(!image.contains("http")
                                      ? EndPoints.baseImages + image
                                      : image)
                                  : NetworkImage(EndPoints.placeholder),
                              fit: BoxFit.cover)),
                      // CircleAvatar(
                      //   radius: 29.r,
                      //   backgroundColor: iconColor,
                      //   backgroundImage: NetworkImage(EndPoints.placeholder),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Container(
                  width: 150.w,
                  child: RichText(
                    text: TextSpan(
                        text: tr("welcome"),
                        style: TextStyles.textViewMedium14.copyWith(
                            color: textColor,
                            fontFamily: EasyLocalization.of(context)!
                                        .currentLocale!
                                        .languageCode ==
                                    "ar"
                                ? "Almarai"
                                : "Montserrat"),
                        children: [
                          TextSpan(
                            text: maincubit.repository
                                    .loadAppData()!
                                    .displayName ??
                                "",
                            style: TextStyles.textViewSemiBold14
                                .copyWith(color: textColor),
                          ),
                        ]),
                  ),
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      sl<AppNavigator>().push(screen: Settings());

                      // sl<AppNavigator>().push(
                      //     screen: PalnPaymentPage(
                      //   listingId: 1,
                      // ));
                    },
                    child: SvgPicture.asset(settingIconSvg))
              ],
            ),
          ],
        ),
      ),
      // leadingWidth: 100.w,
    );
  }
}
