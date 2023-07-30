// library galleryimage;

// import 'package:flutter/material.dart';
// import 'package:galleryimage/gallery_item_model.dart';
// import 'package:galleryimage/gallery_item_thumbnail.dart';
// import 'package:galleryimage/util.dart';

// import 'custom_image_wrapper.dart';

// class GalleryImageVertical extends StatefulWidget {
//   final List<String> imageUrls;
//   final String? titleGallery;
//   final int numOfShowImages;
//   final Axis scrollDirection;
//   const GalleryImageVertical(
//       {Key? key,
//       required this.imageUrls,
//       this.titleGallery,
//       required this.scrollDirection,
//       this.numOfShowImages = 3})
//       : assert(numOfShowImages <= imageUrls.length),
//         super(key: key);
//   @override
//   State<GalleryImageVertical> createState() => _GalleryImageVerticalState();
// }

// class _GalleryImageVerticalState extends State<GalleryImageVertical> {
//   List<GalleryItemModel> galleryItems = <GalleryItemModel>[];
//   @override
//   void initState() {
//     buildItemsList(widget.imageUrls);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(10),
//         child: galleryItems.isEmpty
//             ? getEmptyWidget()
//             : GridView.builder(
//                 primary: false,
//                 itemCount: galleryItems.length > 3
//                     ? widget.numOfShowImages
//                     : galleryItems.length,
//                 padding: const EdgeInsets.all(0),
//                 scrollDirection: widget.scrollDirection,
//                 semanticChildCount: 1,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 5),
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ClipRRect(
//                       borderRadius: const BorderRadius.all(Radius.circular(8)),
//                       // if have less than 4 image w build GalleryItemThumbnail
//                       // if have mor than 4 build image number 3 with number for other images
//                       child: index < galleryItems.length - 1 &&
//                               index == widget.numOfShowImages - 1
//                           ? buildImageNumbers(index)
//                           : GalleryItemThumbnail(
//                               galleryItem: galleryItems[index],
//                               onTap: () {
//                                 openImageFullScreen(index);
//                               },
//                             ));
//                 }));
//   }

// // build image with number for other images
//   Widget buildImageNumbers(int index) {
//     return GestureDetector(
//       onTap: () {
//         openImageFullScreen(index);
//       },
//       child: Stack(
//         alignment: AlignmentDirectional.center,
//         fit: StackFit.expand,
//         children: <Widget>[
//           GalleryItemThumbnail(
//             galleryItem: galleryItems[index],
//           ),
//           Container(
//             color: Colors.black.withOpacity(.7),
//             child: Center(
//               child: Text(
//                 "+${galleryItems.length - index}",
//                 style: const TextStyle(color: Colors.white, fontSize: 40),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// // to open gallery image in full screen
//   void openImageFullScreen(final int indexOfImage) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CustomGalleryImageViewWrapper(
//           titleGallery: widget.titleGallery,
//           galleryItems: galleryItems,
//           backgroundDecoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//           initialIndex: indexOfImage,
//           scrollDirection: Axis.horizontal,
//         ),
//       ),
//     );
//   }

// // clear and build list
//   buildItemsList(List<String> items) {
//     galleryItems.clear();
//     for (var item in items) {
//       galleryItems.add(
//         GalleryItemModel(id: item, imageUrl: item),
//       );
//     }
//   }
// }
