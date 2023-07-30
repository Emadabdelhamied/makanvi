import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:makanvi_web/core/util/navigator.dart';

import '../injection_container.dart';
import 'constant/colors/colors.dart';
import 'notification_service/notification_service.dart';

class SplashScreen extends StatefulWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final Widget nextPage;
  const SplashScreen({Key? key, required this.nextPage}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  loadData() async {
    await Firebase.initializeApp();
    NotificationService.instance!.initNotificationService();
    NotificationService().setupLocator();
  }

  @override
  void initState() {
    super.initState();
    // loadData();
    controller = AnimationController(vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        sl<AppNavigator>().pushReplacement(screen: widget.nextPage);
        controller.reset();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    //for (final _RouteEntry entry in _history) entry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Center(
          child: Lottie.asset(
            'assets/images/malr.json',
            repeat: false,
            controller: controller,
            width: double.infinity,
            onLoaded: (p0) {
              controller.duration = p0.duration;
              controller.forward();
            },
          ),
        ),
      ),
    );
  }
}
