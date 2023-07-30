// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:galleryimage/gallery_item_model.dart';
// import 'package:makanvi_web/core/constant/colors/colors.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// // to view image in full screen
// class CustomGalleryImageViewWrapper extends StatefulWidget {
//   final LoadingBuilder? loadingBuilder;
//   final BoxDecoration? backgroundDecoration;
//   final int? initialIndex;
//   final PageController pageController;
//   final List<GalleryItemModel> galleryItems;
//   final Axis scrollDirection;
//   final String? titleGallery;

//   CustomGalleryImageViewWrapper({
//     Key? key,
//     this.loadingBuilder,
//     this.titleGallery,
//     this.backgroundDecoration,
//     this.initialIndex,
//     required this.galleryItems,
//     this.scrollDirection = Axis.horizontal,
//   })  : pageController = PageController(initialPage: initialIndex ?? 0),
//         super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _CustomGalleryImageViewWrapperState();
//   }
// }

// class _CustomGalleryImageViewWrapperState
//     extends State<CustomGalleryImageViewWrapper> {
//   final minScale = PhotoViewComputedScale.contained * 1;
//   final maxScale = PhotoViewComputedScale.covered * 3;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         backgroundColor: white,
//         title: Text(
//           widget.titleGallery ?? "Gallery",
//           style: TextStyle(
//             color: Color(0xFF252B5C),
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             fontFamily: "Almarai",
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Color(0xFF252B5C),
//             )),
//       ),
//       body: Column(
//         children: [
//           Container(
//             decoration: widget.backgroundDecoration,
//             constraints: BoxConstraints.expand(
//               height: MediaQuery.of(context).size.height * 0.8,
//             ),
//             child: PhotoViewGallery.builder(
//               scrollPhysics: const BouncingScrollPhysics(),
//               builder: _buildImage,
//               itemCount: widget.galleryItems.length,
//               loadingBuilder: widget.loadingBuilder,
//               backgroundDecoration: widget.backgroundDecoration,
//               pageController: widget.pageController,
//               scrollDirection: widget.scrollDirection,
//             ),
//           ),
//           SmoothPageIndicator(
//             controller: widget.pageController,
//             count: widget.galleryItems.length,
//             effect: ExpandingDotsEffect(
//                 activeDotColor: black,
//                 dotColor: gray5,
//                 dotHeight: 10,
//                 dotWidth: 10,
//                 spacing: 5,
//                 expansionFactor: 1.1),
//           ),
//         ],
//       ),
//     );
//   }

// // build image with zooming
//   PhotoViewGalleryPageOptions _buildImage(BuildContext context, int index) {
//     final GalleryItemModel item = widget.galleryItems[index];
//     return PhotoViewGalleryPageOptions.customChild(
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.6,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(25),
//             child: CachedNetworkImage(
//               imageUrl: item.imageUrl,
//               fit: BoxFit.contain,
//               placeholder: (context, url) =>
//                   const Center(child: CircularProgressIndicator()),
//               errorWidget: (context, url, error) => const Icon(Icons.error),
//             ),
//           ),
//         ),
//       ),
//       initialScale: PhotoViewComputedScale.contained,
//       minScale: minScale,
//       maxScale: maxScale,
//       heroAttributes: PhotoViewHeroAttributes(tag: item.id),
//     );
//   }
// }
