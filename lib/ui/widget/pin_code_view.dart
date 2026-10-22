// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:homex/ui/global.dart';
//
// import '../../res/app_colors.dart';
//
// class PinCodeView extends StatelessWidget {
//   final TextEditingController controller;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onCompleted;
//   final ValueChanged<String> onChanged;
//   final MainAxisAlignment mainAxisAlignment;
//   final int length;
//   final double fieldHeight;
//   final double fieldWidth;
//   final bool obscureText;
//   final bool autoFocus;
//   final bool readOnly;
//   const PinCodeView(
//       {required this.controller,
//       this.validator,
//       this.length = 6,
//       this.fieldHeight = 45,
//       this.fieldWidth = 45,
//       this.obscureText = false,
//       this.autoFocus = false,
//       this.readOnly = false,
//       this.onCompleted,
//       required this.onChanged,
//       this.mainAxisAlignment = MainAxisAlignment.start,
//       super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return PinCodeTextField(
//       controller: controller,
//       length: length,
//       obscureText: obscureText,
//       autoFocus: autoFocus,
//       keyboardType: TextInputType.number,
//       animationType: AnimationType.fade,
//       autoDismissKeyboard: true,
//       validator: validator,
//       enablePinAutofill: true,
//       readOnly: readOnly,
//       pinTheme: PinTheme(
//           borderWidth: 1,
//           activeBorderWidth: 1,
//           disabledBorderWidth: 1,
//           errorBorderWidth: 1,
//           inactiveBorderWidth: 1,
//           selectedBorderWidth: 1,
//           shape: PinCodeFieldShape.box,
//           borderRadius: BorderRadius.circular(10.0),
//           fieldHeight: fieldHeight,
//           fieldWidth: fieldWidth,
//           fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 5),
//           activeFillColor: AppColors.lightBackground,
//           selectedFillColor: AppColors.lightBackground,
//           inactiveFillColor: AppColors.lightBackground,
//           inactiveColor: Theme.of(context).dividerColor,
//           activeColor: Theme.of(context).colorScheme.secondary,
//           selectedColor: Theme.of(context).colorScheme.secondary),
//       enableActiveFill: true,
//       animationDuration: const Duration(milliseconds: 300),
//       onCompleted: onCompleted,
//       onChanged: onChanged,
//       mainAxisAlignment: mainAxisAlignment,
//       beforeTextPaste: (text) {
//         return true;
//       },
//       appContext: context,
//     );
//   }
// }
