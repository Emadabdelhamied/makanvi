import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makanvi_web/core/constant/styles/styles.dart';
import '../../../../../features/seller_pages/listining_seller/data/models/my_listings_all_model.dart'
    as model;
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/map_style.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../injection_container.dart';
import '../../../../seller_pages/listining_seller/data/models/my_listing_model.dart';
import '../../widget/project_view/property_card.dart';

class FeaturedPropertyShowOnMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Uint8List markerIcon;
  final List properties;

  final String title;
  final Set<Marker> markers;
  const FeaturedPropertyShowOnMap(
      {super.key,
      required this.title,
      required this.properties,
      required this.latitude,
      required this.longitude,
      required this.markers,
      required this.markerIcon});

  @override
  State<FeaturedPropertyShowOnMap> createState() =>
      _FeaturedPropertyShowOnMapState();
}

class _FeaturedPropertyShowOnMapState extends State<FeaturedPropertyShowOnMap> {
  @override
  Widget build(BuildContext context) {
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
              GoogleMap(
                myLocationButtonEnabled: false,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget.latitude,
                      widget.longitude,
                    ),
                    zoom: 15),
                markers: widget.markers,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle(mapStyle);
                },
              ),
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
                        width: 112.w,
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
                                            widget.properties.length.toString(),
                                            style: TextStyles.textViewMedium12
                                                .copyWith(color: white)))),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text("Found",
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
                          itemCount: widget.properties.length,
                          itemBuilder: (context, index) {
                            return PropertyCard(
                              property: Property(
                                  id: widget.properties[index].id,
                                  title: widget.title,
                                  currency: widget.properties[index].currency,
                                  price: widget.properties[index].price,
                                  coverImage:
                                      widget.properties[index].coverImage,
                                  isFav:
                                      widget.properties[index].isFav ?? false,
                                  status: widget.properties[index].status,
                                  images:
                                      widget.properties[index].images.isEmpty
                                          ? []
                                          : [
                                              model.Image(
                                                id: widget.properties[index]
                                                    .images.first["id"],
                                                propertyId: widget
                                                    .properties[index]
                                                    .images
                                                    .first["property_id"],
                                                path: widget.properties[index]
                                                    .images.first["path"],
                                                order: widget.properties[index]
                                                    .images.first["order"],
                                                createdAt: DateTime.parse(widget
                                                    .properties[index]
                                                    .images
                                                    .first["created_at"]),
                                                updatedAt: DateTime.parse(widget
                                                    .properties[index]
                                                    .images
                                                    .first["updated_at"]),
                                              ),
                                            ],
                                  location: widget.properties[index].location,
                                  listingExpireAfter: widget
                                      .properties[index].listingExpireAfter,
                                  featureExpireAfter: widget
                                      .properties[index].featureExpireAfter,
                                  area: 0,
                                  isNegotiable: 0,
                                  description: '',
                                  recommendedShootingDate: DateTime.now(),
                                  shootingDate:
                                      widget.properties[index].shootingDate),
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
