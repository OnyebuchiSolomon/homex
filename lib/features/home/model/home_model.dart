
import 'package:flutter/cupertino.dart';

class HomeCategory {
  final String title;
  final IconData icon;

  const HomeCategory({
    required this.title,
    required this.icon,
  });
}

class Property {
  final String price;
  final String title;
  final String location;
  final String rating;
  final bool verified;
  final String imageUrl;

  const Property({
    required this.price,
    required this.title,
    required this.location,
    required this.rating,
    required this.verified,
    required this.imageUrl,
  });
}

class NavigationItem {
  final IconData icon;
  final String label;

  const NavigationItem({
    required this.icon,
    required this.label,
  });
}