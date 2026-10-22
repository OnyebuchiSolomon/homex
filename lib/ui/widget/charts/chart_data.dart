import 'package:flutter/material.dart';

class ChartData {
  ChartData({
    required this.caption,
    required this.value,
    this.color,
  });
  final String caption;
  final int value;
  final Color? color;

  Map<String, dynamic> toMap() => {
        'genre': caption,
        'sold': value,
      };
}
