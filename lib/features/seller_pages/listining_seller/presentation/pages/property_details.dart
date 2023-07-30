// import 'dart:math';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lt;
import 'package:showcaseview/showcaseview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/styles/map_style.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/custom_network.dart';
import '../../../../../core/util/costom_gallery.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/map_for_show.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/util/share_icon.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../../../chat/presentation/cubit/chat_cubit.dart';
import '../../../../chat/presentation/pages/chat_screen.dart';
import '../../../../favourite/presentation/widgets/favourite_icon.dart';
import '../../data/models/my_listing_model.dart';
import '../../domain/usecases/get_listing_data_usecase.dart';
import '../cubit/get_one_listing_cubit/get_one_listing_cubit.dart';
import '../widgets/agent_card.dart';
import '../widgets/amenities_widget.dart';
import '../widgets/feature_widget.dart';
import 'web_view/web_view_360_screen.dart';

class PropertyDetails extends StatelessWidget {
  final String listingId;
  PropertyDetails({super.key, required this.listingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        builder: Builder(
            builder: (context) => PropertyDetailsCase(
                  listingId: listingId,
                )),
      ),
    );
  }
}

class PropertyDetailsCase extends StatefulWidget {
  final String listingId;
  PropertyDetailsCase({super.key, required this.listingId});

  @override
  State<PropertyDetailsCase> createState() => _PropertyDetailsCaseState();
}

class _PropertyDetailsCaseState extends State<PropertyDetailsCase> {
  PropertyUser? user;
  Uint8List? markerIcon;
  Future<Uint8List> getBytesFromAsset() async {
    ByteData data = await rootBundle.load('assets/images/markerImage.png');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIcon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
    return markerIcon!;
  }

  final GlobalKey _first = GlobalKey();
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  void initState() {
    super.initState();
    getBytesFromAsset();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ShowCaseWidget.of(context).startShowCase([
        _first,
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    log(sl<BlocMainCubit>().repository.loadAppData()!.id.toString());
    // Future displayShowcase = sl<GetOneListingCubit>().displayShowcase();
    // // context.watch<GetOneListingCubit>().displayShowcase();
    // displayShowcase.then((status) {
    //   if (status) {
    //     ShowCaseWidget.of(context).startShowCase([
    //       _first,
    //     ]);
    //   }
    // });
    return BlocProvider(
        lazy: false,
        create: (context) => sl<GetOneListingCubit>()
          ..fGetOneListing(
              getListingDataParams:
                  GetListingDataParams(listingId: widget.listingId)),
        child: BlocConsumer<GetOneListingCubit, GetOneListingState>(
            listener: (context, state) {
          if (state is GetOneListingSuccess) {
            user = state.myListingData.property.user;
          }
        }, builder: (context, state) {
          if (state is GetOneListingLoading) {
            return Scaffold(
              appBar: AppBarGeneric(
                title: tr("property_perview"),
                titleColor: textColor,
                onPressed: () {
                  sl<AppNavigator>().pop();
                },
              ),
              body: Loading(),
            );
          } else if (state is GetOneListingSuccess) {
            List<String> images = [];
            state.myListingData.property.images.forEach((element) {
              images.add(EndPoints.baseImages + element.path);
            });
            return Scaffold(
              appBar: AppBarGeneric(
                title: sl<BlocMainCubit>().repository.loadAppData()!.id !=
                        state.myListingData.property.user!.id
                    ? ""
                    : tr("property_perview"),
                titleColor: textColor,
                onPressed: () {
                  sl<AppNavigator>().pop();
                },
                actions: sl<BlocMainCubit>().repository.loadAppData()!.id ==
                        state.myListingData.property.user!.id
                    ? []
                    : [
                        (state.myListingData.property.status == "active" ||
                                state.myListingData.property.status ==
                                    "featured")
                            ? ShareIcon(
                                id: state.myListingData.property.id,
                              )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FavoriteIcon(
                            id: state.myListingData.property.id,
                            isFavorite: state.myListingData.property.isFav,
                            width: 40.w,
                            height: 40.h,
                            size: 25,
                            color: textColorLight,
                          ),
                        ),
                      ],
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: state.myListingData.property.url == null
                                ? null
                                : () {
                                    // sl<AppNavigator>().push(
                                    //     screen: WebView360Screen(
                                    //   url: state.myListingData.property.url,
                                    //   title: state.myListingData.property.title,
                                    // ));
                                  },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40.r),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 383.h,
                                child: state.myListingData.property.coverImage
                                        .isEmpty
                                    ? Image.asset(homeImage)
                                    : CustomImageWidgegt(
                                        image: EndPoints.baseImages +
                                            state.myListingData.property
                                                .coverImage,
                                      ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                          state.myListingData.property.url == null
                              ? SizedBox()
                              : Positioned(
                                  top: 15.h,
                                  right: 15.h,
                                  child: InkWell(
                                    onTap: () {
                                      // sl<AppNavigator>().push(
                                      //     screen: WebView360Screen(
                                      //   url: state.myListingData.property.url,
                                      //   title:
                                      //       state.myListingData.property.title,
                                      // ));
                                    },
                                    child: Container(
                                      height: 60.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: white.withOpacity(0.7)),
                                      child: lt.Lottie.asset(
                                        dgree,
                                      ),
                                    ),
                                  ),
                                ),
                          // Positioned(
                          //     top: 15.h,
                          //     right: 15.h,
                          //     child: Showcase(
                          //       targetPadding: const EdgeInsets.all(5),
                          //       key: _first,
                          //       title: 'MakanVi',
                          //       textColor: primary,
                          //       description:
                          //           "Tap to see 3D Model For Property",
                          //       child: InkWell(
                          //         onTap: () {
                          //           sl<AppNavigator>().push(
                          //               screen: WebView360Screen(
                          //             url: state.myListingData.property.url,
                          //             title: state
                          //                 .myListingData.property.title,
                          //           ));
                          //         },
                          //         child: Container(
                          //           height: 60.h,
                          //           width: 60.w,
                          //           decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //               color: white.withOpacity(0.7)),
                          //           child: lt.Lottie.asset(
                          //             dgree,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                        ],
                      ),
                      // state.myListingData.property.images.isEmpty
                      //     ? SizedBox()
                      //     : CustomGalleryImage(
                      //         titleGallery: state.myListingData.property.title,
                      //         numOfShowImages:
                      //             images.length > 3 ? 3 : images.length,
                      //         imageUrls: images),
                      SizedBox(
                        height: 22.h,
                      ),
                      Text(state.myListingData.property.title,
                          style: TextStyles.textViewMedium23
                              .copyWith(color: titelsColor)),
                      Text(
                          "${state.myListingData.property.currency} ${state.myListingData.property.price.toStringAsFixed(2)}",
                          style: TextStyles.textViewBold23
                              .copyWith(color: titelsColor)),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(areaIcon),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(state.myListingData.property.area.toString(),
                              style: TextStyles.textViewMedium16
                                  .copyWith(color: titelsColor)),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(tr("sq_area"),
                              style: TextStyles.textViewMedium16
                                  .copyWith(color: titelsColor)),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(tr("agent"),
                          style: TextStyles.textViewMedium16
                              .copyWith(color: titelsColor)),
                      SizedBox(
                        height: 12.h,
                      ),
                      AgentCard(
                        user: state.myListingData.property.user!,
                        listingId: widget.listingId,
                      ),
                      SizedBox(
                        height: 37.h,
                      ),
                      Text(tr("features"),
                          style: TextStyles.textViewMedium16
                              .copyWith(color: titelsColor)),
                      SizedBox(
                        height: 16.h,
                      ),
                      FeatureWidget(
                          features: state.myListingData.property.features!),
                      SizedBox(
                        height: 37.h,
                      ),
                      Text(tr("description"),
                          style: TextStyles.textViewMedium16
                              .copyWith(color: titelsColor)),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(state.myListingData.property.description,
                          textAlign: TextAlign.justify,
                          style: TextStyles.textViewMedium16
                              .copyWith(color: grey)),
                      SizedBox(
                        height: 37.h,
                      ),
                      Text(tr("amenities"),
                          style: TextStyles.textViewMedium16
                              .copyWith(color: titelsColor)),
                      SizedBox(
                        height: 16.h,
                      ),
                      state.myListingData.property.amenities!.isEmpty
                          ? SizedBox()
                          : AmenitiesWidget(
                              amenities:
                                  state.myListingData.property.amenities!,
                            ),
                      SizedBox(
                        height: 37.h,
                      ),
                      Text(tr("location"),
                          style: TextStyles.textViewMedium16
                              .copyWith(color: titelsColor)),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(locationIconsSvg),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                              "${state.myListingData.property.location.city}, ${state.myListingData.property.location.state}, ${state.myListingData.property.location.country}",
                              style: TextStyles.textViewMedium12
                                  .copyWith(color: textColorLight)),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
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
                            //       borderRadius: BorderRadius.circular(30.r),
                            //       // color: primary,
                            //     ),
                            //     alignment: Alignment.center,
                            //     child: GoogleMap(
                            //       myLocationButtonEnabled: false,
                            //       initialCameraPosition: CameraPosition(
                            //           target: LatLng(
                            //               double.parse(state.myListingData
                            //                   .property.location.latitude),
                            //               double.parse(state.myListingData
                            //                   .property.location.longitude)),
                            //           zoom: 15),
                            //       markers: {
                            //         Marker(
                            //           markerId: MarkerId("".toString()),
                            //           position: LatLng(
                            //               double.parse(state.myListingData
                            //                   .property.location.latitude),
                            //               double.parse(state.myListingData
                            //                   .property.location.longitude)),
                            //           infoWindow: InfoWindow(
                            //               title: "", snippet: "_detail"),
                            //           icon: markerIcon == null
                            //               ? BitmapDescriptor.defaultMarker
                            //               : BitmapDescriptor.fromBytes(
                            //                   markerIcon!),
                            //           // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.mainColor),
                            //         )
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
                                // sl<AppNavigator>().push(
                                //     screen: ScreenForShowOnMap(
                                //   images: images,
                                //   latitude: double.parse(state.myListingData
                                //       .property.location.latitude),
                                //   longitude: double.parse(state.myListingData
                                //       .property.location.longitude),
                                //   markerIcon: markerIcon!,
                                // ));
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    height: 40.h,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30.r),
                                          bottomRight: Radius.circular(30.r)),
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
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is GetChannelIdSuccessLoadingState) {
                    sl<AppNavigator>().push(
                        screen: ChatScreen(
                      channelID: int.parse(state.messageSuccess),
                      name: user!.name,
                      imagePath: user!.profilePhotoPath,
                      propertyId: int.parse(widget.listingId),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is GetChannelIdLoadingState) {
                    return Loading();
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 15.h,
                      ),
                      child: Container(
                        height: 80.h,
                        color: white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: user!.id.toString() ==
                                        sl<BlocMainCubit>()
                                            .repository
                                            .loadAppData()!
                                            .id
                                    ? null
                                    : () {
                                        context
                                            .read<ChatCubit>()
                                            .fgetChannelId(userId: user!.id);
                                      },
                                child: Container(
                                  height: 60.h,
                                  // width: 200.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      color: user == null
                                          ? null
                                          : user!.id.toString() ==
                                                  sl<BlocMainCubit>()
                                                      .repository
                                                      .loadAppData()!
                                                      .id
                                              ? disabled
                                              : primary),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(chatIconSvg,
                                            color: white),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text(tr("message_agent"),
                                            style: TextStyles.textViewSemiBold16
                                                .copyWith(color: white))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              InkWell(
                                onTap: user!.id.toString() ==
                                        sl<BlocMainCubit>()
                                            .repository
                                            .loadAppData()!
                                            .id
                                    ? null
                                    : () {
                                        _makePhoneCall(
                                            user!.mobileCountry.countryCode +
                                                user!.mobileNumber);
                                      },
                                child: Container(
                                  height: 60.h,
                                  width: 115.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(
                                          color: user!.id.toString() ==
                                                  sl<BlocMainCubit>()
                                                      .repository
                                                      .loadAppData()!
                                                      .id
                                                      .toString()
                                              ? disabled
                                              : primary),
                                      color: white),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(CallSvg,
                                            color: user!.id.toString() ==
                                                    sl<BlocMainCubit>()
                                                        .repository
                                                        .loadAppData()!
                                                        .id
                                                ? disabled
                                                : primary),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text(tr("call"),
                                            style: TextStyles.textViewSemiBold16
                                                .copyWith(
                                                    color: user!.id
                                                                .toString() ==
                                                            sl<BlocMainCubit>()
                                                                .repository
                                                                .loadAppData()!
                                                                .id
                                                                .toString()
                                                        ? disabled
                                                        : primary))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBarGeneric(
                title: tr("property_perview"),
                titleColor: textColor,
                onPressed: () {
                  sl<AppNavigator>().pop();
                },
              ),
              body: ErrorScreen(),
            );
          }
        }));
  }
}
