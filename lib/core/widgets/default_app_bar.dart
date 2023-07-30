// import 'package:badges/badges.dart' as badge;
// import 'package:badges/badges.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../injection_container.dart';
// import '../constant/colors/colors.dart';
// import '../constant/styles/styles.dart';
// import '../util/navigator.dart';

// // ignore: non_constant_identifier_names
// DefaultAppBar(
//     {required String title,
//     VoidCallback? tap1,
//     VoidCallback? tap2,
//     String? icon1,
//     String? icon2,
//     Color? backgroundColor,
//     Color? backPressedColor,
//     required BuildContext context,
//     VoidCallback? backPressed}) {
//   return AppBar(
//     backgroundColor: backgroundColor ?? Colors.transparent,
//     systemOverlayStyle: SystemUiOverlayStyle(
//       // Status bar color
//       statusBarColor: ThemeData.light().scaffoldBackgroundColor,
//       statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
//       statusBarBrightness: Brightness.light, // For iOS (dark icons)
//     ),
//     elevation: 0.0,
//     centerTitle: true,
//     title: Text(title,
//         style: TextStyles.textViewMedium14
//             .copyWith(color: backgroundColor == primary ? white : primary)),
//     leading: IconButton(
//       onPressed: backPressed ?? () => sl<AppNavigator>().pop(),
//       icon: Icon(CupertinoIcons.back,
//           color: backgroundColor != null ? white : primary, size: 40.h),
//     ),
//     actions: [
//       icon1 == null
//           ? const SizedBox()
//           : Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: badge.Badge(
//                 position: BadgePosition.topEnd(top: 4, end: 28),
//                 //badgeColor: red,
//                 badgeContent: Center(
//                     child: Text(
//                   '',
//                   style: TextStyles.textViewMedium14.copyWith(color: white),
//                   textAlign: TextAlign.center,
//                 )),
//                 // animationDuration: const Duration(milliseconds: 500),
//                 // animationType: BadgeAnimationType.scale,
//                 child: IconButton(
//                   onPressed: tap1,
//                   icon: Image.asset(
//                     icon1,
//                   ),
//                 ),
//               ),
//             ),
//       icon2 == null
//           ? const SizedBox()
//           : IconButton(
//               onPressed: tap2,
//               icon: Image.asset(
//                 icon2,
//                 color: primary,
//                 height: 25,
//                 width: 25,
//               ),
//             ),
//     ],
//   );
// }
