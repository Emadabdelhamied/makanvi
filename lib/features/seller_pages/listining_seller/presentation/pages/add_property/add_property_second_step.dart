import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/widgets/appbar_generic.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../core/widgets/toast.dart';
import '../../../../../auth/presentation/cubit/add_property/add_property_cubit.dart';
import '../../../../../auth/presentation/cubit/change_name_rent_or_sell/change_name_rent_or_sell_cubit.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/counter_property_widget.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/select_single_chip_widget.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/selected_multi_chip_widget.dart';
import '../../../../../auth/presentation/widgets/precent_widget.dart';

class AddPropertySecondStep extends StatelessWidget {
  AddPropertySecondStep({super.key});
  // final List<TypeProparty> offerTypes = [
  //   TypeProparty(id: 1, title: "Sale"),
  //   TypeProparty(id: 2, title: "Rent"),
  // ];
  // final List<TypeProparty> types = [
  //   TypeProparty(id: 1, title: "Villa"),
  //   TypeProparty(id: 2, title: "Apartment"),
  //   TypeProparty(id: 3, title: "Commercial"),
  //   TypeProparty(id: 4, title: "Chalet"),
  //   TypeProparty(id: 5, title: "Office"),
  //   TypeProparty(id: 6, title: "Studio"),
  // ];
  // final List<Amenity> amenities = [
  //   Amenity(id: 1, title: "Pool"),
  //   Amenity(id: 2, title: "Garage"),
  //   Amenity(id: 3, title: "Gated Community"),
  //   Amenity(id: 4, title: "Garden"),
  //   Amenity(id: 5, title: "Gym"),
  // ];

  @override
  Widget build(BuildContext context) {
    var addPropartyCubit = context.read<AddPropertyCubit>();
    return WillPopScope(
      onWillPop: () async {
        context.read<AddPropertyCubit>().previousPage();
        return false;
      },
      child: BlocConsumer<AddPropertyCubit, AddPropertyState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          // if (state is SucessProparty) {
          return Scaffold(
            appBar: AppBarGeneric(
              title: tr("add_property"),
              titleColor: textColor,
              onPressed: () {
                context.read<AddPropertyCubit>().previousPage();
              },
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CounterWidget(
                    title: tr("about_property"),
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
                    tr("property_is_for"),
                    style: TextStyles.textViewMedium16.copyWith(color: black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SelectedSingleChipListWidget(
                    listOfChipNames: addPropartyCubit.offerTypesList,
                    shouldWrap: true,
                    activeBgColorList: [iconColor],
                    inactiveBgColorList: [Colors.white],
                    activeTextColorList: [Colors.white],
                    inactiveTextColorList: [iconColor],
                    style: TextStyles.textViewRegular12,
                    listOfChipIndicesCurrentlySeclected: [
                      context.read<AddPropertyCubit>().offerTypes ?? 100
                    ],
                    activeBorderColorList: [secondry2],
                    extraOnToggle: (index) {
                      context.read<AddPropertyCubit>().setOfferTypes =
                          addPropartyCubit.offerTypesList[index].id;
                      log(context
                          .read<AddPropertyCubit>()
                          .offerTypes
                          .toString());
                      context.read<AddPropertyCubit>().offerTypes == 1
                          ? context.read<ChangeNameRentOrSellCubit>().setHint =
                              "selling_price"
                          : context.read<ChangeNameRentOrSellCubit>().setHint =
                              "renting_price";
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    tr("property_type"),
                    style: TextStyles.textViewMedium16.copyWith(color: black),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                  SelectedSingleChipListWidget(
                    listOfChipNames: addPropartyCubit.typesList,
                    shouldWrap: true,
                    activeBgColorList: [iconColor],
                    inactiveBgColorList: [Colors.white],
                    activeTextColorList: [Colors.white],
                    inactiveTextColorList: [iconColor],
                    listOfChipIndicesCurrentlySeclected: [
                      context.read<AddPropertyCubit>().type ?? 100
                    ],
                    activeBorderColorList: [secondry2],
                    style: TextStyles.textViewRegular12,
                    extraOnToggle: (index) {
                      context.read<AddPropertyCubit>().type =
                          addPropartyCubit.typesList[index].id;
                      log(context.read<AddPropertyCubit>().type.toString());
                    },
                  ),
                  // ChipsFilter(
                  //   amenity: types,
                  //   selected: 0,
                  //   onTap: (index) {
                  //     context.read<AddPropertyCubit>().type = types[index].id;
                  //     log(context.read<AddPropertyCubit>().type.toString());
                  //   },
                  // ),

                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    tr("amenities"),
                    style: TextStyles.textViewMedium16.copyWith(color: black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SelectedMultiChipListWidget(
                    listOfChipNames: addPropartyCubit.amenitiesList,
                    shouldWrap: true,
                    supportsMultiSelect: true,
                    activeBgColorList: [iconColor],
                    inactiveBgColorList: [Colors.white],
                    activeTextColorList: [Colors.white],
                    inactiveTextColorList: [iconColor],
                    listOfChipIndicesCurrentlySeclected: [],
                    activeBorderColorList: [secondry2],
                    extraOnToggle: (index) {
                      context.read<AddPropertyCubit>().setAmenitiesId =
                          addPropartyCubit.amenitiesList[index].id;
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
                  if (context.read<AddPropertyCubit>().offerTypes == null) {
                    customToast(
                        backgroundColor: primary,
                        textColor: white,
                        content: "Please Select Property is for");
                  } else if (context.read<AddPropertyCubit>().type == null) {
                    customToast(
                        backgroundColor: primary,
                        textColor: white,
                        content: "Please Select Property Type");
                    // }
                    // else if (context
                    //     .read<AddPropertyCubit>()
                    //     .getAmenitiesIds!
                    //     .isEmpty) {
                    //   customToast(
                    //       backgroundColor: primary,
                    //       textColor: white,
                    //       content: "Please Select Amenities");
                  } else {
                    // context.read<AddPropertyCubit>().offerTypes == 1
                    //     ? context.read<AddPropertyCubit>().setHint =
                    //         "selling_price"
                    //     : context.read<AddPropertyCubit>().setHint =
                    //         "renting_price";
                    // context.read<AddPropertyCubit>().pageController.jumpTo(2);
                    context.read<AddPropertyCubit>().nextPage();
                  }
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
