import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constant/colors/colors.dart';
import 'notification_service/notification_service.dart';

class SplashScreenImage extends StatefulWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final Widget nextPage;
  const SplashScreenImage({super.key, required this.nextPage});

  @override
  State<SplashScreenImage> createState() => _SplashScreenImageState();
}

class _SplashScreenImageState extends State<SplashScreenImage> {
  loadData() async {
    await Firebase.initializeApp();
    // NotificationService.instance!.initNotificationService();
    // NotificationService().setupLocator();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => widget.nextPage)));
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset(
            "assets/icons/icon_splash.png",
            width: 224.w,
            height: 209.h,
          ),
        ),
      ),
    );
  }
}
