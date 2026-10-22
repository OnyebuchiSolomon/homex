// import 'package:flutter/material.dart';
//
// import '../../../res/app_text_styles.dart';
//
// class Indicator extends StatelessWidget {
//   final Color color;
//   final String caption;
//   final String value;
//   const Indicator(
//       {required this.color,
//       required this.caption,
//       required this.value,
//       super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 10,
//               height: 10,
//               decoration: BoxDecoration(
//                 color: color,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             const SizedBox(width: 6),
//             Text(
//               caption,
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 13,
//                 color: Theme.of(context).textTheme.bodySmall!.color,
//               ),
//             ),
//           ],
//         ),
//         Text(
//           value,
//           style: AppTextStyles.priceStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 18,
//           ),
//         ),
//       ],
//     );
//   }
// }
