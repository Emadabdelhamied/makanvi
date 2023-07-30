import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/colors/colors.dart';
import '../constant/icons.dart';
import '../constant/styles/styles.dart';

class PasswordField extends StatefulWidget {
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
  const PasswordField({
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
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _issecuire = true;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.validation,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                child: TextFormField(
                  focusNode: widget.focusNode,
                  // textInputAction: TextInputAction.done,
                  cursorColor: primary,
                  obscureText: _issecuire,
                  enabled: widget.isEnable,
                  autofocus: widget.autoFocus!,
                  onFieldSubmitted: widget.onSubmitted,
                  readOnly: widget.readOnly,
                  controller: widget.controller,
                  maxLines: widget.maxLines,
                  keyboardType: widget.keyboardType,
                  autocorrect: true,

                  ///validator: validation,
                  style: TextStyle(
                    color: widget.hintColor ?? black1,
                    fontSize: 16,
                  ),
                  onChanged: (s) {
                    widget.onChanged?.call(s);
                    state.didChange(s);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    filled: true,
                    // label: Text(widget.labeltext!),

                    // alignLabelWithHint: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: widget.vertical!,
                        horizontal: widget.horizontal!),
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          splashColor: primary.withOpacity(.2),
                          onTap: () => setState(() {
                            _issecuire = !_issecuire;
                          }),
                          child: _issecuire
                              ? SvgPicture.asset(
                                  visableIcon,
                                  color: black1,
                                  height: 20.h,
                                  width: 20.w,
                                )
                              : SvgPicture.asset(
                                  hideIcon,
                                  color: black1,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                        )),
                    //    IconButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       _issecuire = !_issecuire;

                    //     });
                    //   },
                    //   icon: Icon(
                    //     _issecuire == false
                    //         ? Icons.visibility
                    //         : Icons.visibility_off,
                    //     // color:
                    //     // _issecuire == true ? Color(0xFFE0E0E0) : AppColors.subColor,
                    //     size: 25,
                    //     color: const Color(0xffCCCCCC),
                    //   ),
                    // ),
                    //hintText: widget.hintText,

                    labelText: widget.labeltext,
                    // fillColor: white,
                    labelStyle: TextStyles.textViewMedium15
                        .copyWith(color: widget.lableColor ?? gray5),
                    hintStyle: TextStyles.textViewRegular12
                        .copyWith(color: widget.hintColor ?? black1),
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
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
