import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/home_buyer/presentation/cubit/search_cubit/search_cubit.dart';
import '../../features/home_buyer/presentation/widget/project_view/property_card.dart';
import '../../features/seller_pages/listining_seller/data/models/my_listing_model.dart';
import '../../injection_container.dart';
import '../constant/colors/colors.dart';
import '../constant/styles/styles.dart';
import '../widgets/appbar_generic.dart';
import 'navigator.dart';

class ProjectShowOnMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Uint8List markerIcon;
  final List<Property> properties;

  final String title;
  // final Set<Marker> markers;
  const ProjectShowOnMap(
      {super.key,
      required this.title,
      required this.properties,
      required this.latitude,
      required this.longitude,
      // required this.markers,
      required this.markerIcon});

  @override
  State<ProjectShowOnMap> createState() => _ProjectShowOnMapState();
}

class _ProjectShowOnMapState extends State<ProjectShowOnMap> {
  @override
  Widget build(BuildContext context) {
    // context.read<SearchCubit>().searchMarkers = widget.markers;
    return Scaffold(
      appBar: AppBarGeneric(
        title: widget.title,
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
              //       target: LatLng(
              //         widget.latitude,
              //         widget.longitude,
              //       ),
              //       zoom: 15),
              //   markers: widget.markers,
              //   zoomControlsEnabled: false,
              //   onMapCreated: (GoogleMapController controller) {
              //     controller.setMapStyle(mapStyle);
              //   },
              // ),
              Align(
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
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: primary),
                                    child: Center(
                                        child: Text(
                                            context
                                                        .watch<SearchCubit>()
                                                        .total ==
                                                    0
                                                ? widget.properties.length
                                                    .toString()
                                                : context
                                                    .watch<SearchCubit>()
                                                    .total
                                                    .toString(),
                                            style: TextStyles.textViewMedium12
                                                .copyWith(color: white)))),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                    context.watch<SearchCubit>().total == 0
                                        ? tr('Nearby')
                                        : tr("Found"),
                                    style: TextStyles.textViewMedium12
                                        .copyWith(color: white))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: context.watch<SearchCubit>().total == 0
                              ? widget.properties.length
                              : context
                                  .watch<SearchCubit>()
                                  .searchDataList
                                  .length,
                          itemBuilder: (context, index) {
                            var search =
                                context.watch<SearchCubit>().searchDataList;
                            return PropertyCard(
                              property: context.watch<SearchCubit>().total == 0
                                  ? widget.properties[index]
                                  : Property(
                                      id: search[index].id,
                                      title: widget.title,
                                      currency: search[index].currency,
                                      price: search[index].price,
                                      isFav: search[index].isFav,
                                      status: search[index].status,
                                      images: search[index].images,
                                      location: search[index].location,
                                      listingExpireAfter:
                                          search[index].listingExpireAfter,
                                      featureExpireAfter:
                                          search[index].featureExpireAfter,
                                      area: 0,
                                      isNegotiable: 0,
                                      description: '',
                                      recommendedShootingDate: DateTime.now(),
                                      shootingDate: search[index].shootingDate,
                                      coverImage: search[index].coverImage),
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
