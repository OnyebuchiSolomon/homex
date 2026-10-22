import 'package:homex/res/app_images.dart';

import '../models/onboarding_item.dart';

class OnboardingData {
  OnboardingData._();

  static   List<OnboardingItem> items = [
    OnboardingItem(
      image: AppImages.boarding1,

      title: 'Deal Directly With Owners',

      description:
      'Find houses and land without unnecessary agent charges. HomeX connects you directly with verified property owners.',

      badge: 'Verified Owner',

      badgeAction: 'Direct Match',
    ),

    OnboardingItem(
      image:AppImages.boarding2,

      title: 'Find Land You Can Trust',

      description:
      'Discover verified land and property listings with clear ownership information before you make a decision.',

      badge: 'Verified Property',

      badgeAction: 'Ownership Verified',
    ),

    OnboardingItem(
      image: AppImages.boarding3,

      title: 'Buy, Sell or Rent With Ease',

      description:
      'Whether you want to buy, sell or rent, HomeX brings property seekers and property owners together in one place.',

      badge: 'HomeX Property',

      badgeAction: 'Available',
    ),

    OnboardingItem(
      image:  AppImages.boarding4,

      title: 'Know Who You’re Dealing With',

      description:
      'Check the reputation of landlords, tenants and property owners through reviews and verified user information.',

      badge: 'Verified User',

      badgeAction: 'Excellent',
    ),

    OnboardingItem(
      image: AppImages.boarding5,

      title: 'Your Transaction. Your Protection.',

      description:
      'HomeX helps protect transactions while both parties complete the agreed property process.',

      badge: 'Secure Payment',

      badgeAction: 'Protected',
    ),
  ];
}