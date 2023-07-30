import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles/styles.dart';

class ExploarPropartiesCard extends StatelessWidget {
  const ExploarPropartiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          gradient: LinearGradient(colors: [
            iconColor,
            Color(0xff285E7C).withOpacity(0.92),
          ])),
      child: ListTile(
        leading: Container(
          height: 44.h,
          width: 44.w,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(4.r),
              image: DecorationImage(image: AssetImage(searchFieldIcon))),
        ),
        title: Text(
          tr("explore_properties"),
          style: TextStyles.textViewSemiBold15.copyWith(color: white),
        ),
        subtitle: Text(
          tr("discover_properties_around_you"),
          style: TextStyles.textViewMedium11.copyWith(color: white),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: white,
        ),
      ),
    );
  }
}
