import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/hive/hive_helper.dart';
import '../../../../../../core/util/navigator.dart';
import '../../../../../../core/widgets/appbar_generic.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../core/widgets/master_textfield.dart';
import '../../../../../../core/widgets/toast.dart';
import '../../../../../../injection_container.dart';
import '../../../../../auth/data/models/add_probalty_model.dart';
import '../../../../../auth/presentation/cubit/add_property/add_property_cubit.dart';
import '../../../../../auth/presentation/pages/signup/signup_page.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/counter_property_widget.dart';
import '../../../../../auth/presentation/widgets/precent_widget.dart';

class AddPropertyFourthStep extends StatelessWidget {
  const AddPropertyFourthStep({super.key});

  @override
  Widget build(BuildContext context) {
    var addPropertCubit = context.read<AddPropertyCubit>();

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
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CounterWidget(
                      title: tr("short_description"),
                      count: tr("4"),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrecentWidget(
                      percent: 1,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      tr("tell_us_about_your_property"),
                      style: TextStyles.textViewMedium16.copyWith(color: black),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GenericFieldOther(
                      maxLines: 10,
                      hintText: tr("typing"),
                      controller: addPropertCubit.descrptionEn,
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                    bottom: 35.h, right: 20.w, left: 20.w, top: 20.h),
                child: GenericButton(
                  onPressed: () async {
                    if (addPropertCubit.descrptionEn.text.isEmpty) {
                      customToast(
                          backgroundColor: primary,
                          textColor: white,
                          content: "Please Add Descrption");
                    } else {
                      String addProperty = addPropartyModelToJson(AddPropartyModel(
                          offerTypeId: addPropertCubit.offerTypes!,
                          typeId: addPropertCubit.type!,
                          area: addPropertCubit.area.text,
                          price: addPropertCubit.price.text,
                          amenities: addPropertCubit.getAmenitiesIds!,
                          features: addPropertCubit.getFeaturesAdd,
                          isNegotiable: 0,
                          currency: addPropertCubit.selectedCurrency,
                          recommendedShootingDate: "",
                          country: addPropertCubit.countery,
                          state: addPropertCubit.stateName,
                          city: addPropertCubit.city,
                          countryAr: addPropertCubit.counteryAr,
                          stateAr: addPropertCubit.stateNameAr,
                          cityAr: addPropertCubit.cityAr,
                          latitude: 22.22,
                          longitude: 22.22,
                          // latitude: addPropertCubit.getLocation!.latitude,
                          // longitude: addPropertCubit.getLocation!.longitude,
                          descriptionAr: addPropertCubit.descrptionEn.text,
                          descriptionEn: addPropertCubit.descrptionEn.text));
                      HiveHelper.putOnBox(
                          boxName: BoxNames.addProperty,
                          key: "add_property",
                          value: addProperty);
                      // final SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      // await prefs.setString('add_property', addProperty);
                      context.read<BlocMainCubit>().setTypeUser("seller");
                      // addPropertCubit.getSP();
                      await sl<AppNavigator>()
                          .pushToFirst(screen: SignUpPage());
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
