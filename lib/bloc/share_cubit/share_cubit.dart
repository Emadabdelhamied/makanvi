// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:makanvi_web/features/seller_pages/listining_seller/presentation/pages/property_details.dart';

// import '../../core/social_share.dart';
// import '../../core/util/navigator.dart';
// import '../../injection_container.dart';

// part 'share_state.dart';

// class ShareCubit extends Cubit<ShareState> {
//   ShareCubit() : super(ShareInitial());
//   void getLinkData({required BuildContext context}) async {
//     var link = await FirebaseDynamicLinks.instance.getInitialLink();
//     handleLinkData(link, context);
//     FirebaseDynamicLinks.instance.onLink
//         .listen((PendingDynamicLinkData dynamicLink) async {
//       handleLinkData(dynamicLink, context);
//     }).onError((error) {
//       log(error.message);
//     });
//   }

//   void handleLinkData(PendingDynamicLinkData? data, BuildContext context) {
//     if (data != null) {
//       final Uri uri = data.link;
//       //final queryParams = uri.path;
//       if (uri.path.isNotEmpty) {
//         //String? userName = queryParams[0];
//         sl<AppNavigator>()
//             .push(screen: PropertyDetails(listingId: uri.path.split("/").last));
//       }
//     }
//   }

//   Future<Uri> getGroupDynamicLinks(BuildContext context, int id) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://makanvi_web.page.link',
//       link: Uri.parse('https://admin.makanvi_web.com/$id'),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.enterperform.makanvi_web',
//         minimumVersion: 0,
//       ),
//       iosParameters: IOSParameters(
//         bundleId: 'com.enterperform.makanvi_web',
//         minimumVersion: '1.2.5',
//         appStoreId: '1671423146',
//       ),
//     );
//     final ShortDynamicLink shortenedLink =
//         await FirebaseDynamicLinks.instance.buildShortLink(parameters);
//     final Uri dynamicUrl = shortenedLink.shortUrl;
//     SocialShare.checkInstalledAppsForShare();
//     SocialShare.shareOptions(dynamicUrl.toString());
//     return dynamicUrl;
//   }

//   shareProduct(BuildContext context, int link) {
//     getGroupDynamicLinks(context, link);

//     emit(ShareProductSuccess());
//   }

//   goToProduct({required BuildContext context}) {
//     getLinkData(context: context);
//     emit(GoProductSuccess());
//   }
// }
