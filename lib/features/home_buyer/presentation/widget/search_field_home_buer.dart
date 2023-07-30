import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';

class SearchFieldHomeBuyer extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final void Function(String)? onSubmitted;
  final String? labeltext;
  final String? hintText;
  final String? helperText;
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
  final Color? lableColor;
  final FormState? state;
  final Function(String)? onChanged;
  final Function()? onTap;
  final FloatingLabelBehavior? floatingLabelBehavior;
  const SearchFieldHomeBuyer(
      {super.key,
      this.controller,
      this.state,
      this.validation,
      this.labeltext,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.onSubmitted,
      this.focusNode,
      this.keyboardType,
      this.onTap,
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
      this.lableColor,
      this.floatingLabelBehavior = FloatingLabelBehavior.auto,
      this.helperText = ""});

  @override
  Widget build(BuildContext context) {
    log("search");
    return FormField<String>(
        validator: validation,
        initialValue: "",
        builder: (state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 48.h,
                decoration: BoxDecoration(
                    border: Border.all(color: state.hasError ? red : gray5),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  focusNode: focusNode,
                  // textInputAction: TextInputAction.done,
                  onTap: onTap,
                  cursorColor: primary,
                  enabled: isEnable,
                  autofocus: autoFocus!,
                  onFieldSubmitted: onSubmitted,
                  readOnly: readOnly,
                  controller: controller,
                  maxLines: maxLines,
                  keyboardType: keyboardType,
                  autocorrect: true,

                  ///validator: validation,
                  style: TextStyle(
                    color: hintColor ?? black1,
                    fontSize: 16,
                  ),
                  onChanged: (s) {
                    onChanged?.call(s);
                    state.didChange(s);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    filled: true,
                    // label: Text(labeltext!),

                    // alignLabelWithHint: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: vertical!, horizontal: horizontal!),
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    hintText: hintText,
                    // helperText: helperText,
                    labelText: labeltext,
                    // fillColor: white,
                    labelStyle: TextStyles.textViewMedium15
                        .copyWith(color: lableColor ?? gray5),
                    hintStyle: TextStyles.textViewRegular12
                        .copyWith(color: hintColor ?? gray5),
                    floatingLabelBehavior: floatingLabelBehavior,

                    prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                    suffixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                    errorStyle:
                        TextStyles.textViewBold12.copyWith(color: iconColor),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    //   borderSide: BorderSide(
                    //     color: Colors.red,
                    //     width: 0.3,
                    //   ),
                    // ),
                    fillColor: transparentColor,
                    focusedErrorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    // enabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    //   gapPadding: 0,
                    //   borderSide: BorderSide(
                    //       width: 2,
                    //       strokeAlign: StrokeAlign.inside,
                    //       style: BorderStyle.none),
                    // ),
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
              if (state.hasError)
                Text(
                  state.errorText ?? "",
                  style: TextStyles.textViewRegular12.copyWith(color: red),
                ),
              if (helperText!.isNotEmpty) Text(helperText!)
            ],
          );
        });
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
