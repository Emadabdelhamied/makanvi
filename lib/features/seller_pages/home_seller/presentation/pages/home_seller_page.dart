import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../../../auth/presentation/cubit/add_property/add_property_cubit.dart';
import '../../../../home_buyer/presentation/pages/home_main_buyer.dart';
import '../../../../settings/presentation/cubit/switch_user_cubit/switch_user_cubit.dart';
import '../../../listining_seller/presentation/pages/add_property/add_property.dart';
import '../cubit/home_cubit.dart';
import '../widget/add_listing_button.dart';
import '../widget/appbar_home_seller.dart';
import '../widget/current_package.dart';
import '../widget/explor_proparties_card.dart';
import '../widget/recent_activity_widget.dart';

class HomeSellerPage extends StatefulWidget {
  const HomeSellerPage({super.key});

  @override
  State<HomeSellerPage> createState() => _HomeSellerPageState();
}

class _HomeSellerPageState extends State<HomeSellerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeSellerCubit>()..fGetHomeSeller(),
      child: Scaffold(
        appBar: AppBarHomeSeller(),
        body: BlocConsumer<HomeSellerCubit, HomeSellerState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is GetHomeSellerLoading) {
              return Center(
                child: Loading(),
              );
            }
            if (state is SucessGetHomeSeller) {
              return RefreshIndicator(
                backgroundColor: white,
                color: textColorLight,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () => context
                    .read<HomeSellerCubit>()
                    .fGetHomeSeller(isPulled: true),
                child: SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddListingButton(
                        onPressed: () {
                          context.read<AddPropertyCubit>().removeAllField();
                          var consume =
                              state.homeSellerModel.subscriptions.listing ==
                                      null
                                  ? 0
                                  : state.homeSellerModel.subscriptions.listing!
                                      .consume;
                          var count =
                              state.homeSellerModel.subscriptions.listing ==
                                      null
                                  ? 0
                                  : state.homeSellerModel.subscriptions.listing!
                                      .listingCount;
                          bool? _isPay;
                          if (consume >= count) {
                            _isPay = true;
                          } else {
                            _isPay = false;
                          }
                          sl<AppNavigator>().push(
                              screen: AddPropertyScreen(
                            isLoged: true,
                            isPay: _isPay,
                            packageId:
                                state.homeSellerModel.subscriptions.listing ==
                                        null
                                    ? 0
                                    : state.homeSellerModel.subscriptions
                                        .listing!.id,
                            goTo: state.homeSellerModel.subscriptions.listing ==
                                    null
                                ? "pay"
                                : state.homeSellerModel.subscriptions.listing!
                                    .goTo,
                          ));
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      BlocProvider(
                        create: (context) => sl<SwitchUserCubit>(),
                        child: BlocConsumer<SwitchUserCubit, SwitchUserState>(
                          listener: (context, state) async {
                            if (state is SwitchUserSuccessState) {
                              context
                                  .read<BlocMainCubit>()
                                  .setModeUser("buyer");
                              await sl<AppNavigator>()
                                  .pushToFirst(screen: HomeMainBuyer());
                            }
                          },
                          builder: (context, state) {
                            if (state is SwitchUserLoadingState) {
                              return Center(
                                child: Loading(),
                              );
                            }
                            return InkWell(
                                onTap: () {
                                  context.read<SwitchUserCubit>().fSwitchUser();
                                },
                                child: ExploarPropartiesCard());
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      (state.homeSellerModel.subscriptions.listing == null ||
                              state.homeSellerModel.subscriptions.listing!
                                      .cancled ==
                                  1)
                          ? SizedBox()
                          : CurrentPackageWidget(
                              subscriptions:
                                  state.homeSellerModel.subscriptions,
                            ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        tr("recent_activities"),
                        style: TextStyles.textViewSemiBold16
                            .copyWith(color: textColor),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      state.homeSellerModel.recentlyNotifications.isEmpty
                          ? Center(
                              child: Text(tr("no_recent_activity")),
                            )
                          : RecentActivityWidget(
                              recentlyNotificationHome:
                                  state.homeSellerModel.recentlyNotifications,
                            )
                    ],
                  ),
                )),
              );
            } else {
              return ErrorScreen();
            }
          },
        ),
      ),
    );
  }
}
