import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';

class TextFieldRate extends StatelessWidget {
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
  final Color? lableColor;
  final FormState? state;
  final Function(String)? onChanged;
  const TextFieldRate({
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
    this.lableColor,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: validation,
        initialValue: "",
        builder: (state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("leave_us_message"),
                style:
                    TextStyles.textViewMedium12.copyWith(color: textColorLight),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
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
                maxLength: 300,

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
                  filled: false,
                  label: Text(labeltext!),

                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: vertical!, horizontal: horizontal!),
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  hintText: hintText,

                  // labelText: labeltext,
                  // fillColor: white,
                  labelStyle: TextStyles.textViewMedium15
                      .copyWith(color: lableColor ?? gray5),
                  hintStyle: TextStyles.textViewRegular12
                      .copyWith(color: hintColor ?? black1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                  errorStyle:
                      TextStyles.textViewBold12.copyWith(color: iconColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 0.3,
                    ),
                  ),
                  helperText: tr("maximum_100_words"),
                  fillColor: transparentColor,
                  focusedErrorBorder: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                  // enabledBorder: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                  errorBorder: InputBorder.none,
                ),
              ),
              if (state.hasError)
                Text(
                  state.errorText ?? "",
                  style: TextStyles.textViewRegular12.copyWith(color: red),
                )
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
