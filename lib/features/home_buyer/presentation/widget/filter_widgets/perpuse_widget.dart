import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../cubit/search_cubit/search_cubit.dart';

class PerpuseWidget extends StatefulWidget {
  const PerpuseWidget({super.key});

  @override
  State<PerpuseWidget> createState() => _PerpuseWidgetState();
}

class _PerpuseWidgetState extends State<PerpuseWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47.h,
      width: 336.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r), color: cardBackground),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 35.h,
            width: 152.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: context.watch<SearchCubit>().perpuse == 1
                    ? white
                    : Colors.transparent),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    context.read<SearchCubit>().perpuse = 1;
                  });
                },
                child: Text(
                  tr("for_sale"),
                  style: TextStyles.textViewSemiBold12.copyWith(
                      color: context.watch<SearchCubit>().perpuse == 1
                          ? titelsColor
                          : disabeldColor),
                )),
          ),
          Container(
            height: 35.h,
            width: 152.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: context.watch<SearchCubit>().perpuse == 2
                    ? white
                    : Colors.transparent),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    context.read<SearchCubit>().perpuse = 2;
                  });
                },
                child: Text(
                  tr("for_rent"),
                  style: TextStyles.textViewSemiBold12.copyWith(
                      color: context.watch<SearchCubit>().perpuse == 2
                          ? titelsColor
                          : disabeldColor),
                )),
          )
        ],
      ),
    );
  }
}
