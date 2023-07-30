import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomPageWithBottomImage extends StatelessWidget {
  const CustomPageWithBottomImage(
      {super.key, required this.child, required this.image});
  final Widget child;
  final String image;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverToBoxAdapter(child: child),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(image),
        ),
      ),
    ]);
  }
}
