import 'package:flutter/material.dart';
import '../constant/colors/colors.dart';
import '../constant/size_config.dart';
import '../constant/styles/styles.dart';

class MakanviMainButton extends StatelessWidget {
  final double height;
  final double? width;
  final bool isDisabled;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final String text;
  final String? tag;

  const MakanviMainButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.tag,
    this.isDisabled = false,
    this.height = 56.0,
    this.width,
    this.gradient = const LinearGradient(
        colors: buttonGradientColors,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag ?? UniqueKey().toString(),
      child: Container(
        width: width ?? width ?? SizeConfig.blockSizeHorizontal * 90,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDisabled ? greyBG : primary),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            text,
            style: TextStyles.textViewMedium15,
          ),
        ),
      ),
    );
  }
}

class RawyAlertButton extends StatelessWidget {
  final double height;
  final double? width;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final String text;
  final String? tag;

  const RawyAlertButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.tag,
    this.isDisabled = false,
    this.height = 56.0,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag ?? UniqueKey().toString(),
      child: Container(
        width: width ?? width ?? SizeConfig.blockSizeHorizontal * 90,
        height: height,
        decoration: BoxDecoration(
            border: Border.all(color: secondry),
            borderRadius: BorderRadius.circular(10),
            color: white),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: white,
            shadowColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            text,
            style: TextStyles.textViewMedium16.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
