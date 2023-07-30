import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../../seller_pages/listining_seller/presentation/pages/add_property/add_property.dart';
import '../../../data/models/user_role.dart';
import '../../cubit/on_boarding_cubit/on_boarding_cubit.dart';
import '../../widgets/user_type_widget.dart';
import '../buyer_auth_pages/shrare_location.dart/share_location_screen.dart';
import 'select_country_screen.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mainCubit = context.read<BlocMainCubit>();
    return WillPopScope(
      onWillPop: () async {
        sl<AppNavigator>().push(screen: SelectCountryScreen());

        return false;
      },
      child: Scaffold(
          appBar: AppBarGeneric(
            title: '',
            onPressed: () {
              sl<AppNavigator>().push(screen: SelectCountryScreen());
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    tr("how_to_use_makanvi"),
                    style: TextStyles.textViewSemiBold16.copyWith(
                      color: black,
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  BlocBuilder<OnBoardingCubit, OnBoardingState>(
                    builder: (context, state) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: roles.length,
                          itemBuilder: ((context, index) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: UserTypeWidget(
                                  isSelected: context
                                          .watch<OnBoardingCubit>()
                                          .roleSelectedIndex ==
                                      index,
                                  userRoleModel: roles[index],
                                  onTap: () {
                                    context
                                        .read<OnBoardingCubit>()
                                        .setRoleSelectedIndex = index;
                                  },
                                ),
                              )));
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                  bottom: 35.h, right: 20.w, left: 20.w, top: 20.h),
              child: GenericButton(
                onPressed: context.watch<OnBoardingCubit>().roleSelectedIndex ==
                        0
                    ? () {
                        context.read<OnBoardingCubit>().setRoleSelectedIndex =
                            2;
                        sl<AppNavigator>().push(screen: AddPropertyScreen());
                      }
                    : context.watch<OnBoardingCubit>().roleSelectedIndex == 1
                        ? () async {
                            mainCubit.setGuestUser();
                            // await sl<AppNavigator>()
                            //     .pushToFirst(screen: HomeMainBuyer());

                            context
                                .read<OnBoardingCubit>()
                                .setRoleSelectedIndex = 2;
                            sl<AppNavigator>().push(screen: ShareLocatinPage());
                          }
                        : () {
                            customToast(
                                backgroundColor: red,
                                textColor: white,
                                content: 'Select Role');
                          },
                child: Text(
                  tr("select"),
                  style: TextStyles.textViewSemiBold16.copyWith(color: white),
                ),
                borderRadius: BorderRadius.circular(15.sp),
                color: primary,
                width: 336.w,
              ))),
    );
  }
}

List<UserRoleModel> roles = [
  UserRoleModel(image: buyer, role: tr("seller_or_rent")),
  UserRoleModel(image: explorer, role: tr("explor_properties"))
];
