// import 'dart:async';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:makanvi_web/core/constant/colors/colors.dart';

// class MapScreen extends StatefulWidget {
//   final bool withPolyline;
//   double? fromLat;
//   double? fromLong;
//   double? toLat;
//   double? toLong;
//   MapScreen(
//       {super.key,
//       required this.withPolyline,
//       this.fromLat = 0,
//       this.fromLong = 0,
//       this.toLat = 0,
//       this.toLong = 0});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   final Completer<GoogleMapController> _controller = Completer();
//   // final double _originLatitude = widget.fromLat!, _originLongitude = 31.233334;
//   // final double _destLatitude = 30.033333, _destLongitude = 31.233334;
//   Map<MarkerId, Marker> markers = {};
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   String googleAPiKey = "AIzaSyB38_1XJa_Yy92TyTfUCpuRqSCc9hWTpBQ";
//   _getUserLocation() async {
//     LocationPermission permission;
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.deniedForever) {
//         return Future.error('Location Not Available');
//       }
//     } else if (permission == LocationPermission.whileInUse) {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       final GoogleMapController controller = await _controller.future;
//       controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//               target: LatLng(position.latitude, position.longitude), zoom: 16),
//         ),
//       );
//     } else {
//       throw Exception('Error');
//     }
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//     // controller.setMapStyle(tawasilMapStyle);
//   }

//   addMarks() async {
//     _addMarker(
//         LatLng(widget.fromLat!, widget.fromLong!),
//         "origin",
//         await BitmapDescriptor.fromAssetImage(
//             const ImageConfiguration(size: Size(0, 0)),
//             'assets/icons/source.png'),
//         "start");
//     _addMarker(
//       LatLng(widget.toLat!, widget.toLong!),
//       "destination",
//       await BitmapDescriptor.fromAssetImage(
//           const ImageConfiguration(size: Size(0, 0)),
//           'assets/icons/destination.png'),
//       "end",
//     );
//   }

//   BitmapDescriptor? myIcon;
//   @override
//   void initState() {
//     super.initState();
//     addMarks();
//     // BitmapDescriptor.fromAssetImage(
//     //         const ImageConfiguration(size: Size(48, 48)),
//     //         'assets/images/source_location.png')
//     //     .then((onValue) {
//     //   myIcon = onValue;
//     // });
//     if (!widget.withPolyline) {
//       _getUserLocation();
//     }
//     // if(myIcon!=null){
//     /// origin marker

//     /// destination marker

//     // }

//     _getPolyline();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//             target: LatLng(widget.fromLat!, widget.fromLong!), zoom: 12),
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,

//         tiltGesturesEnabled: true,
//         compassEnabled: true,
//         scrollGesturesEnabled: true,
//         zoomControlsEnabled: false,
//         //zoomGestures Enabled: true,

//         mapType: MapType.normal,
//         // indoorViewEnabled: true,
//         trafficEnabled: !widget.withPolyline,
//         onMapCreated: _onMapCreated,
//         markers: widget.withPolyline ? Set<Marker>.of(markers.values) : {},
//         polylines:
//             widget.withPolyline ? Set<Polyline>.of(polylines.values) : {},
//       )),
//     );
//   }

//   // void _onMapCreated(GoogleMapController controller) async {
//   //   mapController = controller;
//   // }

//   _addMarker(
//       LatLng position, String id, BitmapDescriptor descriptor, String title) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker = Marker(
//         markerId: markerId,
//         icon: descriptor,
//         position: position,
//         infoWindow: InfoWindow(title: tr(title)));
//     markers[markerId] = marker;
//   }

//   _addPolyLine() {
//     PolylineId id = const PolylineId("poly");

//     Polyline polyline = Polyline(
//         width: 5,
//         polylineId: id,
//         zIndex: -50,
//         color: primary,
//         geodesic: true,
//         jointType: JointType.mitered,
//         points: polylineCoordinates);
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   _getPolyline() async {
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(widget.fromLat!, widget.fromLong!),
//       PointLatLng(widget.toLat!, widget.toLong!),
//       travelMode: TravelMode.driving,
//       optimizeWaypoints: true,
//     );
//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     }
//     _addPolyLine();
//   }
// }
