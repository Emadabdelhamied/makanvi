import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';

class ChatListAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatListAppbar({
    super.key,
    this.title,
  });
  final String? title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primary,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        title ?? "",
        style: TextStyles.textViewRegular17.copyWith(color: white),
      ),
      // leadingWidth: 100.w,
      leading: IconButton(
        onPressed: () {
          // context.read<BlocMainCubit>().controller.index = 0;
        },
        icon: Icon(Icons.arrow_back, color: white, size: 25.h),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Edit',
            style: TextStyles.textViewBold15.copyWith(color: yellow),
          ),
        ),
      ],
    );
  }
}
