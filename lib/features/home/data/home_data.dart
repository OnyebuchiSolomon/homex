import 'package:flutter/material.dart';

import '../model/home_model.dart';

final List<HomeCategory> categories = const [
  HomeCategory(
    title: 'Buy House',
    icon: Icons.home_rounded,
  ),
  HomeCategory(
    title: 'Rent House',
    icon: Icons.key_rounded,
  ),
  HomeCategory(
    title: 'Buy Land',
    icon: Icons.landscape_rounded,
  ),
  HomeCategory(
    title: 'Commercial',
    icon: Icons.storefront_rounded,
  ),
];

final List<Property> properties = const [
  Property(
    price: '₦45,000,000',
    title: '4 Bed Semi-Detached Duplex',
    location: 'Lekki Phase 1, Lagos',
    rating: '4.8',
    verified: true,
    imageUrl:
    'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&w=1200&q=80',
  ),
  Property(
    price: '₦120,000,000',
    title: 'Luxury 5 Bed Detached Villa',
    location: 'Ikoyi, Lagos',
    rating: '4.9',
    verified: true,
    imageUrl:
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80',
  ),
  Property(
    price: '₦3,500,000/yr',
    title: '2 Bed Premium Apartment',
    location: 'Yaba, Lagos',
    rating: '4.5',
    verified: false,
    imageUrl:
    'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?auto=format&fit=crop&w=1200&q=80',
  ),
];
