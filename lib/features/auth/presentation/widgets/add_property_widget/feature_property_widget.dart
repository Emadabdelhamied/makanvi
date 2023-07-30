import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../data/models/get_data_add_probalty_model.dart';
import '../../cubit/add_property/add_property_cubit.dart';

class FeaturePropertyWidgetr extends StatefulWidget {
  FeaturePropertyWidgetr({super.key, required this.features});
  final List<Amenity> features;

  @override
  State<FeaturePropertyWidgetr> createState() => _FeaturePropertyWidgetrState();
}

class _FeaturePropertyWidgetrState extends State<FeaturePropertyWidgetr> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPropertyCubit, AddPropertyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        // if (state is SucessProparty) {
        return Expanded(
          child: ListView.builder(
              // shrinkWrap: true,
              itemCount: widget.features.length,
              itemBuilder: (context, index) {
                if (context.read<AddPropertyCubit>().getFeaturesAdd.length <
                    widget.features.length) {
                  context
                      .read<AddPropertyCubit>()
                      .setFeatureAdd(widget.features[index].id, 0);
                }
                var item = widget.features[index];
                log(context
                        .read<AddPropertyCubit>()
                        .getFeaturesAdd[index]
                        .id
                        .toString() +
                    context
                        .read<AddPropertyCubit>()
                        .getFeaturesAdd[index]
                        .count
                        .toString());
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        item.title,
                        style: TextStyles.textViewMedium14
                            .copyWith(color: textColor),
                      ),
                      Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Localizations.localeOf(context).languageCode == "ar"
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<AddPropertyCubit>()
                                          .incrementCounterList(index);
                                    });
                                  },
                                  child: Container(
                                    height: 25.w,
                                    width: 25.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        color: secondry2),
                                    child: Icon(
                                      Icons.add,
                                      size: 20.sp,
                                      color: white,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<AddPropertyCubit>()
                                          .decrementCounterList(index);
                                    });
                                  },
                                  child: Container(
                                    height: 25.w,
                                    width: 25.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        color: secondry2),
                                    child: Icon(
                                      Icons.remove,
                                      color: white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            tr(
                              context
                                  .read<AddPropertyCubit>()
                                  .getFeaturesAdd[index]
                                  .count
                                  .toString(),
                            ),
                            style: TextStyles.textViewMedium14
                                .copyWith(color: textColor),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Localizations.localeOf(context).languageCode == "ar"
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<AddPropertyCubit>()
                                          .decrementCounterList(index);
                                    });
                                  },
                                  child: Container(
                                    height: 25.w,
                                    width: 25.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        color: secondry2),
                                    child: Icon(
                                      Icons.remove,
                                      color: white,
                                      size: 20.sp,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      context
                                          .read<AddPropertyCubit>()
                                          .incrementCounterList(index);
                                    });
                                  },
                                  child: Container(
                                    height: 25.w,
                                    width: 25.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        color: secondry2),
                                    child: Icon(
                                      Icons.add,
                                      size: 20.sp,
                                      color: white,
                                    ),
                                  ),
                                ),
                        ],
                      )
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
