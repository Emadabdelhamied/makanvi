import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/navigator.dart';
import '../../../../core/widgets/error_screen.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/pages/complete_your_profile_page/complete_profile_page.dart';
import '../../../seller_pages/home_seller/presentation/pages/home_main_seller.dart';
import '../../../seller_pages/listining_seller/presentation/pages/add_property/add_property.dart';
import '../../../settings/presentation/cubit/switch_user_cubit/switch_user_cubit.dart';
import '../cubit/home_buyer_cubit/home_buyer_cubit.dart';
import '../widget/app_bar_home_buyer.dart';
import '../widget/go_propert_widget.dart';
import '../widget/header_title.dart';
import '../widget/lists_widget/list_featured.dart';
import '../widget/lists_widget/list_popular_location.dart';
import '../widget/lists_widget/list_projects.dart';
import '../widget/lists_widget/list_property_type.dart';
import '../widget/lists_widget/list_recently.dart';
import '../widget/location_text.dart';
import '../widget/search_field_home_buer.dart';
import 'featue_all_pages/feature_all_page.dart';
import 'popular_location_pages/popular_location_page.dart';
import 'recent_all_pages.dart/recent_all_page.dart';
import 'search/search_screen.dart';

class HomeBuyerPage extends StatelessWidget {
  const HomeBuyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var isGuest =
        context.watch<BlocMainCubit>().repository.loadAppData()!.isGuestUser;

    // var modeUserNow =
    //     context.watch<BlocMainCubit>().repository.loadAppData()!.modeUserNow;
    var typeUser =
        context.watch<BlocMainCubit>().repository.loadAppData()!.typeUser;
    return BlocProvider(
      create: (context) => sl<HomeBuyerCubit>()..fGetHomeBuyer(),
      child: Scaffold(
        appBar: AppBarHomeBuyer(),
        body: BlocBuilder<HomeBuyerCubit, HomeBuyerState>(
          builder: (context, state) {
            if (state is GetHomeBuyerLoading) {
              return Center(
                child: Loading(),
              );
            }
            if (state is SucessGetHomeBuyer) {
              return RefreshIndicator(
                backgroundColor: white,
                color: textColorLight,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () => context
                    .read<HomeBuyerCubit>()
                    .fGetHomeBuyer(isPulled: true),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        // TextButton(
                        //     onPressed: () async {
                        //       var data = await HiveHelper.getFromBox(
                        //           boxName: BoxNames.updateLocation,
                        //           key: 'update_location');
                        //       if (data == null) {
                        //         log("data");
                        //       }
                        //       log(data);
                        //       var dataconvert = jsonDecode(data);
                        //       log(dataconvert.toString());
                        //       UpdateLocationModel map =
                        //           UpdateLocationModel.fromJson(dataconvert);
                        //       log(map.cityAr);
                        //     },
                        //     child: Text("testt")),
                        Center(
                          child: Text(
                            tr("location"),
                            style: TextStyles.textViewMedium12
                                .copyWith(color: textColor),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(locationIconsSvg),
                            SizedBox(
                              width: 3.w,
                            ),
                            LocationText()
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        InkWell(
                          onTap: () {
                            sl<AppNavigator>().push(
                                screen: SearchScreen(
                              fromHome: true,
                            ));
                          },
                          child: SearchFieldHomeBuyer(
                            isEnable: false,
                            prefixIcon: Container(
                                height: 20.h,
                                width: 30.w,
                                child: SvgPicture.asset(
                                  searchIconSvg,
                                  color: Color(0xff285E7C),
                                )),
                            hintText: tr("what_are_you_looking"),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        BlocProvider(
                          create: (context) => sl<SwitchUserCubit>(),
                          child: BlocConsumer<SwitchUserCubit, SwitchUserState>(
                            listener: (context, state) async {
                              if (state is SwitchUserSuccessState) {
                                context
                                    .read<BlocMainCubit>()
                                    .setModeUser("seller");
                                await sl<AppNavigator>()
                                    .pushToFirst(screen: HomeMainSeller());
                              }
                            },
                            builder: (context, state) {
                              if (state is SwitchUserLoadingState) {
                                return Center(
                                  child: Loading(),
                                );
                              }
                              return InkWell(
                                  onTap: isGuest == true
                                      ? () {
                                          sl<AppNavigator>().push(
                                              screen: AddPropertyScreen());
                                        }
                                      : (typeUser == null || typeUser == "")
                                          ? () {
                                              sl<AppNavigator>().push(
                                                  screen: CompleteProfilePage(
                                                isBuyer: true,
                                              ));
                                            }
                                          : () {
                                              context
                                                  .read<SwitchUserCubit>()
                                                  .fSwitchUser();
                                            },
                                  child: GoPropertyWidget());
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        ListPropertyType(
                          propertyTypes: state.homeBuyerModel.propertyTypes,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        state.homeBuyerModel.projects.isEmpty
                            ? SizedBox()
                            : ListProjects(
                                projects: state.homeBuyerModel.projects,
                              ),
                        state.homeBuyerModel.projects.isEmpty
                            ? SizedBox()
                            : SizedBox(
                                height: 25.h,
                              ),
                        state.homeBuyerModel.popularLocations.isEmpty
                            ? SizedBox()
                            : HeaderTitle(
                                title: tr("popular_location"),
                                titleAll: tr("exlor_all"),
                                onTap: () {
                                  sl<AppNavigator>()
                                      .push(screen: PopularLocationPage());
                                }),
                        state.homeBuyerModel.popularLocations.isEmpty
                            ? SizedBox()
                            : SizedBox(
                                height: 20.h,
                              ),
                        state.homeBuyerModel.popularLocations.isEmpty
                            ? SizedBox()
                            : ListPopularLocation(
                                popularLocation:
                                    state.homeBuyerModel.popularLocations,
                              ),
                        state.homeBuyerModel.featured.isEmpty
                            ? SizedBox()
                            : SizedBox(
                                height: 25.h,
                              ),
                        state.homeBuyerModel.featured.isEmpty
                            ? SizedBox()
                            : HeaderTitle(
                                title: tr("featured"),
                                titleAll: tr("view_all"),
                                onTap: () {
                                  sl<AppNavigator>()
                                      .push(screen: FeatureAllPage());
                                }),
                        state.homeBuyerModel.featured.isEmpty
                            ? SizedBox()
                            : SizedBox(
                                height: 20.h,
                              ),
                        state.homeBuyerModel.featured.isEmpty
                            ? SizedBox()
                            : ListFeatured(
                                featured: state.homeBuyerModel.featured,
                              ),
                        SizedBox(
                          height: 25.h,
                        ),
                        HeaderTitle(
                            title: tr("recently_listed"),
                            titleAll: tr("view_all"),
                            onTap: () {
                              sl<AppNavigator>().push(screen: RecentAllPage());
                            }),
                        SizedBox(
                          height: 20.h,
                        ),
                        ListRecently(
                          recently: state.homeBuyerModel.recently,
                        ),
                      ],
                    ),
                  ),
                ),
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
