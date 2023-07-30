import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makanvi_web/core/constant/images.dart';
import 'package:makanvi_web/core/widgets/error_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/util/paginate_loading.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../../../auth/presentation/widgets/add_property_widget/selected_multi_chip_widget.dart';
import '../../../../seller_pages/listining_seller/presentation/pages/property_details.dart';
import '../../../../seller_pages/listining_seller/presentation/widgets/card_listing.dart';
import '../../../../seller_pages/listining_seller/presentation/widgets/empty_listing.dart';
import '../../cubit/home_buyer_cubit/home_buyer_cubit.dart';
import '../../cubit/search_cubit/search_cubit.dart';
import '../../widget/filter_icon.dart';
import '../../widget/filter_widgets/features_widget.dart';
import '../../widget/filter_widgets/header_widget.dart';
import '../../widget/filter_widgets/perpuse_widget.dart';
import '../../widget/filter_widgets/slider_range_widget.dart';
import '../../widget/search_field_home_buer.dart';
import 'search_on_map.dart';

class SearchScreen extends StatefulWidget {
  final bool fromHome;
  final int? locationId;
  final String? title;
  final String? location;
  const SearchScreen(
      {super.key,
      this.fromHome = false,
      this.locationId,
      this.title = '',
      this.location = ''});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final ScrollController scrollController;
  final PanelController _pc = PanelController();
  bool _showWidget = true;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    context.read<SearchCubit>().getBytesFromAsset();
    context.read<SearchCubit>().emptyFilters();
    context.read<SearchCubit>().search.text = widget.title ?? '';
    context
        .read<SearchCubit>()
        .fGetSearch(isFirst: true, locationId: widget.locationId);
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        context.read<SearchCubit>().fGetSearch(locationId: widget.locationId);
      }
    });
    scrollController.addListener(() {
      final double scrollOffset = scrollController.offset;
      if (scrollOffset > 100 && _showWidget) {
        setState(() {
          _showWidget = false;
        });
      } else if (scrollOffset <= 100 && !_showWidget) {
        setState(() {
          _showWidget = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController controller = TextEditingController();
    return WillPopScope(
      onWillPop: () async {
        widget.fromHome
            ? sl<AppNavigator>().pop()
            : context.read<HomeBuyerCubit>().setcurrentIndexBuyerHome = 0;
        return false;
      },
      child: Scaffold(
        appBar: AppBarGeneric(
          isback: true,
          onPressed: () {
            widget.fromHome
                ? sl<AppNavigator>().pop()
                : context.read<HomeBuyerCubit>().setcurrentIndexBuyerHome = 0;
          },
          title: widget.location == '' || widget.location == null
              ? tr("search")
              : "${tr('search_on')} ${widget.location}",
          titleColor: textColor,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              // width: 270.w,
                              child: SearchFieldHomeBuyer(
                                isEnable: true,
                                onTap: () {
                                  log('message');
                                },
                                controller: context.read<SearchCubit>().search,
                                onSubmitted: (search) {
                                  // context.read<SearchCubit>().search = search;
                                  // context
                                  //     .read<SearchCubit>()
                                  //     .fGetSearch(isFirst: true);
                                  // // context
                                  // //     .read<SearchCubit>()
                                  // //     .searchMarkers
                                  // //     .clear();
                                  // for (var element in context
                                  //     .read<SearchCubit>()
                                  //     .searchDataList) {
                                  //   context
                                  //       .read<SearchCubit>()
                                  //       .searchMarkers
                                  //       .add(Marker(
                                  //         markerId: MarkerId(
                                  //             "${element.id}".toString()),
                                  //         position: LatLng(
                                  //             double.parse(
                                  //                 element.location.latitude),
                                  //             double.parse(
                                  //                 element.location.longitude)),
                                  //         infoWindow: InfoWindow(
                                  //             title:
                                  //                 "${element.currency}${element.price}",
                                  //             onTap: () {
                                  //               sl<AppNavigator>().push(
                                  //                   screen: PropertyDetails(
                                  //                       listingId: element.id
                                  //                           .toString()));
                                  //             },
                                  //             snippet:
                                  //                 "${element.location.city},${element.location.state},${element.location.country}"),
                                  //         icon: BitmapDescriptor.fromBytes(
                                  //             context
                                  //                 .read<SearchCubit>()
                                  //                 .markerIcon!),
                                  //       ));
                                  // }
                                },
                                onChanged: (search) {
                                  // context.read<SearchCubit>().search = search;
                                  // context
                                  //     .read<SearchCubit>()
                                  //     .fGetSearch(isFirst: true);
                                  // context
                                  //     .read<SearchCubit>()
                                  //     .searchMarkers
                                  //     .clear();
                                  // for (var element in context
                                  //     .read<SearchCubit>()
                                  //     .searchDataList) {
                                  //   context
                                  //       .read<SearchCubit>()
                                  //       .searchMarkers
                                  //       .add(Marker(
                                  //         markerId: MarkerId(
                                  //             "${element.id}".toString()),
                                  //         position: LatLng(
                                  //             double.parse(
                                  //                 element.location.latitude),
                                  //             double.parse(
                                  //                 element.location.longitude)),
                                  //         infoWindow: InfoWindow(
                                  //             title:
                                  //                 "${element.currency}${element.price}",
                                  //             onTap: () {
                                  //               sl<AppNavigator>().push(
                                  //                   screen: PropertyDetails(
                                  //                       listingId: element.id
                                  //                           .toString()));
                                  //             },
                                  //             snippet:
                                  //                 "${element.location.city},${element.location.state},${element.location.country}"),
                                  //         icon: BitmapDescriptor.fromBytes(
                                  //             context
                                  //                 .read<SearchCubit>()
                                  //                 .markerIcon!),
                                  //       ));
                                  // }
                                },
                                prefixIcon: Container(
                                    height: 20.h,
                                    width: 30.w,
                                    child: SvgPicture.asset(
                                      searchIconSvg,
                                      color: Color(0xff285E7C),
                                    )),
                                hintText: tr("search_hint"),
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          FilterIcon(
                            onTap: () {
                              context
                                  .read<SearchCubit>()
                                  .fGetDataEditPropertyModel();
                              _pc.open();
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      _showWidget
                          ? Text(
                              Localizations.localeOf(context).languageCode ==
                                      'ar'
                                  ? '${tr("Listings_found")} ${context.watch<SearchCubit>().total} ${context.watch<SearchCubit>().total > 10 ? tr("place") : tr("listings")}'
                                  : '${context.watch<SearchCubit>().total} ${tr("Listings_found")}',
                              style: TextStyles.textViewSemiBold18
                                  .copyWith(color: titelsColor),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                SearchDataList(
                  scrollController: scrollController,
                ),
              ],
            ),
            SlidingUpPanel(
              controller: _pc,
              parallaxOffset: .5,
              isDraggable: false,
              parallaxEnabled: true,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
              minHeight: 0,
              defaultPanelState: PanelState.CLOSED,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              panelBuilder: (ScrollController scrollController) {
                return BlocConsumer<SearchCubit, SearchState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is GetRequiredPropartyLoading) {
                      return Loading();
                    } else {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32)),
                            child: Container(
                              color: white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8),
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  HeaderWidget(
                                    closeTap: () {
                                      context
                                          .read<SearchCubit>()
                                          .emptyFilters();
                                      context
                                          .read<SearchCubit>()
                                          .fGetSearch(isFirst: true);
                                      _pc.close();
                                      context
                                          .read<SearchCubit>()
                                          .emptyFilters();
                                    },
                                    resetTap: () {
                                      context
                                          .read<SearchCubit>()
                                          .emptyFilters();
                                      // context
                                      //     .read<SearchCubit>()
                                      //     .fGetSearch(isFirst: true);
                                      // _pc.close();
                                      context
                                          .read<SearchCubit>()
                                          .emptyFilters();
                                    },
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  PerpuseWidget(),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SliderRangeWidget(
                                    onChanged: (SfRangeValues values) {
                                      setState(() {
                                        context.read<SearchCubit>().priceRange =
                                            values;
                                      });

                                      log(context
                                          .read<SearchCubit>()
                                          .priceRange
                                          .end
                                          .toString());
                                    },
                                    values:
                                        context.watch<SearchCubit>().priceRange,
                                    text: tr("price_range"),
                                    area: false,
                                    min: context.watch<SearchCubit>().minPrice!,
                                    max: context.watch<SearchCubit>().maxPrice!,
                                    interval: (context
                                                .watch<SearchCubit>()
                                                .minPrice! +
                                            context
                                                .watch<SearchCubit>()
                                                .maxPrice!) /
                                        10,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  FeatureFilterPropertyWidget(),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SliderRangeWidget(
                                    onChanged: (SfRangeValues values) {
                                      setState(() {
                                        context.read<SearchCubit>().areaRange =
                                            values;
                                      });

                                      log(context
                                          .read<SearchCubit>()
                                          .priceRange
                                          .end
                                          .toString());
                                    },
                                    values:
                                        context.watch<SearchCubit>().areaRange,
                                    text: tr("property_area"),
                                    area: true,
                                    min: context.watch<SearchCubit>().minArea!,
                                    max: context.watch<SearchCubit>().maxArea!,
                                    interval:
                                        (context.watch<SearchCubit>().minArea! +
                                                context
                                                    .watch<SearchCubit>()
                                                    .maxArea!) /
                                            10,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      tr("property_type"),
                                      style: TextStyles.textViewSemiBold16
                                          .copyWith(color: black1),
                                    ),
                                  ),
                                  SelectedMultiChipListWidget(
                                    listOfChipNames:
                                        context.read<SearchCubit>().typesList,
                                    shouldWrap: true,
                                    supportsMultiSelect: true,
                                    activeBgColorList: [iconColor],
                                    inactiveBgColorList: [Colors.white],
                                    activeTextColorList: [Colors.white],
                                    inactiveTextColorList: [iconColor],
                                    listOfChipIndicesCurrentlySeclected: [100],
                                    activeBorderColorList: [secondry2],
                                    extraOnToggle: (index) {
                                      context
                                              .read<SearchCubit>()
                                              .setpropertyId =
                                          context
                                              .read<SearchCubit>()
                                              .typesList[index]
                                              .id;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      tr("amenities"),
                                      style: TextStyles.textViewSemiBold16
                                          .copyWith(color: black1),
                                    ),
                                  ),
                                  SelectedMultiChipListWidget(
                                    listOfChipNames: context
                                        .read<SearchCubit>()
                                        .amenitiesList,
                                    shouldWrap: true,
                                    supportsMultiSelect: true,
                                    activeBgColorList: [iconColor],
                                    inactiveBgColorList: [Colors.white],
                                    activeTextColorList: [Colors.white],
                                    inactiveTextColorList: [iconColor],
                                    listOfChipIndicesCurrentlySeclected: [100],
                                    activeBorderColorList: [secondry2],
                                    extraOnToggle: (index) {
                                      context
                                              .read<SearchCubit>()
                                              .setAmenitiesId =
                                          context
                                              .read<SearchCubit>()
                                              .amenitiesList[index]
                                              .id;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  BlocConsumer<SearchCubit, SearchState>(
                                    listener: (context, state) {
                                      if (state is SearchLoadedState) {
                                        _pc.close();
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is SearchLoadingState) {
                                        return Loading();
                                      } else {
                                        return GenericButton(
                                          onPressed: () {
                                            context
                                                .read<SearchCubit>()
                                                .getFeaturesAdd
                                                .removeWhere((element) =>
                                                    element.count == 0);
                                            context
                                                .read<SearchCubit>()
                                                .filterEnabled = true;
                                            context
                                                .read<SearchCubit>()
                                                .fGetSearch(
                                                    isFirst: true,
                                                    locationId:
                                                        widget.locationId);
                                          },
                                          child: Text(
                                            tr(tr("apply")),
                                            style: TextStyles.textViewSemiBold16
                                                .copyWith(color: white),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                          color: primary,
                                          width: 336.w,
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                  )
                                ]),
                              ),
                            )),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButton: InkWell(
          onTap: () {
            sl<AppNavigator>().push(
                screen: SearchOnMap(
                    markerIcon: context.read<SearchCubit>().markerIcon!));
          },
          child: Container(
            height: 65.h,
            width: 65.h,
            decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor),
            child: SvgPicture.asset(
              mapIcon,
              height: 20.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchDataList extends StatelessWidget {
  const SearchDataList({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return Loading();
          }
          if (state is SearchErrorState) {
            return Center(
                child: ErrorScreen(
                    // text: "Error Occuerd",
                    ));
          }
          final cubit = context.watch<SearchCubit>();
          final searchList = cubit.searchDataList;
          return searchList.isEmpty
              ? Center(
                  child: EmptyListingScreen(
                  text: tr("No Listing Founded"),
                  image: manImage,
                  subText: "",
                ))
              : ListView.builder(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: searchList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == searchList.length) {
                      if (state is SearchPaginationState) {
                        return PaginateLoading();
                      } else {
                        return const SizedBox();
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardListing(
                        listiningTest: searchList[index],
                        isSearch: true,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
