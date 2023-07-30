import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../data/models/countery_model.dart';
import '../cubit/on_boarding_cubit/on_boarding_cubit.dart';
import 'country_widget.dart';

class CounteryList extends StatefulWidget {
  const CounteryList({super.key, required this.countryAuth});
  final List<CountryAuth> countryAuth;

  @override
  State<CounteryList> createState() => _CounteryListState();
}

class _CounteryListState extends State<CounteryList> {
  int _selectCountery = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.countryAuth.length,
          itemBuilder: (context, index) {
            var itemCountery = widget.countryAuth[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: CountryWidget(
                countryAuth: itemCountery,
                borderColor: itemCountery.isActive == 0
                    ? Color(0xffE6EAEE)
                    : _selectCountery == index
                        ? primary
                        : black,
                backGroundColor: itemCountery.isActive == 0
                    ? Color(0xffE6EAEE)
                    : _selectCountery == index
                        ? transparent
                        : background2Color,
                isActive: itemCountery.isActive,
                text: itemCountery.name,
                countryCode: itemCountery.shortName,
                onTap: itemCountery.isActive == 0
                    ? () {}
                    : () {
                        setState(() {
                          _selectCountery = index;
                        });
                        context.read<OnBoardingCubit>().setCounterySelectedId =
                            itemCountery.id;
                        // log(context
                        //     .read<OnBoardingCubit>()
                        //     .counterySelectedId
                        //     .toString());
                      },
              ),
            );
          }),
    );
  }
}
