// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../injection_container.dart';
// import '../constant/colors/colors.dart';
// import '../constant/styles/map_style.dart';
// import '../widgets/appbar_generic.dart';
// import 'navigator.dart';

// class ScreenForShowOnMap extends StatelessWidget {
//   final double latitude;
//   final double longitude;
//   final Uint8List markerIcon;
//   final List<String> images;
//   ScreenForShowOnMap(
//       {super.key,
//       required this.latitude,
//       required this.longitude,
//       required this.images,
//       required this.markerIcon});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarGeneric(
//         title: tr("property_perview"),
//         titleColor: textColor,
//         onPressed: () {
//           sl<AppNavigator>().pop();
//         },
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             myLocationButtonEnabled: false,
//             initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                   latitude,
//                   longitude,
//                 ),
//                 zoom: 15),
//             markers: {
//               Marker(
//                 markerId: MarkerId("".toString()),
//                 position: LatLng(
//                   latitude,
//                   longitude,
//                 ),
//                 infoWindow: InfoWindow(title: "", snippet: "_detail"),
//                 icon: BitmapDescriptor.fromBytes(markerIcon),
//                 // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.mainColor),
//               )
//             },
//             zoomControlsEnabled: false,
//             onMapCreated: (GoogleMapController controller) {
//               controller.setMapStyle(mapStyle);
//             },
//           ),
//           // Align(
//           //   alignment: Alignment.bottomCenter,
//           //   child: SizedBox(
//           //     height: 200.h,
//           //     child: ListView.builder(
//           //       physics: BouncingScrollPhysics(),
//           //       scrollDirection: Axis.horizontal,
//           //       itemCount: images.length,
//           //       itemBuilder: (context, index) => Padding(
//           //           padding:
//           //               EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
//           //           child: ClipRRect(
//           //             borderRadius: BorderRadius.circular(25.r),
//           //             child: Image.network(
//           //               images[index],
//           //               fit: BoxFit.fill,
//           //               width: 200.w,
//           //             ),
//           //           )),
//           //     ),
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
// }
