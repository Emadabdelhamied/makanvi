import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';

class FieldLocation extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final void Function(String)? onSubmitted;
  final String? labeltext;
  final String? hintText;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isProfile;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? isFilled;
  final double? vertical;
  final double? horizontal;
  final bool? isSettings;
  final bool? isEnable;
  final Color? hintColor;
  final FormState? state;
  final Function(String)? onChanged;
  const FieldLocation({
    super.key,
    this.controller,
    this.state,
    this.validation,
    this.labeltext = '',
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType,
    this.isFilled = false,
    this.readOnly = false,
    this.isProfile = false,
    this.autoFocus = false,
    this.isEnable = true,
    this.maxLines = 1,
    this.vertical = 5,
    this.horizontal = 5,
    this.isSettings,
    this.hintColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 48.h,
      decoration: BoxDecoration(
          border: Border.all(color: gray5),
          borderRadius: BorderRadius.circular(10.r)),
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: TextFormField(
        focusNode: focusNode,
        // textInputAction: TextInputAction.done,
        cursorColor: primary,
        enabled: isEnable,
        autofocus: autoFocus!,
        onFieldSubmitted: onSubmitted,
        readOnly: readOnly,
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        autocorrect: true,
        validator: validation,
        style: const TextStyle(
          color: Color(0xff343434),
          fontSize: 16,
        ),
        decoration: InputDecoration(
          filled: false,
          // label: Text(labeltext!),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: vertical!, horizontal: horizontal!),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labeltext,
          fillColor: white,
          labelStyle: TextStyles.textViewMedium15.copyWith(color: gray5),
          hintStyle: TextStyles.textViewRegular12.copyWith(color: gray5),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

OutlineInputBorder border() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: black,
    ),
  );
}
