import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/icons.dart';

class AnimatedBottomNavSeller extends StatelessWidget {
  final int? currentIndex;
  final Function(int)? onChange;
  const AnimatedBottomNavSeller({Key? key, this.currentIndex, this.onChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => onChange!(0),
              child: BottomNavItem(
                icon: homeIconSvg,
                iconActive: homeActiveIconSvg,
                title: "Home",
                isActive: currentIndex == 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(1),
              child: BottomNavItem(
                icon: categoryIconSvg,
                iconActive: categoryActiveIconSvg,
                title: "Category",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(2),
              child: BottomNavItem(
                icon: notificationIconSvg,
                iconActive: notificationActiveIconSvg,
                title: "Notification",
                isActive: currentIndex == 2,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(3),
              child: BottomNavItem(
                icon: chatIconSvg,
                iconActive: chatActiveIconSvg,
                title: "Chat",
                isActive: currentIndex == 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final bool isActive;
  final String? icon;
  final String? iconActive;
  final Color? activeColor;
  final Color? inactiveColor;
  final String? title;
  const BottomNavItem(
      {Key? key,
      this.isActive = false,
      this.icon,
      this.activeColor,
      this.inactiveColor,
      this.iconActive,
      this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 200),
        child: isActive
            ? Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ImageIcon(

                    SvgPicture.asset(iconActive!)
                        .animate(
                          onPlay: (c) => c.repeat(reverse: true),
                        )
                        .shimmer(duration: 1.seconds, delay: 1.seconds),

                    const SizedBox(height: 5.0),
                    Container(
                      width: 5.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activeColor ?? Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon!,
                    color: inactiveColor ?? Color(0xff130F26),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    width: 5.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              )
        // color: inactiveColor ?? Colors.grey,
        // ),
        );
  }
}
