import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

  import 'country_code_picker/country_code.dart';
import 'country_code_picker/country_code_view.dart';

class PhoneView extends StatelessWidget {
  final TextEditingController controller;
  final String? initialPhoneCode;
  final String? countryCode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<Country>? onCountryCodeChanged;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final String label;
  final String hintText;
  final bool readOnly;
  const PhoneView({
    required this.controller,
    this.onFieldSubmitted,
    this.textInputAction,
    this.validator,
    this.readOnly = false,
    this.hintText = 'Phone No',
    this.label = 'Phone number',
    super.key,
  })  : onCountryCodeChanged = null,
        countryCode = null,
        initialPhoneCode = null,
        onChanged = null;

  const PhoneView.withCountryCode({
    required this.controller,
    this.initialPhoneCode,
    this.countryCode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.hintText = 'Phone No',
    this.label = 'Phone number',
    required this.onCountryCodeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) => InputLabel(
        label: label,
        child: TextEditView(
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 8,
                ),
                CountryCodeView(
                    initialPhoneCode: initialPhoneCode,
                    onChanged: onCountryCodeChanged!),
                  SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    color: AppColors.lightDivider,
                  ),
                )
              ],
            ),
            onChanged: onChanged,
            controller: controller,
            keyboardType: TextInputType.phone,
            textInputAction: textInputAction,
            autofillHints: const [AutofillHints.telephoneNumber],
            validator: validator,
            hintText: hintText,
            readOnly: readOnly,
            onFieldSubmitted: onFieldSubmitted),
      );
}
