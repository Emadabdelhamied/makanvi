import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(int rating);

class StarRating extends StatelessWidget {
  final int? starCount, rating;
  final double? size;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;

  const StarRating(
      {super.key,
      this.starCount = 5,
      this.rating = 0,
      this.onRatingChanged,
      this.color,
      this.size = 26});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating!) {
      icon = Icon(
        Icons.star_border,
        color: Theme.of(context).cardColor,
        size: size,
      );
    } else if (index > rating! - 1.0 && index < rating!) {
      icon = Icon(
        Icons.star_half,
        color: color ?? const Color(0xffF5CD4A),
        size: size,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color ?? const Color(0xffF5CD4A),
        size: size,
      );
    }
    return InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged!(index + 1),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                starCount!, (index) => buildStar(context, index))));
  }
}
