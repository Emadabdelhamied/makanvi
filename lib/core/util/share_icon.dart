import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/colors/colors.dart';
import '../constant/icons.dart';

class ShareIcon extends StatelessWidget {
  final int id;
  const ShareIcon({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<ShareCubit, ShareState>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
        return Container(
          height: 60.h,
          width: 60.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: white.withOpacity(0.7)),
          child: IconButton(
            onPressed: () =>null,
                // context.read<ShareCubit>().shareProduct(context, id),
            icon: SvgPicture.asset(shareIcon),
            color: primary,
          ),
        );
      // },
    // );
  }
}
