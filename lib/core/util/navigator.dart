import 'package:flutter/material.dart';

import '../splash_screen.dart';
import '../splash_screen_image.dart';

class AppNavigator {
  Future<void> push({required Widget screen}) async {
    SplashScreen.navigatorKey.currentState == null
        ? await SplashScreenImage.navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (context) => screen))
        : await SplashScreen.navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (context) => screen));
  }

  Future<void> pushReplacement({required Widget screen}) async {
    SplashScreen.navigatorKey.currentState == null
        ? await SplashScreenImage.navigatorKey.currentState!
            .pushReplacement(MaterialPageRoute(builder: (context) => screen))
        : await SplashScreen.navigatorKey.currentState!
            .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }

  dynamic pop({dynamic object}) {
    return SplashScreen.navigatorKey.currentState == null
        ? SplashScreenImage.navigatorKey.currentState!.pop<dynamic>(object)
        : SplashScreen.navigatorKey.currentState!.pop<dynamic>(object);
  }

  dynamic popUtill({required Widget screen}) {
    return SplashScreen.navigatorKey.currentState == null
        ? SplashScreenImage.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (c) => screen), (route) => false)
        : SplashScreen.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (c) => screen), (route) => false);
  }

  dynamic popToFrist({dynamic object}) {
    return SplashScreen.navigatorKey.currentState == null
        ? SplashScreenImage.navigatorKey.currentState!
            .popUntil((rout) => rout.isFirst)
        : SplashScreen.navigatorKey.currentState!
            .popUntil((rout) => rout.isFirst);
  }

  dynamic pushToFirst({required Widget screen}) {
    return SplashScreen.navigatorKey.currentState == null
        ? SplashScreenImage.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => screen),
            (Route<dynamic> route) => false)
        : SplashScreen.navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => screen),
            (Route<dynamic> route) => false);
  }
}
