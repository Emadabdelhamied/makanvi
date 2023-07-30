// import 'dart:async';
// import 'dart:developer';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';

// import '../../../../../../bloc/main_cubit/bloc_main_cubit.dart';
// import '../../../../../../core/constant/colors/colors.dart';
// import '../../../../../../core/constant/icons.dart';
// import '../../../../../../core/constant/styles/styles.dart';
// import '../../../../../../core/hive/hive_helper.dart';
// import '../../../../../../core/util/navigator.dart';
// import '../../../../../../core/widgets/button.dart';
// import '../../../../../../core/widgets/loading.dart';
// import '../../../../../../injection_container.dart';
// import '../../../../../auth/presentation/widgets/add_property_widget/map_widget.dart';
// import '../../../../../auth/presentation/widgets/add_property_widget/search_field.dart';
// import '../../../../../home_buyer/presentation/pages/home_main_buyer.dart';
// import '../../../../data/models/update_location_model.dart';
// import '../../../../domain/usecases/update_location_usecase.dart';
// import '../../../cubit/update_location/update_location_cubit.dart';

// class SetLocationBuyerScreen extends StatefulWidget {
//   final bool isUpdateApi;
//   final LatLng? myLocationIfSelect;

//   const SetLocationBuyerScreen({
//     super.key,
//     this.isUpdateApi = false,
//     this.myLocationIfSelect,
//   });

//   static const LatLng _latlng = LatLng(26.06750, 50.55111);

//   @override
//   State<SetLocationBuyerScreen> createState() => _SetLocationBuyerScreenState();
// }

// const kGoogleApiKey = 'AIzaSyB38_1XJa_Yy92TyTfUCpuRqSCc9hWTpBQ';
// final homeScaffoldKey = GlobalKey<ScaffoldState>();

// class _SetLocationBuyerScreenState extends State<SetLocationBuyerScreen> {
//   LatLng? _selectLoction;

//   final Completer<GoogleMapController> _controller = Completer();
//   final Mode _mode = Mode.overlay;
//   late GoogleMapController googleMapController;

// // static const LatLng _center = LatLng(24.774265, 46.738586);
//   final Set<Marker> _markers = {};
//   LatLng _lastMapPosition = SetLocationBuyerScreen._latlng;
//   final MapType _currentMapType = MapType.normal;
//   final String _title = "";
//   final String _detail = "";
//   static double? _lat;
//   static double? _long;
//   _getUserLocation() async {
//     // LocationPermission permission;
//     // permission = await Geolocator.checkPermission();
//     // if (permission == LocationPermission.denied) {
//     //   permission = await Geolocator.requestPermission();
//     //   if (permission == LocationPermission.deniedForever) {
//     //     return Future.error('Location Not Available');
//     //   }
//     // } else if (permission == LocationPermission.whileInUse) {
//     final hasPermission = await _handleLocationPermission();
//     if (!hasPermission) return;
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     final GoogleMapController controller = await _controller.future;
//     setState(() {
//       _markers.clear();
//       _lat = position.latitude;
//       _long = position.longitude;
//       _markers.add(Marker(
//           markerId: MarkerId(position.latitude.toString()),
//           position: LatLng(position.latitude, position.longitude),
//           infoWindow: InfoWindow(title: _title, snippet: _detail),
//           icon: BitmapDescriptor.defaultMarker));
//       log(_lat.toString());
//       log(_long.toString());
//       _selectLoction = LatLng(position.latitude, position.longitude);
//       context.read<UpdateLocationCubit>().setAddressTitle('${_lat},${_long}',
//           EasyLocalization.of(context)!.currentLocale!.languageCode);
//     });

//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//             target: LatLng(position.latitude, position.longitude), zoom: 14),
//       ),
//     );
//     // } else {
//     //   throw Exception('Error');
//     // }
//   }

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//     googleMapController = controller;
//     // controller.setMapStyle(mapStyle);
//   }

//   void _onCameraMove(CameraPosition position) {
//     _lastMapPosition = position.target;
//   }

//   _onAddMarkerButtonPressed() {
//     _markers.clear();
//     setState(() {
//       _markers.add(Marker(
//           markerId: MarkerId(_selectLoction.toString()),
//           position: _selectLoction ?? _lastMapPosition,
//           infoWindow: InfoWindow(title: _title, snippet: _detail),
//           icon: BitmapDescriptor.defaultMarker));
//       log(_markers.toString());
//     });
//   }

//   _handleTap(LatLng point) {
//     _markers.clear();
//     _selectLoction == null;
//     // _getLocation(point);
//     log(_selectLoction.toString());
//     setState(() {
//       _markers.add(Marker(
//         markerId: MarkerId(point.toString()),
//         position: point,
//         infoWindow: InfoWindow(title: _title, snippet: _detail),
//         // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.mainColor),
//       ));
//       _lat = point.latitude;
//       _long = point.longitude;
//       _selectLoction = point;

//       context.read<UpdateLocationCubit>().setAddressTitle(
//           '${_selectLoction!.latitude},${_selectLoction!.longitude}',
//           EasyLocalization.of(context)!.currentLocale!.languageCode);
//       log(_selectLoction.toString());
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _selectLoction = widget.myLocationIfSelect;

//     widget.myLocationIfSelect != null
//         ? _onAddMarkerButtonPressed()
//         : _getUserLocation();
//     // _onAddMarkerButtonPressed();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var updateLocationCubit = context.read<UpdateLocationCubit>();

//     return Scaffold(
//       key: homeScaffoldKey,
//       extendBodyBehindAppBar: true,
//       extendBody: true,

//       appBar: AppBar(
//         backgroundColor: transparentColor,
//         automaticallyImplyLeading: false,
//         elevation: 0.0,
//         // leadingWidth: 80,
//         // leading: InkWell(
//         //   onTap: () {
//         //     sl<AppNavigator>().pop();
//         //     context.read<UpdateLocationCubit>().addressTitle = '';
//         //   },
//         //   child: Container(
//         //     height: 40.h,
//         //     width: 40.w,
//         //     decoration: BoxDecoration(
//         //       color: white,
//         //       shape: BoxShape.circle,
//         //     ),
//         //     alignment: Alignment.center,
//         //     child: Icon(
//         //       Icons.arrow_back,
//         //       size: 25,
//         //       color: black,
//         //     ),
//         //   ),
//         // )

//         // IconButton(

//         //   icon: Icon(
//         //     Icons.arrow_circle_left_sharp,
//         //     size: 30,
//         //     color: white,
//         //   ),
//         //   onPressed: () {
//         //     sl<AppNavigator>().popUtill(screen: AddPropertyScreen());
//         //   },
//         // ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             child: GoogleMap(
//               myLocationButtonEnabled: false,
//               zoomControlsEnabled: false,
//               onMapCreated: _onMapCreated,
//               myLocationEnabled: true,
//               initialCameraPosition: CameraPosition(
//                 tilt: 0.0,
//                 target:
//                     widget.myLocationIfSelect ?? SetLocationBuyerScreen._latlng,
//                 zoom: 15.0,
//               ),
//               markers: _markers,
//               mapType: _currentMapType,
//               onCameraMove: _onCameraMove,
//               onTap: _handleTap,
//             ),
//           ),
//           context.watch<UpdateLocationCubit>().addressTitle.isEmpty
//               ? SizedBox()
//               : Positioned(
//                   bottom: 100.h,
//                   left: 20.w,
//                   right: 20.w,
//                   child: MapCard(
//                       isSelected: true,
//                       text: context.watch<UpdateLocationCubit>().addressTitle)),
//           Positioned(
//             // bottom: 5,
//             top: 100.h,
//             // bottom: 10,
//             child: InkWell(
//               onTap: () {
//                 _handlePressButton();
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 // alignment: Alignment.center,
//                 child: SearchField(
//                   prefixIcon: ImageIcon(
//                     AssetImage(searchFieldIcon),
//                     color: iconColor,
//                   ),
//                   hintText: tr("search_for_location"),
//                   isFilled: true,
//                   isEnable: false,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: context.watch<UpdateLocationCubit>().addressTitle.isEmpty
//                 ? 100.h
//                 : 230.h,
//             right: 20.w,
//             child: FloatingActionButton(
//               onPressed: () {
//                 _getUserLocation();
//               },
//               backgroundColor: secondry2,
//               child: SvgPicture.asset(cicleIconSvg),
//             ),
//           )
//         ],
//       ),
//       //floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
//       backgroundColor: white,
//       bottomNavigationBar:
//           BlocConsumer<UpdateLocationCubit, UpdateLocationState>(
//         listener: (context, state) {
//           // TODO: implement listener
//         },
//         builder: (context, state) {
//           if (state is updateLocatinLoading) {
//             return Center(
//               child: Loading(),
//             );
//           }
//           return Container(
//             color: transparentColor,
//             padding: const EdgeInsets.all(20.0),
//             child: GenericButton(
//               onPressed: _selectLoction == null
//                   ? () {
//                       log(_selectLoction.toString());
//                     }
//                   : () async {
//                       context.read<UpdateLocationCubit>().setLocation =
//                           _selectLoction!;
//                       log('----------' +
//                           context
//                               .read<UpdateLocationCubit>()
//                               .getLocation
//                               .toString());

//                       if (widget.isUpdateApi == true) {
//                         context.read<UpdateLocationCubit>().fUpdateLocation(
//                               updateLocationParams: UpdateLocationParams(
//                                   countery: updateLocationCubit.countery,
//                                   city: updateLocationCubit.city,
//                                   state: updateLocationCubit.stateName,
//                                   lang: updateLocationCubit
//                                       .getLocation!.longitude
//                                       .toString(),
//                                   lat: updateLocationCubit.getLocation!.latitude
//                                       .toString()),
//                             );
//                       } else {
//                         String updateLocation =
//                             updateLocationModelToJson(UpdateLocationModel(
//                           city: updateLocationCubit.city,
//                           country: updateLocationCubit.countery,
//                           state: updateLocationCubit.stateName,
//                           cityAr: updateLocationCubit.cityAr,
//                           countryAr: updateLocationCubit.counteryAr,
//                           stateAr: updateLocationCubit.stateNameAr,
//                           latitude: updateLocationCubit.getLocation!.latitude
//                               .toString(),
//                           longitude: updateLocationCubit.getLocation!.longitude
//                               .toString(),
//                         ));

//                         // final SharedPreferences prefs =
//                         //     await SharedPreferences.getInstance();

//                         // await prefs.setString(
//                         //     'update_location', updateLocation);
//                         HiveHelper.putOnBox(
//                             boxName: BoxNames.updateLocation,
//                             key: "update_location",
//                             value: updateLocation);
//                       }
//                       context.read<BlocMainCubit>().updateLocation(
//                           location:
//                               "${updateLocationCubit.city},${updateLocationCubit.countery}",
//                           lang: updateLocationCubit.getLocation!.longitude
//                               .toString(),
//                           lat: updateLocationCubit.getLocation!.latitude
//                               .toString());
//                       await sl<AppNavigator>()
//                           .pushToFirst(screen: HomeMainBuyer());
//                     },
//               child: Text(
//                 tr("set_Location"),
//                 style: TextStyles.textViewSemiBold16.copyWith(color: white),
//               ),
//               borderRadius: BorderRadius.circular(15.sp),
//               color: primary,
//               width: 336.w,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<void> _handlePressButton() async {
//     Prediction? p = await PlacesAutocomplete.show(
//         context: context,
//         logo: SizedBox(),
//         apiKey: kGoogleApiKey,
//         onError: onError,
//         mode: _mode,
//         language: 'en',
//         strictbounds: false,
//         types: [""],
//         decoration: InputDecoration(
//             hintText: 'Search',
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide: const BorderSide(color: Colors.white))),
//         components: [
//           Component(Component.country, "eg"),
//           Component(Component.country, "sa"),
//           Component(Component.country, "bh"),
//         ]);

//     displayPrediction(p!, homeScaffoldKey.currentState);
//   }

//   void onError(PlacesAutocompleteResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         elevation: 0,
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.transparent,
//         content: Text(response.status)));
//   }

//   Future<void> displayPrediction(
//       Prediction p, ScaffoldState? currentState) async {
//     GoogleMapsPlaces places = GoogleMapsPlaces(
//         apiKey: kGoogleApiKey,
//         apiHeaders: await const GoogleApiHeaders().getHeaders());
//     PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
//     final lat = detail.result.geometry!.location.lat;
//     final lng = detail.result.geometry!.location.lng;

//     _handleTap(LatLng(lat, lng));
//     //  _markers.clear();
//     // _markers.add(Marker(
//     //     markerId: const MarkerId("0"),
//     //     position: LatLng(lat, lng),
//     //     infoWindow: InfoWindow(title: detail.result.name)));

//     // setState(() {});
//     googleMapController
//         .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
//   }
// }
