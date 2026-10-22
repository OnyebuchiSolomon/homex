// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
//
// import '../../res/app_colors.dart';
//
// class CustomDottedLine extends StatelessWidget {
//   const CustomDottedLine({
//     this.onTap,
//     this.height,
//     this.width,
//     this.margin,
//     this.padding = const EdgeInsets.symmetric(
//       vertical: 24,
//       horizontal: 16,
//     ),
//     this.borderRadius = 20,
//     this.child,
//     super.key,
//   });
//   final void Function()? onTap;
//   final double? width;
//   final double? height;
//   final EdgeInsets? margin;
//   final EdgeInsets padding;
//   final double borderRadius;
//   final Widget? child;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: DottedBorder(
//           borderType: BorderType.RRect,
//           dashPattern: const [7.9],
//           color: AppColors.lightPrimary,
//           radius: const Radius.circular(12),
//           padding: const EdgeInsets.all(6),
//           child: ClipRRect(
//             borderRadius:
//             const BorderRadius.all(Radius.circular(12)),
//             child: SizedBox(
//               height: height,
//               width: width,
//               child: Center(
//                 child:child
//               ),
//             ),
//           )),
//     );
//   }
// }
