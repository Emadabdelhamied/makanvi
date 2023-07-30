import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/custom_network.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/vertical_galllery.dart';

class ProjectImagesWidget extends StatelessWidget {
  final List<String> images;
  final String cover;
  final String title;
  const ProjectImagesWidget(
      {super.key,
      required this.images,
      required this.cover,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40.r),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 340.h,
            child: cover.isEmpty
                ? Image.asset(homeImage)
                : CustomImageWidgegt(
                    image: EndPoints.baseImages + cover,
                  ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: white,
            ),
          ),
        ),
        // images.isEmpty
        //     ? SizedBox()
        //     : Positioned(
        //         right: 0,
        //         child: Padding(
        //           padding: const EdgeInsets.all(15),
        //           child: SizedBox(
        //             height: 300.h,
        //             child: GalleryImageVertical(
        //                 titleGallery: title,
        //                 scrollDirection: Axis.horizontal,
        //                 numOfShowImages: images.length > 3 ? 3 : images.length,
        //                 imageUrls: images),
        //           ),
        //         ),
        //       ),
      ],
    );
  }
}
