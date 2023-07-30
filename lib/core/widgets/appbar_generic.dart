import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../injection_container.dart';
import '../constant/colors/colors.dart';
import '../constant/styles/styles.dart';
import '../util/navigator.dart';

class AppBarGeneric extends StatelessWidget implements PreferredSizeWidget {
  const AppBarGeneric(
      {super.key,
      this.title,
      this.isback,
      this.onPressed,
      this.bottom,
      this.titleColor = white,
      this.backGroundColor = Colors.transparent,
      this.style,
      this.withTabBar = false,
      this.actions});
  final String? title;
  final bool? isback;
  final Color backGroundColor;
  final Color titleColor;
  final TextStyle? style;
  final PreferredSizeWidget? bottom;
  final bool? withTabBar;
  final Function()? onPressed;
  final List<Widget>? actions;
  @override
  Size get preferredSize => Size.fromHeight(withTabBar! ? 100 : kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        title ?? "",
        style: style == null
            ? TextStyles.textViewBold16.copyWith(color: titleColor)
            : style,
      ),
      actions: actions,
      // leadingWidth: 100.w,
      leading: isback == false
          ? const SizedBox()
          : IconButton(
              onPressed: onPressed ??
                  () {
                    sl<AppNavigator>().pop();
                  },
              icon: Icon(Icons.arrow_back, color: textColor, size: 22.sp),
            ),
      bottom: bottom,
    );
  }
}
