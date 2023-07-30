import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/hive/hive_helper.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../injection_container.dart';
import '../../../../home_buyer/presentation/pages/home_main_buyer.dart';
import '../../../../seller_pages/home_seller/presentation/pages/home_main_seller.dart';
import '../../../../seller_pages/listining_seller/domain/usecases/create_listings_usecase.dart';
import '../../../../seller_pages/listining_seller/domain/usecases/direct_upgrade_usecase.dart';
import '../../../../seller_pages/listining_seller/presentation/cubit/direct_upgrade/direct_upgrade_cubit.dart';
import '../../../../seller_pages/payment/presentation/pages/screen_select_shotting_dailog.dart';
import '../../../data/models/add_probalty_model.dart';
import '../../../data/models/update_location_model.dart';
import '../../../domain/usecases/google_usecase.dart';
import '../../../domain/usecases/update_location_usecase.dart';
import '../../cubit/add_property/add_property_cubit.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/update_location/update_location_cubit.dart';
import '../../pages/buyer_auth_pages/verfiy_phone_buyer_page.dart';
import '../../pages/complete_your_profile_page/complete_profile_page.dart';
import '../../pages/payment_pages/dialog_sucess_payment_page.dart';
import '../../pages/pincode_page/pincode_page.dart';
import '../../pages/verfy_phone_numer/verfy_phone_numer_page.dart';

class AppleWidget extends StatelessWidget {
  const AppleWidget({super.key, this.isBuyer = false, required this.isLogin});
  final bool isBuyer;
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    var mainBloc = context.read<BlocMainCubit>();

    return BlocProvider(
      create: (context) => sl<DirectUpgradeCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is SendAppleTokenSuccessState) {
            mainBloc.updateData(state.appData);
            if (state.appData.typeUser == "" ||
                state.appData.typeUser == null && isBuyer == false) {
              sl<AppNavigator>().push(
                  screen: CompleteProfilePage(
                isBuyer: isBuyer,
              ));
            } else if (state.appData.phone == "" ||
                state.appData.phone == null) {
              isBuyer == false
                  ? sl<AppNavigator>().push(
                      screen: VerfiyPhoneNumberPage(
                      isLogin: true,
                      modeUser: state.appData.modeUserNow,
                    ))
                  : sl<AppNavigator>().push(
                      screen: VerfiyPhoneNumberBuyerPage(
                      isLogin: true,
                      modeUser: state.appData.modeUserNow,
                    ));
            } else if (state.appData.isVerfied == false) {
              isBuyer == false
                  ? sl<AppNavigator>().push(
                      screen: PinCodePage(
                      mobileCounteryId:
                          mainBloc.repository.loadAppData()!.countryId!,
                      number: state.appData.phone!,
                      modeUser: "seller",
                    ))
                  : sl<AppNavigator>().push(
                      screen: PinCodePage(
                      mobileCounteryId:
                          mainBloc.repository.loadAppData()!.countryId!,
                      number: state.appData.phone!,
                      modeUser: "buyer",
                    ));
            } else {
              // if (state.appData.modeUserNow == "seller") {
              if (isBuyer == false) {
                final prefs = await SharedPreferences.getInstance();
                if (prefs.containsKey("add_property")) {
                  final jsonData =
                      jsonDecode(prefs.getString('add_property') ?? '{}');

                  AddPropartyModel map = AddPropartyModel.fromJson(jsonData);

                  await context.read<AuthCubit>().fCreateListingsAuth(
                          createListingParms: CreateListingParms(
                        creatListingsModel: map.toJsonApi(),
                      ));
                  log(context.read<AuthCubit>().listingIdValue.toString());

                  context.read<AddPropertyCubit>().removeAllField();
                  prefs.remove("add_property");
                  context.read<AddPropertyCubit>().removeAllField();

                  if (state.goto == "" || state.goto == "pay") {
                    await sl<AppNavigator>().pushToFirst(
                        screen: DialogSucessPaymentPage(
                      listingId: context.read<AuthCubit>().listingIdValue!,
                      goto: state.goto,
                    ));
                  } else if (state.goto == "direct_upgrade") {
                    await context.read<DirectUpgradeCubit>().fDirectUpgrading(
                          directUpgradeParams: DirectUpgradeParams(
                            listingId:
                                context.read<AuthCubit>().listingIdValue!,
                            packageId: state.packageId.toString(),
                          ),
                        );
                    await sl<AppNavigator>().pushToFirst(
                        screen: ScreenSelectShottingDateDialog(
                      listingId: context.read<AuthCubit>().listingIdValue!,
                    ));
                    // if (state is DirectUpgradeSuccessState) {
                  }
                } else {
                  state.appData.modeUserNow == "buyer"
                      ? await sl<AppNavigator>()
                          .pushToFirst(screen: const HomeMainBuyer())
                      : await sl<AppNavigator>()
                          .pushToFirst(screen: const HomeMainSeller());
                }

                // if (state is SucessAddProparty) {

                // sl<AppNavigator>().pushToFirst(screen: HomeMainSeller());
              } else {
                // final prefs = await SharedPreferences.getInstance();
                // final jsonData = prefs.containsKey("update_location")
                //     ? jsonDecode(prefs.getString('update_location') ?? '')
                //     : "";

                var data = await HiveHelper.getFromBox(
                    boxName: BoxNames.updateLocation, key: 'update_location');
                if (data != null) {
                  final jsonData = jsonDecode(data ?? '{}');

                  UpdateLocationModel map =
                      UpdateLocationModel.fromJson(jsonData);
                  context.read<UpdateLocationCubit>().fUpdateLocation(
                      updateLocationParams: UpdateLocationParams(
                          countery: map.country,
                          city: map.city,
                          state: map.state,
                          lang: map.longitude,
                          lat: map.latitude));
                }
                // prefs.remove("update_location");

                HiveHelper.deleteFromBox(
                    boxName: BoxNames.updateLocation, key: 'update_location');
                await sl<AppNavigator>()
                    .pushToFirst(screen: const HomeMainBuyer());
                // }

                // AppNavigator.pushToFrist(
                //     context: context,
                //     screen: const HomeMainScreen());
              }
            }
          }
        },
        builder: (context, state) {
          if (state is AppleSigningIn) {
            return const Loading();
          } else {
            return GenericButton(
              width: MediaQuery.of(context).size.width,
              color: white,
              borderColor: const Color(0xffE2E8F0),
              onPressed: () async {
                context.read<AuthCubit>().signInUsingApple(
                    context: context,
                    googleSignInParams: GoogleSignInParams(
                        codnteryId:
                            mainBloc.repository.loadAppData()!.countryId!,
                        lang: EasyLocalization.of(context)!
                            .currentLocale!
                            .languageCode,
                        accountMode: "seller"));
              },
              borderRadius: BorderRadius.circular(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25.h,
                    width: 30.w,
                    child: Image.asset(appleIcon),
                  ),
                  Text(
                      isLogin
                          ? tr('login_with_apple')
                          : tr("sign_up_with_apple"),
                      style: TextStyles.textViewMedium14
                          .copyWith(color: const Color(0xff334155))),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
