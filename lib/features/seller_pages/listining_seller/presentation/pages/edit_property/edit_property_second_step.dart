import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/presentation/cubit/edit_property_cubit/edit_property_cubit.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/widgets/appbar_generic.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/counter_property_widget.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/select_single_chip_widget.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/selected_multi_chip_widget.dart';
import '../../../../../auth/presentation/widgets/precent_widget.dart';

class EditPropertySecondStep extends StatefulWidget {
  EditPropertySecondStep({super.key});

  @override
  State<EditPropertySecondStep> createState() => _EditPropertySecondStepState();
}

class _EditPropertySecondStepState extends State<EditPropertySecondStep> {
  @override
  void initState() {
    super.initState();
    context.read<EditPropertyCubit>().getSelectedAmenites();
    context.read<EditPropertyCubit>().getSelectedOfferType();
    context.read<EditPropertyCubit>().getSelectedType();
  }

  @override
  Widget build(BuildContext context) {
    var editPropartyCubit = context.read<EditPropertyCubit>();
    return WillPopScope(
      onWillPop: () async {
        context.read<EditPropertyCubit>().previousPage();
        return false;
      },
      child: BlocConsumer<EditPropertyCubit, EditPropertyState>(
        listener: (context, state) {},
        builder: (context, state) {
          // if (state is SucessProparty) {
          return Scaffold(
            appBar: AppBarGeneric(
              title: tr('edit_property'),
              titleColor: textColor,
              onPressed: () {
                context.read<EditPropertyCubit>().previousPage();
              },
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CounterWidget(
                    title: tr('about_property'),
                    count: tr("2"),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  PrecentWidget(
                    percent: 0.5,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    tr('property_is_for'),
                    style: TextStyles.textViewMedium16.copyWith(color: black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SelectedSingleChipListWidget(
                    listOfChipNames: editPropartyCubit.offerTypesList,
                    shouldWrap: true,
                    activeBgColorList: [iconColor],
                    inactiveBgColorList: [Colors.white],
                    activeTextColorList: [Colors.white],
                    style: TextStyles.textViewRegular12,
                    inactiveTextColorList: [iconColor],
                    listOfChipIndicesCurrentlySeclected: [
                      editPropartyCubit.selectedOfferType!
                    ],
                    activeBorderColorList: [secondry2],
                    extraOnToggle: (index) {
                      context.read<EditPropertyCubit>().selectedOfferType =
                          editPropartyCubit.offerTypesList[index].id;
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    tr('property_type'),
                    style: TextStyles.textViewMedium16.copyWith(color: black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SelectedSingleChipListWidget(
                    listOfChipNames: editPropartyCubit.typesList,
                    shouldWrap: true,
                    activeBgColorList: [iconColor],
                    inactiveBgColorList: [Colors.white],
                    activeTextColorList: [Colors.white],
                    inactiveTextColorList: [iconColor],
                    style: TextStyles.textViewRegular12,
                    listOfChipIndicesCurrentlySeclected: [
                      editPropartyCubit.selectedType!
                    ],
                    activeBorderColorList: [secondry2],
                    extraOnToggle: (index) {
                      context.read<EditPropertyCubit>().selectedType =
                          editPropartyCubit.typesList[index].id;
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    tr('amenities'),
                    style: TextStyles.textViewMedium16.copyWith(color: black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SelectedMultiChipListWidget(
                    listOfChipNames: editPropartyCubit.amenitiesList,
                    shouldWrap: true,
                    supportsMultiSelect: true,
                    activeBgColorList: [iconColor],
                    inactiveBgColorList: [Colors.white],
                    activeTextColorList: [Colors.white],
                    inactiveTextColorList: [iconColor],
                    listOfChipIndicesCurrentlySeclected:
                        editPropartyCubit.getSelectedAmenites(),
                    activeBorderColorList: [secondry2],
                    extraOnToggle: (index) {
                      log(editPropartyCubit.amenitiesList[index].id.toString());
                      if (editPropartyCubit.finalAmenitites.contains(
                              editPropartyCubit.amenitiesList[index].id) ==
                          false) {
                        editPropartyCubit.finalAmenitites
                            .add(editPropartyCubit.amenitiesList[index].id);
                      } else {
                        editPropartyCubit.finalAmenitites
                            .remove(editPropartyCubit.amenitiesList[index].id);
                      }
                      log(editPropartyCubit.finalAmenitites.toString());
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                  bottom: 35.h, right: 20.w, left: 20.w, top: 20.h),
              child: GenericButton(
                onPressed: () {
                  // if (context.read<EditPropertyCubit>().selectedOfferType==null) {
                  //   customToast(
                  //       backgroundColor: primary,
                  //       textColor: white,
                  //       content: "Please Select Property is for");
                  // } else if (context.read<EditPropertyCubit>().se == null) {
                  //   customToast(
                  //       backgroundColor: primary,
                  //       textColor: white,
                  //       content: "Please Select Property Type");
                  // } else {
                  //   context.read<AddPropertyCubit>().nextPage();
                  // }
                  context.read<EditPropertyCubit>().nextPage();
                },
                child: Text(
                  tr("next"),
                  style: TextStyles.textViewSemiBold16.copyWith(color: white),
                ),
                borderRadius: BorderRadius.circular(15.sp),
                color: primary,
                width: 336.w,
              ),
            ),
          );
        },
      ),
    );
  }
}
