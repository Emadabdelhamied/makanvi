import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/home_buer_model.dart';
import '../../cubit/search_cubit/search_cubit.dart';
import '../../pages/search/search_screen.dart';

class ListPropertyType extends StatelessWidget {
  const ListPropertyType({super.key, required this.propertyTypes});
  final List<PropertyType> propertyTypes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: InkWell(
              onTap: () {
                sl<AppNavigator>().push(
                    screen: SearchScreen(
                  fromHome: true,
                ));
              },
              child: Container(
                height: 50.h,
                width: 65.w,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  tr("all"),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.textViewMedium12.copyWith(color: white),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: propertyTypes.length,
                itemBuilder: (context, index) {
                  var item = propertyTypes[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: InkWell(
                      onTap: () {
                        sl<AppNavigator>().push(
                            screen: SearchScreen(
                          fromHome: true,
                          title: item.title,
                        ));
                        context.read<SearchCubit>().search.text = item.title;
                      },
                      child: Container(
                        height: 50.h,
                        // width: 65.w,
                        decoration: BoxDecoration(
                          color: Color(0xffF5F4F8),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            item.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.textViewMedium12
                                .copyWith(color: textColor),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
