import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/util/validator.dart';
import '../../../../../../core/widgets/appbar_generic.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../core/widgets/generic_field.dart';
import '../../../../../auth/presentation/cubit/add_property/add_property_cubit.dart';
import '../../../../../auth/presentation/cubit/change_name_rent_or_sell/change_name_rent_or_sell_cubit.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/counter_property_widget.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/feature_property_widget.dart';
import '../../../../../auth/presentation/widgets/precent_widget.dart';

class AddPropertyThirdStep extends StatelessWidget {
  AddPropertyThirdStep({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var addPropartyCubit = context.read<AddPropertyCubit>();
    var changeNameRentOrSellCubit = context.watch<ChangeNameRentOrSellCubit>();

    return WillPopScope(
      onWillPop: () async {
        FocusManager.instance.primaryFocus?.unfocus();

        context.read<AddPropertyCubit>().previousPage();
        return false;
      },
      child: BlocConsumer<AddPropertyCubit, AddPropertyState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          // if (state is SucessProparty) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: AppBarGeneric(
                title: tr("add_property"),
                titleColor: textColor,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();

                  context.read<AddPropertyCubit>().previousPage();
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
                      // context.watch<AddPropertyCubit>().offerTypes == 1
                      //     ?
                      BlocListener<ChangeNameRentOrSellCubit,
                          ChangeNameRentOrSellState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        child: GenericField(
                          labeltext: tr(changeNameRentOrSellCubit.hint),
                          // hintText: tr(changeNameRentOrSellCubit.hint),
                          lableColor: textColor,
                          hintColor: textColor,
                          controller: addPropartyCubit.price,
                          keyboardType: TextInputType.number,
                          suffixIcon: Text(
                            tr("/BHD"),
                            style: TextStyles.textViewMedium15
                                .copyWith(color: textColorLight),
                          ),
                          validation: (value) => Validator.price(value),
                        ),
                      ),
                      // : GenericField(
                      //     labeltext: tr(changeNameRentOrSellCubit.hint),
                      //     hintText: "1000",
                      //     lableColor: textColor,
                      //     hintColor: textColor,
                      //     controller: addPropartyCubit.price,
                      //     keyboardType: TextInputType.number,
                      //     suffixIcon: Text(
                      //       "/BHD",
                      //       style: TextStyles.textViewMedium15
                      //           .copyWith(color: textColorLight),
                      //     ),
                      //     validation: (value) => Validator.price(value),
                      //   ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GenericField(
                        labeltext: tr("area"),
                        // hintText: tr("area"),
                        controller: addPropartyCubit.area,
                        hintColor: textColor,
                        lableColor: textColor,
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
                      FeaturePropertyWidgetr(
                        features: addPropartyCubit.featuresList,
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
                    if (_formKey.currentState!.validate()) {
                      // for (var i = 0;
                      //     i < addPropartyCubit.getFeaturesAdd.length;
                      //     i++) {
                      //   if (addPropartyCubit.getFeaturesAdd[i].count == 0) {
                      //     customToast(
                      //         backgroundColor: red,
                      //         textColor: white,
                      //         content: "Add Feature Count");
                      //   } else {
                      context.read<AddPropertyCubit>().nextPage();
                      // }
                      // }
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
            ),
          );
        },
      ),
    );
  }
}
