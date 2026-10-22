// import 'package:flutter/material.dart';
// import 'package:graphic/graphic.dart';
// import '../../global.dart';
// import 'chart_data.dart';
//
// export 'chart_data.dart';
//
// class BarChartView extends StatelessWidget {
//   final List<ChartData> values;
//   final double width;
//   final double height;
//   const BarChartView({
//     super.key,
//     required this.values,
//     this.width = double.infinity,
//     this.height = 400,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: Chart(
//         padding: (size) => EdgeInsets.only(
//           left: size.width * .15,
//         ),
//         data: values.map((v) => v.toMap()).toList(),
//         variables: {
//           'genre': Variable(
//             accessor: (Map map) => map['genre'] as String,
//           ),
//           'sold': Variable(
//             accessor: (Map map) => map['sold'] as num,
//           ),
//         },
//         marks: [
//           IntervalMark(
//             label: LabelEncode(
//               encoder: (tuple) => Label(
//                 AppUtils.formatNumber(
//                   tuple['sold'].toDouble(),
//                 ),
//               ),
//             ),
//             color: ColorEncode(
//               value: AppColors.appBlue100,
//               updaters: {
//                 'tap': {
//                   true: (_) => AppColors.lightSecondaryColor,
//                 }
//               },
//             ),
//           ),
//         ],
//         coord: RectCoord(transposed: true),
//         axes: [
//           Defaults.verticalAxis
//             ..line = Defaults.strokeStyle
//             ..grid = null,
//           AxisGuide(
//             grid: Defaults.strokeStyle,
//             label: LabelStyle(
//               textStyle: Defaults.textStyle,
//               rotation: -50,
//               offset: const Offset(0, 7.5),
//             ),
//           ),
//         ],
//         selections: {'tap': PointSelection(dim: Dim.x)},
//       ),
//     );
//   }
// }
