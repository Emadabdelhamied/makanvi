import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/features/home_buyer/presentation/cubit/search_cubit/search_cubit.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/home_buer_model.dart';
import '../../pages/search/search_screen.dart';

class ListPopularLocation extends StatelessWidget {
  const ListPopularLocation({super.key, required this.popularLocation});
  final List<PopularLocation> popularLocation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 56.h,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: popularLocation.length,
            itemBuilder: (context, index) {
              var item = popularLocation[index];
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: InkWell(
                  onTap: () {
                    log(item.id.toString());
                    context.read<SearchCubit>().locationId = item.id;
                    sl<AppNavigator>().push(
                        screen: SearchScreen(
                      fromHome: true,
                      locationId: item.id,
                      location: item.name,
                    ));
                  },
                  child: Container(
                    height: 56.h,
                    width: 133.w,
                    decoration: BoxDecoration(
                      color: Color(0xffF5F4F8),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    EndPoints.baseImages + item.coverImagePath),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          item.name,
                          style: TextStyles.textViewMedium12
                              .copyWith(color: textColor),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
