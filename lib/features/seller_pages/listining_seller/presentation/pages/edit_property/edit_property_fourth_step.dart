import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/core/widgets/loading.dart';
import 'package:makanvi_web/core/widgets/toast.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/presentation/cubit/edit_property_cubit/edit_property_cubit.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/util/navigator.dart';
import '../../../../../../core/widgets/appbar_generic.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../core/widgets/master_textfield.dart';
import '../../../../../../injection_container.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/counter_property_widget.dart';
import '../../../../../auth/presentation/widgets/precent_widget.dart';
import '../../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../../home_seller/presentation/pages/home_main_seller.dart';

class EditPropertyFourthStep extends StatelessWidget {
  final String listingId;
  const EditPropertyFourthStep({
    super.key,
    required this.listingId,
  });

  @override
  Widget build(BuildContext context) {
    var editPropertCubit = context.read<EditPropertyCubit>();

    return WillPopScope(
      onWillPop: () async {
        editPropertCubit.previousPage();
        return false;
      },
      child: BlocConsumer<EditPropertyCubit, EditPropertyState>(
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
                  title: tr('edit_property'),
                  titleColor: textColor,
                  onPressed: () {
                    context.read<EditPropertyCubit>().previousPage();
                  },
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CounterWidget(
                          title: tr('short_description'),
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
                          style: TextStyles.textViewMedium16
                              .copyWith(color: black),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        GenericFieldOther(
                          maxLines: 10,
                          hintText: context
                              .read<EditPropertyCubit>()
                              .myListingData!
                              .property
                              .description,
                          controller: editPropertCubit.descrptionEn,
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar:
                    BlocConsumer<EditPropertyCubit, EditPropertyState>(
                  listener: (context, state) {
                    if (state is EditPropartySuccess) {
                      customToast(
                          backgroundColor: Colors.green,
                          textColor: white,
                          content: state.message);
                      context
                          .read<HomeSellerCubit>()
                          .setcurrentIndexSellerHome = 1;
                      sl<AppNavigator>().pushToFirst(screen: HomeMainSeller());
                    }
                  },
                  builder: (context, state) {
                    if (state is EditPropartyLoading) {
                      return Loading();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GenericButton(
                          onPressed: () async {
                            editPropertCubit.fEditListing(listingId: listingId);
                          },
                          child: Text(
                            tr("update"),
                            style: TextStyles.textViewSemiBold16
                                .copyWith(color: white),
                          ),
                          borderRadius: BorderRadius.circular(15.sp),
                          color: primary,
                          width: 336.w,
                        ),
                      );
                    }
                  },
                )),
          );
        },
      ),
    );
  }
}
