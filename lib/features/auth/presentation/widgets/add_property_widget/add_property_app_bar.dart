import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/size_config.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../cubit/add_property/add_property_cubit.dart';

class AddPropertyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddPropertyAppBar({super.key, this.title});
  final String? title;
  @override
  Size get preferredSize => Size.fromHeight(165.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //toolbarHeight: 150.h,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: white,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      leading: IconButton(
        onPressed: () {
          if (context.read<AddPropertyCubit>().currentStep == 0) {
            sl<AppNavigator>().pop();
          } else {
            context.read<AddPropertyCubit>().setCurrentStep =
                context.read<AddPropertyCubit>().currentStep - 1;
          }
        },
        icon: Icon(CupertinoIcons.back, color: black, size: 40.h),
      ),
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: Text(
        'Add Property',
        style: TextStyles.textViewSemiBold16.copyWith(color: black),
      ),
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
            height: 200.h,
            width: SizeConfig.screenWidth,
            //color: white,
            child: BlocBuilder<AddPropertyCubit, AddPropertyState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 110.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Property Location',
                          style: TextStyles.textViewMedium14
                              .copyWith(color: black),
                        ),
                        Container(
                          height: 35.h,
                          width: 91.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23.r),
                              color: iconColor),
                          child: Center(
                            child: Text(
                              '0${context.watch<AddPropertyCubit>().currentStep + 1}/04',
                              style: TextStyles.textViewMedium16
                                  .copyWith(color: white),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    LinearPercentIndicator(
                      width: 390.w,
                      lineHeight: 10.h,
                      animation: false,
                      animationDuration: 1000,
                      percent:
                          (context.watch<AddPropertyCubit>().currentStep + 1) *
                              0.25,
                      barRadius: Radius.circular(15.r),
                      progressColor: primary,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
