import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../cubit/select_date_cubit/select_date_cubit.dart';

class ListViewDate extends StatefulWidget {
  const ListViewDate({super.key});

  @override
  State<ListViewDate> createState() => _ListViewDateState();
}

class _ListViewDateState extends State<ListViewDate> {
  int _select = 1;
  final items =
      List<DateTime>.generate(30, (i) => DateTime.now().add(Duration(days: i)));

  @override
  Widget build(BuildContext context) {
    log(context.read<SelectDateCubit>().date.toString());

    return Container(
      height: 70.h,
      decoration: BoxDecoration(
          border: Border.all(color: black.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(19.r)),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            final dateName = DateFormat('EE',
                    EasyLocalization.of(context)!.currentLocale!.languageCode)
                .format(item);

            // log(dateName.toString());
            return InkWell(
              onTap: index == 0
                  ? null
                  : () {
                      setState(() {
                        _select = index;
                      });
                      context.read<SelectDateCubit>().date =
                          DateFormat('MM/dd/yyyy', "en").format(item);
                      log(context.read<SelectDateCubit>().date.toString());
                    },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 57.h,
                  //width: 37.w,
                  decoration: BoxDecoration(
                      color: _select == index ? primary : transparentColor,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // if (_select == index)
                        Text(
                          DateFormat('MMMM',
                                  Localizations.localeOf(context).languageCode)
                              .format(DateTime(0, item.month)),
                          style: DateFormat(
                                          'MMMM',
                                          Localizations.localeOf(context)
                                              .languageCode)
                                      .format(DateTime(0, item.month))
                                      .length <
                                  5
                              ? TextStyles.textViewSemiBold12.copyWith(
                                  color: index == 0
                                      ? Color(0xffCBD5E1)
                                      : _select == index
                                          ? white
                                          : black)
                              : TextStyles.textViewSemiBold8.copyWith(
                                  color: index == 0
                                      ? Color(0xffCBD5E1)
                                      : _select == index
                                          ? white
                                          : black),
                        ),
                        Text(
                          dateName.toString(),
                          style: TextStyles.textViewSemiBold8.copyWith(
                              color: index == 0
                                  ? Color(0xffCBD5E1)
                                  : _select == index
                                      ? white
                                      : textColor),
                        ),
                        Text(
                          item.day.toString(),
                          style: TextStyles.textViewSemiBold12.copyWith(
                              color: index == 0
                                  ? Color(0xffCBD5E1)
                                  : _select == index
                                      ? white
                                      : black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
