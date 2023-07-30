import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';
import 'package:makanvi_web/features/home_buyer/presentation/cubit/search_cubit/search_cubit.dart';

import '../../../../core/constant/icons.dart';

class FilterIcon extends StatelessWidget {
  final Function() onTap;
  const FilterIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
          color: primary,
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: context.watch<SearchCubit>().filterEnabled
                ? [
                    Color(0xffFF3137),
                    Color(0xffF96E72),
                  ]
                : [disabeldColor, disabeldColor],
          ),
        ),
        child: Center(
          child: SvgPicture.asset(filterSvg),
        ),
      ),
    );
  }
}
