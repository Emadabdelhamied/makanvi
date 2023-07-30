import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../features/auth/data/models/countery_model.dart';
import '../../constant/colors/colors.dart';

class FlagCounteryWidget extends StatefulWidget {
  const FlagCounteryWidget(
      {super.key,
      this.flagsButtonPadding = EdgeInsets.zero,
      this.enabled = true,
      this.showDropdownIcon = true,
      this.onCountryChanged,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.countries,
      this.initialValue,
      this.pickerDialogStyle,
      this.validator,
      this.initialCountryCode});
  final EdgeInsetsGeometry flagsButtonPadding;
  final bool enabled;
  final bool showDropdownIcon;
  final ValueChanged<Country>? onCountryChanged;
  final List<CountryAuth>? countries;
  final AutovalidateMode? autovalidateMode;
  final String? initialValue;
  final PickerDialogStyle? pickerDialogStyle;
  final String? initialCountryCode;

  @override
  final FutureOr<String?> Function(PhoneNumber?)? validator;

  State<FlagCounteryWidget> createState() => _FlagCounteryWidgetState();
}

class _FlagCounteryWidgetState extends State<FlagCounteryWidget> {
  List<Country> _countryList = [];
  late Country _selectedCountry;
  late List<Country> filteredCountries;
  late String number;

  String? validatorMessage;
  @override
  void initState() {
    super.initState();
    if (widget.countries != null) {
      for (var country in widget.countries!) {
        _countryList.addAll(
            countries.where((element) => element.code == country.shortName));
      }
      // log(widget.countries!.length.toString());
      // log('-----------------------------------------');
      // log(_countryList.length.toString());
      // log('--------------------------------------------------');
      // log(countries.length.toString());
    } else {
      _countryList = countries;
    }
    // _countryList = widget.countries == null
    //     ? countries
    //     : [];
    filteredCountries = _countryList;
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && number.startsWith('+')) {
      number = number.substring(1);
      // parse initial value
      _selectedCountry = countries.firstWhere(
          (country) => number.startsWith(country.dialCode),
          orElse: () => _countryList.first);
      number = number.substring(_selectedCountry.dialCode.length);
    } else {
      _selectedCountry = countries.firstWhere(
          (item) => item.code == (widget.initialCountryCode ?? 'US'),
          orElse: () => _countryList.first);
    }

    if (widget.autovalidateMode == AutovalidateMode.always) {
      final initialPhoneNumber = PhoneNumber(
        countryISOCode: _selectedCountry.code,
        countryCode: '+${_selectedCountry.dialCode}',
        number: widget.initialValue ?? '',
      );

      final value = widget.validator?.call(initialPhoneNumber);

      if (value is String) {
        validatorMessage = value;
      } else {
        (value as Future).then((msg) {
          validatorMessage = msg;
        });
      }
    }
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => CountryPickerDialog(
          style: widget.pickerDialogStyle,
          filteredCountries: filteredCountries,
          searchText: "",
          countryList: _countryList,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            _selectedCountry = country;
            widget.onCountryChanged?.call(country);
            setState(() {});
          },
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(),
      child: InkWell(
        // borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
        onTap: widget.enabled ? _changeCountry : null,
        child: Padding(
          padding: widget.flagsButtonPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 4),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  // color: redColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage(
                      'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
                      package: 'intl_phone_field',
                    ),
                  ),
                ),
                // child: Image.asset(
                // 'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
                // package: 'intl_phone_field',
                // ),
              ),
              // const SizedBox(width: 8),

              // FittedBox(
              //   child: Text(
              //     '+${_selectedCountry.dialCode}',
              //     style: widget.dropdownTextStyle,
              //   ),
              // ),
              if (widget.enabled && widget.showDropdownIcon) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: gray5,
                )
              ],
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}
