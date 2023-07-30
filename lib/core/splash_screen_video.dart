import 'dart:async';

import 'package:flutter/material.dart';
import 'package:makanvi_web/core/splash_screen.dart';

class SplashScreenVideo extends StatefulWidget {
  final Widget nextPage;

  const SplashScreenVideo({super.key, required this.nextPage});

  @override
  _SplashScreenVideoState createState() => _SplashScreenVideoState();
}

class _SplashScreenVideoState extends State<SplashScreenVideo> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => SplashScreen.navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => widget.nextPage)),
    );
  }

  // @override
  // void dispose() {
  //   _controller!.pause();
  //   _controller!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/splash_gif.gif')),
    );
  }
}
