// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageWidgegt extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  const CustomImageWidgegt(
      {super.key,
      required this.image,
      this.height = double.infinity,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Image.network(image);
    //  CachedNetworkImage(
    //   imageUrl: image,
    //   width: width,
    //   height: height,
    //   imageBuilder: (context, imageProvider) => Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: imageProvider,
    //         fit: BoxFit.fill,
    //       ),
    //     ),
    //   ),
    //   placeholder: (context, url) => PaginateLoading(),
    //   errorWidget: (context, url, error) => Icon(Icons.error),
    // );
  }
}
