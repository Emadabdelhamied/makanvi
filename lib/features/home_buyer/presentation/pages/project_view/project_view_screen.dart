import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makanvi_web/core/widgets/error_screen.dart';
import 'package:makanvi_web/core/widgets/loading.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/presentation/pages/property_details.dart';
import 'package:makanvi_web/injection_container.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/map_style.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/util/show_project_on_map.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../seller_pages/listining_seller/presentation/widgets/agent_card.dart';
import '../../cubit/project_details_cubit/project_details_cubit.dart';
import '../../cubit/search_cubit/search_cubit.dart';
import '../../widget/project_view/listing_in_projects.dart';
import '../../widget/project_view/project_images_widget.dart';

class ProjectView extends StatelessWidget {
  final int projectId;
  final String projectName;

  ProjectView({super.key, required this.projectId, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProjectDetailsCubit>()
        ..fGetProject(id: projectId)
        ..getBytesFromAsset(),
      child: BlocConsumer<ProjectDetailsCubit, ProjectDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProjectLoadingState) {
            return Scaffold(
              appBar: AppBarGeneric(
                title: projectName,
                titleColor: textColor,
                onPressed: () {
                  sl<AppNavigator>().pop();
                },
              ),
              body: Loading(),
            );
          } else if (state is ProjectSuccess) {
            List<String> images = [];
            state.project.images.forEach((element) {
              images.add(EndPoints.baseImages + element["path"]);
            });
            return Scaffold(
              appBar: AppBarGeneric(
                title: projectName,
                titleColor: textColor,
                onPressed: () {
                  sl<AppNavigator>().pop();
                },
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProjectImagesWidget(
                        images: images,
                        cover: state.project.coverImagePath,
                        title: state.project.name,
                      ),
                      SizedBox(
                        height: 37.h,
                      ),
                      Text(tr('description'),
                          style: TextStyles.textViewMedium16
                              .copyWith(color: titelsColor)),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(state.project.description,
                          textAlign: TextAlign.justify,
                          style: TextStyles.textViewMedium16
                              .copyWith(color: titelsColor)),
                      SizedBox(
                        height: 37.h,
                      ),
                      Text(tr('agent_responsible'),
                          style: TextStyles.textViewMedium16
                              .copyWith(color: titelsColor)),
                      SizedBox(
                        height: 12.h,
                      ),
                      AgentCard(
                        user: state.project.agent,
                        listingId: projectId.toString(),
                      ),
                      SizedBox(
                        height: 37.h,
                      ),
                      state.project.properties.isEmpty
                          ? SizedBox()
                          : Container(
                              height: 300.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                              child: Stack(
                                children: [
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(40.r),
                                  //   child: Container(
                                  //     height: 300.h,
                                  //     width: MediaQuery.of(context).size.width,
                                  //     decoration: BoxDecoration(
                                  //       borderRadius:
                                  //           BorderRadius.circular(30.r),
                                  //       // color: primary,
                                  //     ),
                                  //     alignment: Alignment.center,
                                  //     child: GoogleMap(
                                  //       myLocationButtonEnabled: false,
                                  //       initialCameraPosition: CameraPosition(
                                  //           target: LatLng(
                                  //               double.parse(state
                                  //                   .project
                                  //                   .properties
                                  //                   .first
                                  //                   .location
                                  //                   .latitude),
                                  //               double.parse(state
                                  //                   .project
                                  //                   .properties
                                  //                   .first
                                  //                   .location
                                  //                   .longitude)),
                                  //           zoom: 10),
                                  //       markers: {
                                  //         for (var element
                                  //             in state.project.properties)
                                  //           Marker(
                                  //             markerId: MarkerId(
                                  //                 "${element.id}".toString()),
                                  //             position: LatLng(
                                  //                 double.parse(element
                                  //                     .location.latitude),
                                  //                 double.parse(element
                                  //                     .location.longitude)),
                                  //             infoWindow: InfoWindow(
                                  //                 title: "${element.id}",
                                  //                 snippet: "_detail"),
                                  //             icon: context
                                  //                         .watch<
                                  //                             ProjectDetailsCubit>()
                                  //                         .markerIcon ==
                                  //                     null
                                  //                 ? BitmapDescriptor
                                  //                     .defaultMarker
                                  //                 : BitmapDescriptor.fromBytes(
                                  //                     context
                                  //                         .watch<
                                  //                             ProjectDetailsCubit>()
                                  //                         .markerIcon!),
                                  //           )
                                  //       },
                                  //       zoomControlsEnabled: false,
                                  //       onMapCreated:
                                  //           (GoogleMapController controller) {
                                  //         controller.setMapStyle(mapStyle);
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      context
                                          .read<SearchCubit>()
                                          .emptyFilters();
                                      sl<AppNavigator>().push(
                                          screen: ProjectShowOnMap(
                                        //images: images,
                                        markerIcon: context
                                            .read<ProjectDetailsCubit>()
                                            .markerIcon!,
                                        properties: state.project.properties,
                                        title: state.project.name,
                                        // markers: {
                                        //   for (var element
                                        //       in state.project.properties)
                                        //     Marker(
                                        //       markerId: MarkerId(
                                        //           "${element.id}".toString()),
                                        //       position: LatLng(
                                        //           double.parse(element
                                        //               .location.latitude),
                                        //           double.parse(element
                                        //               .location.longitude)),
                                        //       infoWindow: InfoWindow(
                                        //           title:
                                        //               "${element.currency} ${element.price}",
                                        //           onTap: () {
                                        //             sl<AppNavigator>().push(
                                        //                 screen: PropertyDetails(
                                        //                     listingId: element
                                        //                         .id
                                        //                         .toString()));
                                        //           },
                                        //           snippet:
                                        //               "${element.location.city},${element.location.state},${element.location.country}"),
                                        //       icon: context
                                        //                   .read<
                                        //                       ProjectDetailsCubit>()
                                        //                   .markerIcon ==
                                        //               null
                                        //           ? BitmapDescriptor
                                        //               .defaultMarker
                                        //           : BitmapDescriptor.fromBytes(
                                        //               context
                                        //                   .read<
                                        //                       ProjectDetailsCubit>()
                                        //                   .markerIcon!),
                                        //     )
                                        // },
                                        latitude: double.parse(state
                                            .project
                                            .properties
                                            .first
                                            .location
                                            .latitude),
                                        longitude: double.parse(state
                                            .project
                                            .properties
                                            .first
                                            .location
                                            .longitude),
                                      ));
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          height: 40.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(30.r),
                                                bottomRight:
                                                    Radius.circular(30.r)),
                                            color: white,
                                          ),
                                          child: Text(
                                            tr("view_on_map"),
                                            style: TextStyles.textViewMedium16
                                                .copyWith(color: textColor),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 37.h,
                      ),
                      Text(
                          '${state.project.properties.length} ${state.project.properties.length > 10 ? tr("place") : tr("listings")}',
                          style: TextStyles.textViewMedium16
                              .copyWith(color: titelsColor)),
                      SizedBox(
                        height: 16.h,
                      ),
                      SizedBox(
                        height:
                            150 * state.project.properties.length.toDouble(),
                        child: ListingInProjectWidget(
                            properties: state.project.properties),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBarGeneric(
                title: projectName,
                titleColor: textColor,
                onPressed: () {
                  sl<AppNavigator>().pop();
                },
              ),
              body: ErrorScreen(),
            );
          }
        },
      ),
    );
  }
}
