import 'package:flutter/material.dart';
import 'package:makanvi_web/features/seller_pages/home_seller/presentation/widget/bottom_nav_seller.dart';

import '../../../../core/constant/icons.dart';

class AnimatedBottomBuyer extends StatelessWidget {
  final int? currentIndex;
  final Function(int)? onChange;
  const AnimatedBottomBuyer({Key? key, this.currentIndex, this.onChange})
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
          )),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(1),
              child: BottomNavItem(
                icon: searchIconSvg,
                iconActive: searchIconActiveSvg,
                title: "Search",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange!(2),
              child: BottomNavItem(
                icon: favouritIconSvg,
                iconActive: favouritIconActiveSvg,
                title: "Favorite",
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
