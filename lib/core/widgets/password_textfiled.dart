import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makanvi_web/core/widgets/space_between_ele.dart';
import '../../../../core/constant/styles/styles.dart';
import '../constant/colors/colors.dart';
import '../util/validator.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword = true;
  final String text;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final String? Function(String?) validate;
  const PasswordTextField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.onSubmit,
    this.validate = Validator.defaultEmptyValidator,
    required this.text,
    // this.inputFormatters,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool secure = false;
  TextDirection? textDirection;
  String? fontFamily;
  @override
  void initState() {
    super.initState();
    secure = widget.isPassword ?? false;
    if (widget.keyboardType == TextInputType.number) {
      fontFamily = "";
    }
  }

  @override
  void didUpdateWidget(covariant PasswordTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  void _checkForArabicLetter(String text) {
    final arabicRegex = RegExp(r'[ء-ي-_ \.]*$');
    final englishRegex = RegExp(r'[a-zA-Z ]');
    final spi = RegExp("[\$&+,:;=?@#|'<>.^*()%!-]+");
    final numbers = RegExp("^[0-9]*\$");
    setState(() {
      text.contains(arabicRegex) &&
              !text.startsWith(englishRegex) &&
              !text.startsWith(spi) &&
              !text.startsWith(numbers)
          ? textDirection = TextDirection.rtl
          : textDirection = TextDirection.ltr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(widget.text, style: TextStyles.textViewMedium15),
        const SpaceV5BE(),
        Directionality(
            textDirection: TextDirection.ltr,
            child: TextFormField(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              //autocorrect: true,
              controller: widget.controller,
              onChanged: (value) {
                _checkForArabicLetter(value);
                if (widget.onChanged != null) widget.onChanged!(value);
              },
              keyboardType: widget.keyboardType,
              obscureText: secure,
              style: TextStyles.textViewMedium15
                  .copyWith(color: textColor, fontFamily: fontFamily),
              validator: widget.validate,

              onFieldSubmitted: widget.onSubmit,
              textDirection: textDirection,
              // inputFormatters: inputFormatters,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10.0),
                  filled: false,
                  errorMaxLines: 2,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: gray5,
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: gray5,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: gray5,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: gray5,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: red,
                        width: 1,
                        style: BorderStyle.solid,
                      )),
                  hintStyle:
                      TextStyles.textViewMedium15.copyWith(color: Colors.grey),
                  suffixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        splashColor: primary.withOpacity(.2),
                        onTap: () => setState(() {
                          secure = !secure;
                        }),
                        child: SvgPicture.asset(
                          'eyeIcon',
                          color: secure ? gray5 : primary,
                          height: 16,
                          width: 16,
                        ),
                      ))),
            )),
      ],
    );
  }
}
