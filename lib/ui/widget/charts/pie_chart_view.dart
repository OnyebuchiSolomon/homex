// import 'package:flutter/material.dart';
// import 'package:graphic/graphic.dart';
//
// import 'chart_data.dart';
//
// export 'chart_data.dart';
// export 'indicator.dart';
//
// class PieChartView extends StatelessWidget {
//   final List<ChartData> values;
//   final Widget? centerWidget;
//   final double width;
//   final double height;
//   const PieChartView({
//     super.key,
//     required this.values,
//     this.width = 180,
//     this.height = 180,
//     this.centerWidget,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           if (centerWidget != null) ...[
//             Center(child: centerWidget)
//           ],
//           SizedBox(
//             width: double.infinity,
//             height: double.infinity,
//             child: Chart(
//               data: values.map((v)=> v.toMap()).toList(),
//               variables: {
//                 'genre': Variable(
//                   accessor: (Map map) => map['genre'] as String,
//                 ),
//                 'sold': Variable(
//                   accessor: (Map map) => map['sold'] as num,
//                 ),
//               },
//               transforms: [
//                 Proportion(
//                   variable: 'sold',
//                   as: 'percent',
//                 )
//               ],
//               marks: [
//                 IntervalMark(
//                   position: Varset('percent') / Varset('genre'),
//                   color: ColorEncode(
//                       variable: 'genre', values: values.map((v)=> v.color!).toList()),
//                   modifiers: [StackModifier()],
//                 )
//               ],
//               coord: PolarCoord(
//                 transposed: true,
//                 dimCount: 1,
//                 dimFill: 1.05,
//                 startRadius: 1,
//                 endRadius: 0.92,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
