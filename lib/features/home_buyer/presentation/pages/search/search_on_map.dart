import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makanvi_web/core/constant/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/map_style.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../../../auth/presentation/widgets/add_property_widget/selected_multi_chip_widget.dart';
import '../../../../seller_pages/listining_seller/presentation/pages/property_details.dart';
import '../../cubit/search_cubit/search_cubit.dart';
import '../../widget/filter_widgets/features_widget.dart';
import '../../widget/filter_widgets/header_widget.dart';
import '../../widget/filter_widgets/perpuse_widget.dart';
import '../../widget/filter_widgets/slider_range_widget.dart';
import '../../widget/project_view/search_on_map_widget.dart';
import '../../widget/search_on_map_card/search_on_map_card.dart';

class SearchOnMap extends StatefulWidget {
  final Uint8List markerIcon;

  SearchOnMap({super.key, required this.markerIcon});

  @override
  State<SearchOnMap> createState() => _SearchOnMapState();
}

class _SearchOnMapState extends State<SearchOnMap> {
  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(
        title: tr("search"),
        titleColor: textColor,
        onPressed: () {
          sl<AppNavigator>().pop();
        },
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              // GoogleMap(
              //   myLocationButtonEnabled: false,
              //   initialCameraPosition: CameraPosition(
              //       target: context.read<SearchCubit>().searchDataList.isEmpty
              //           ? LatLng(31.233334, 30.033333)
              //           : LatLng(
              //               double.parse(context
              //                   .read<SearchCubit>()
              //                   .searchDataList
              //                   .first
              //                   .location
              //                   .latitude),
              //               double.parse(context
              //                   .read<SearchCubit>()
              //                   .searchDataList
              //                   .first
              //                   .location
              //                   .longitude)),
              //       zoom: 15),
              //   markers: context.watch<SearchCubit>().searchMarkers,
              //   zoomControlsEnabled: false,
              //   onMapCreated: (GoogleMapController controller) {
              //     controller.setMapStyle(mapStyle);
              //   },
              // ),
              Align(
                alignment: Alignment.topCenter,
                child: SearchOnMapWidget(
                  filterTab: () {
                    context.read<SearchCubit>().fGetDataEditPropertyModel();

                    _pc.open();
                  },
                  controller: context.read<SearchCubit>().search,
                  onChange: (search) {
                    // context.read<SearchCubit>().search = search;
                    context.read<SearchCubit>().fGetSearch(isFirst: true);
                  },
                  onSubmitted: (search) {
                    // context.read<SearchCubit>().searchMarkers.clear();
                    // for (var element
                    //     in context.read<SearchCubit>().searchDataList) {
                    //   context.read<SearchCubit>().searchMarkers.add(Marker(
                    //         markerId: MarkerId("${element.id}".toString()),
                    //         position: LatLng(
                    //             double.parse(element.location.latitude),
                    //             double.parse(element.location.longitude)),
                    //         infoWindow: InfoWindow(
                    //             title: "${element.currency}${element.price}",
                    //             onTap: () {
                    //               sl<AppNavigator>().push(
                    //                   screen: PropertyDetails(
                    //                       listingId: element.id.toString()));
                    //             },
                    //             snippet:
                    //                 "${element.location.city},${element.location.state},${element.location.country}"),
                    //         icon: BitmapDescriptor.fromBytes(widget.markerIcon),
                    //       ));
                    // }
                    // // context.read<SearchCubit>().search.text = search;
                    context.read<SearchCubit>().fGetSearch(isFirst: true);
                  },
                ),
              ),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? context.read<SearchCubit>().searchDataList.isEmpty
                      ? SizedBox()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50.h,
                                  width: 122.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.r),
                                      color: iconColor),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 30.w,
                                              width: 30.w,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: primary),
                                              child: Center(
                                                  child: Text(
                                                      context
                                                          .watch<SearchCubit>()
                                                          .total
                                                          .toString(),
                                                      style: TextStyles
                                                          .textViewMedium12
                                                          .copyWith(
                                                              color: white)))),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(tr('Nearby'),
                                              style: TextStyles.textViewMedium12
                                                  .copyWith(color: white))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              MyWidget(
                                count: context
                                    .watch<SearchCubit>()
                                    .searchDataList
                                    .length,
                              ),
                            ],
                          ),
                        )
                  : SizedBox()
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
                                    context.read<SearchCubit>().emptyFilters();
                                    context
                                        .read<SearchCubit>()
                                        .fGetSearch(isFirst: true);
                                    _pc.close();
                                    context.read<SearchCubit>().emptyFilters();
                                  },
                                  resetTap: () {
                                    context.read<SearchCubit>().emptyFilters();
                                    // context
                                    //     .read<SearchCubit>()
                                    //     .fGetSearch(isFirst: true);
                                    // _pc.close();
                                    // context.read<SearchCubit>().emptyFilters();
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
                                  interval:
                                      (context.watch<SearchCubit>().minPrice! +
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
                                        .copyWith(color: titelsColor),
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
                                    context.read<SearchCubit>().setpropertyId =
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
                                    tr("ammenities"),
                                    style: TextStyles.textViewSemiBold16
                                        .copyWith(color: titelsColor),
                                  ),
                                ),
                                SelectedMultiChipListWidget(
                                  listOfChipNames:
                                      context.read<SearchCubit>().amenitiesList,
                                  shouldWrap: true,
                                  supportsMultiSelect: true,
                                  activeBgColorList: [iconColor],
                                  inactiveBgColorList: [Colors.white],
                                  activeTextColorList: [Colors.white],
                                  inactiveTextColorList: [iconColor],
                                  listOfChipIndicesCurrentlySeclected: [100],
                                  activeBorderColorList: [secondry2],
                                  extraOnToggle: (index) {
                                    context.read<SearchCubit>().setAmenitiesId =
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
                                              .fGetSearch(isFirst: true);
                                        },
                                        child: Text(
                                          tr("apply"),
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
    );
  }
}
