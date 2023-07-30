import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makanvi_web/features/home_buyer/presentation/pages/home_main_buyer.dart';
import 'package:makanvi_web/features/seller_pages/home_seller/presentation/pages/home_main_seller.dart';

import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/navigator.dart';
import '../../../../injection_container.dart';
import '../../../home_buyer/presentation/cubit/home_buyer_cubit/home_buyer_cubit.dart';
import '../../../seller_pages/home_seller/presentation/cubit/home_cubit.dart';
import '../cubit/chat_cubit.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar(
      {super.key,
      this.title,
      required this.image,
      required this.name,
      required this.fromChat,
      required this.status});
  final String? title;
  final String name;
  final String image;
  final bool fromChat;
  final String status;
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    var chatCubit = context.watch<ChatCubit>();

    return AppBar(
      backgroundColor: transparentColor,
      elevation: 0.0,
      centerTitle: true,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: NetworkImage(image),
                backgroundColor: Colors.transparent,
              ),
              chatCubit.getCountMember != 2
                  ? SizedBox()
                  : Positioned(
                      right: 0.0,
                      top: 0.0,
                      child: SvgPicture.asset(activeIconsSvg),
                    ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyles.textViewMedium15.copyWith(color: textColor),
              ),
              Text(
                status,
                style:
                    TextStyles.textViewMedium14.copyWith(color: textColorLight),
              ),
            ],
          )
        ],
      ),
      // leadingWidth: 100.w,
      leading: IconButton(
        onPressed: () async {
          if (fromChat) {
            await context
                        .read<BlocMainCubit>()
                        .repository
                        .loadAppData()!
                        .modeUserNow ==
                    "seller"
                ? context.read<HomeSellerCubit>().setcurrentIndexSellerHome = 3
                : context.read<HomeBuyerCubit>().setcurrentIndexBuyerHome = 3;
            await context
                        .read<BlocMainCubit>()
                        .repository
                        .loadAppData()!
                        .modeUserNow ==
                    "seller"
                ? await sl<AppNavigator>().pushToFirst(screen: HomeMainSeller())
                : await sl<AppNavigator>().pushToFirst(screen: HomeMainBuyer());
          } else {
            sl<AppNavigator>().pop();
          }
          // AppNavigator.pop(context: context);
        },
        icon: Icon(Icons.arrow_back, color: iconColor, size: 25.h),
      ),
    );
  }
}
