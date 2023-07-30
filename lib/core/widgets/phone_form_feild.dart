import 'package:easy_localization/easy_localization.dart' as e;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../core/constant/styles/styles.dart';
import '../constant/colors/colors.dart';
import '../util/makanvi_phone.dart';
import '../util/validator.dart';

class PhoneFormFeild extends StatefulWidget {
  // final TextEditingController controller;
  final bool obSecure;
  final bool isClickable;
  final TextInputType keyboardType;
  final String? hintText;
  final Function(String)? onChanged;
  final Function? validateFunction;
  final Function(MakanviPhoneNumber) selectedPhoneCountryFunc;
  final MakanviPhoneNumber? initValue;
  const PhoneFormFeild({
    Key? key,
    //  this.controller,
    this.isClickable = true,
    this.obSecure = false,
    this.initValue,
    this.keyboardType = TextInputType.text,
    this.validateFunction,
    this.hintText,
    this.onChanged,
    required this.selectedPhoneCountryFunc,
  }) : super(key: key);

  @override
  State<PhoneFormFeild> createState() => _PhoneFormFeildState();
}

class _PhoneFormFeildState extends State<PhoneFormFeild> {
  bool secure = false;
  TextDirection? textDirection;
  String? fontFamily;
  @override
  void initState() {
    super.initState();
    if (widget.keyboardType == TextInputType.number) {
      fontFamily = "";
    }
    widget.selectedPhoneCountryFunc(
        MakanviPhoneNumber.fromPN(selectedPhoneModel));
    if (widget.initValue != null) {
      selectedPhoneModel = widget.initValue!;
    }
  }

  @override
  void didUpdateWidget(covariant PhoneFormFeild oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  PhoneNumber selectedPhoneModel = PhoneNumber(
    phoneNumber: "",
    isoCode: "SA",
    dialCode: "+966",
  );
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: InternationalPhoneNumberInput(
            textFieldController: controller,
            onInputChanged: (PhoneNumber number) {
              widget
                  .selectedPhoneCountryFunc(MakanviPhoneNumber.fromPN(number));
              if (selectedPhoneModel.isoCode != number.isoCode) {
                selectedPhoneModel = number;
                controller.clear();
                setState(() {});
              }
            },
            onInputValidated: (bool status) {},
            spaceBetweenSelectorAndTextField: 4,
            errorMessage: e.tr("error_wrong_input"),
            selectorConfig: const SelectorConfig(
                setSelectorButtonAsPrefixIcon: true,
                leadingPadding: 16,
                trailingSpace: false,
                selectorType: PhoneInputSelectorType.DIALOG),
            ignoreBlank: true,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: TextStyles.textViewMedium15,
            textStyle: TextStyles.textViewMedium15,
            formatInput: true,
            initialValue: selectedPhoneModel,
            hintText: selectedPhoneModel.isoCode == "SA" ? "5xxxxxxxx" : null,
            validator: selectedPhoneModel.isoCode == "SA"
                ? (val) => Validator.phone(val,
                    const PhoneModel(code: "+966", lenght: 9, startWith: "5"))
                : (val) => Validator.defaultEmptyValidator(val),
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            inputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: gray5,
                width: 1,
              ),
            ),
            onSaved: (PhoneNumber number) {
              // widget.selectedPhoneCountryFunc(number);
              // selectedPhoneModel = number;
              // setState(() {});
            },
          ),
        ),
        // Directionality(
        //   textDirection: TextDirection.ltr,
        //   child: TextFormField(
        //     textDirection: textDirection,
        //     validator: (value) => Validator.phone(value, selectedPhoneModel),
        //     onChanged: (value) {
        //       _checkForArabicLetter(value);
        //       if (widget.onChanged != null) widget.onChanged!(value);
        //     },
        //     // onChanged: widget.onChanged,
        //     style: TextStyles.bodyText14,
        //     decoration: InputDecoration(
        //       hintText: widget.hintText,
        //       contentPadding:
        //           const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        //       filled: false,
        //       focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //         borderSide: const BorderSide(
        //           color: gray5,
        //           width: 1,
        //         ),
        //       ),
        //       disabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //         borderSide: const BorderSide(
        //           color: gray5,
        //           width: 1,
        //         ),
        //       ),
        //       enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //         borderSide: const BorderSide(
        //           color: gray5,
        //           width: 1,
        //         ),
        //       ),
        //       border: OutlineInputBorder(
        //         borderSide: const BorderSide(
        //           color: gray5,
        //           width: 1.0,
        //         ),
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //     ),
        //     keyboardType: TextInputType.phone,
        //     controller: widget.controller,
        //   ),
        // ),
      ],
    );
  }
}

class PhoneModel extends Equatable {
  final String code;
  final String startWith;
  final int lenght;

  const PhoneModel(
      {required this.code, required this.lenght, required this.startWith});

  @override
  List<Object?> get props => [code, lenght];
}
