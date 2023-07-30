import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/presentation/cubit/edit_property_cubit/edit_property_cubit.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/util/validator.dart';
import '../../../../../../core/widgets/appbar_generic.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../core/widgets/generic_field.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/counter_property_widget.dart';
import '../../../../../auth/presentation/widgets/edit_property_widget/edit_feature_property_widget.dart';
import '../../../../../auth/presentation/widgets/precent_widget.dart';

class EditPropertyThirdStep extends StatelessWidget {
  EditPropertyThirdStep({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var editPropartyCubit = context.read<EditPropertyCubit>();
    editPropartyCubit.createFeaturesList();
    return WillPopScope(
      onWillPop: () async {
        editPropartyCubit.previousPage();
        return false;
      },
      child: BlocConsumer<EditPropertyCubit, EditPropertyState>(
        listener: (context, state) {},
        builder: (context, state) {
          // if (state is SucessProparty) {
          editPropartyCubit.area.text =
              editPropartyCubit.myListingData!.property.area.toString();
          editPropartyCubit.descrptionEn.text =
              editPropartyCubit.myListingData!.property.description;
          editPropartyCubit.price.text =
              editPropartyCubit.myListingData!.property.price.toString();
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: AppBarGeneric(
                title: tr('edit_property'),
                titleColor: textColor,
                onPressed: () {
                  editPropartyCubit.previousPage();
                },
              ),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CounterWidget(
                        title: tr("property_details"),
                        count: tr("3"),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrecentWidget(
                        percent: 0.75,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GenericField(
                        labeltext: tr('selling_price'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: editPropartyCubit
                            .myListingData!.property.price
                            .toString(),
                        lableColor: textColor,
                        hintColor: textColor,
                        controller: editPropartyCubit.price,
                        keyboardType: TextInputType.number,
                        suffixIcon: Text(
                          tr("/BHD"),
                          style: TextStyles.textViewMedium15
                              .copyWith(color: textColorLight),
                        ),
                        // DropdownButton2(
                        //   hint: Text(
                        //     '/ ${context.watch<EditPropertyCubit>().selectedCurrency}',
                        //     style: TextStyles.textViewMedium15
                        //         .copyWith(color: textColorLight),
                        //   ),
                        //   items: context
                        //       .watch<EditPropertyCubit>()
                        //       .currencyList
                        //       .map((item) => DropdownMenuItem<String>(
                        //             value: item,
                        //             child: Text(
                        //               item,
                        //               style: TextStyles.textViewMedium15
                        //                   .copyWith(color: textColorLight),
                        //               overflow: TextOverflow.ellipsis,
                        //             ),
                        //           ))
                        //       .toList(),
                        //   onChanged: (value) {
                        //     context
                        //         .read<EditPropertyCubit>()
                        //         .setSelectedCurrency = value;
                        //     //log(value.toString());
                        //   },
                        // ),
                        validation: (value) => Validator.price(value),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GenericField(
                        labeltext: tr("area"),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: editPropartyCubit.myListingData!.property.area
                            .toString(),
                        hintColor: textColor,
                        lableColor: textColor,
                        controller: editPropartyCubit.area,
                        keyboardType: TextInputType.number,
                        suffixIcon: Text(
                          tr("sq_m"),
                          style: TextStyles.textViewMedium15
                              .copyWith(color: textColorLight),
                        ),
                        validation: (value) => Validator.area(value),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        tr("features"),
                        style: TextStyles.textViewMedium16
                            .copyWith(color: textColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      EditFeaturePropertyWidget(
                        features: editPropartyCubit.featuresList,
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                    bottom: 35.h, right: 20.w, left: 20.w, top: 20.h),
                child: GenericButton(
                  onPressed: () {
                    editPropartyCubit.nextPage();
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
            ),
          );
        },
      ),
    );
  }
}
