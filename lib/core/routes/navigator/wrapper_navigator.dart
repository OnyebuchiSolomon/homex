import 'package:flutter/material.dart';

class WrapperNavigator {
  static ValueNotifier<int> page = ValueNotifier<int>(0);
  static void navigateToPage(int page) => WrapperNavigator.page.value = page;
}