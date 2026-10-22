import 'package:flutter/material.dart';
import 'package:homex/ui/global.dart';

class _CategoryItem {
  final IconData icon;
  final String label;
  const _CategoryItem({required this.icon, required this.label});
}

class _FeaturedProperty {
  final String imageUrl;
  final String price;
  final double rating;
  final String title;
  final String location;
  final bool verified;

  const _FeaturedProperty({
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.title,
    required this.location,
    this.verified = true,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  final _searchController = TextEditingController();

  static const List<_CategoryItem> _categories = [
    _CategoryItem(icon: Icons.home, label: 'Buy House'),
    _CategoryItem(icon: Icons.key, label: 'Rent House'),
    _CategoryItem(icon: Icons.landscape, label: 'Buy Land'),
    _CategoryItem(icon: Icons.storefront, label: 'Commercial'),
  ];

  static const List<_FeaturedProperty> _properties = [
    _FeaturedProperty(
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDykifwjf-EYSGTUYm45eopUiWEZP4WbqiEpROlGFVxZkq5pFJFDNFTG8p8CNI6RTDEv1qBhulrkBIIKWHWlBTtDg6qwpWwX5j54zilosobaCVchKi42vCH6xVBfJiW3nYYHSUa4bh1jnJf2EcMFVJyBM5Lj07AqzdPCsN9vf4Zu_WuNmWZBkVpc47Hsr64gsPQVn7YuZRIX79meiXMz8PVEqI5Axh0ueaScVNkNck9zIiZrGQtgu-H',
      price: '₦45,000,000',
      rating: 4.8,
      title: '4 Bed Semi-Detached Duplex',
      location: 'Lekki Phase 1, Lagos',
    ),
    _FeaturedProperty(
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDUHyjAgAkSKspSHPv4ay5ypartGO_YksOgVVF20J1u2t6w7_xco9abAXpupfRMclaZwpqi5UniJO0KKN0WeKYLlF3u3uaYK4B5jnJX700vDFR4gZqSrdWx2T9wPPSg6SCwm7BAisc57RiOxnXL30tzWkgxxt-Xmmu-zoB4XGdD4_rukhkzzxmASUCTg_FtcsmmkJ9Ad8xE9VfNYXCGi1qdXP63AenUb-vZE7SKKV6fZpdTlpNBWxTF',
      price: '₦3,500,000/yr',
      rating: 4.5,
      title: '2 Bed Premium Apartment',
      location: 'Yaba, Lagos',
      verified: false,
    ),
    _FeaturedProperty(
      imageUrl:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuA5_-kyZk_9ktFv0lWDjZUQEhAYyKvihWHyXcEecYt-EcQre_2kXfWET5jYM8yrfQ38Em6TZbNqjIvqN4P4b_d4iKscT7-VdWUBRJnX5Kt-2bhf1MDSTJOQB-hzixbaaVOBM1h2MsSlrct1XsO0ImXiPg8Hwdc15JZqAnX8CG2aJEmE9eadOJEDctgIG99c0mIVi1ztMeD2y2x6WNinbv3C2pxsnT_8orgOZXaRdmKMgcocOmL3Adyq',
      price: '₦120,000,000',
      rating: 4.9,
      title: 'Luxury 5 Bed Detached Villa',
      location: 'Ikoyi, Lagos',
    ),
  ];

  double _hPad(BuildContext context) {
    final w = context.widthPx;
    if (w < 360) return 12;
    if (w < 400) return 16;
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final hPad = _hPad(context);

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildMobileHeader(context, hPad),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextEditView(
                      controller: _searchController,
                      prefixIcon: Icon(Icons.search, color: context.colors.onSurfaceVariant),
                      hintText: 'Search houses, land or locations...',
                    ),
                    const SizedBox(height: 16),
                    _buildCategoriesRow(context),
                    const SizedBox(height: 16),
                    FadeIn(child: _buildHeroBanner(context)),
                    const SizedBox(height: 24),
                    _buildFeaturedHeader(context),
                    const SizedBox(height: 12),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _properties.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ScrollReveal(child: _buildPropertyCard(context, _properties[index])),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  Widget _buildMobileHeader(BuildContext context, double hPad) {
    final textTheme = context.textTheme;
    final cs = context.colors;
    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: GestureDetector(
              onTap: () => AppNavigator.pushAndStackNamed(AppRoutes.accountRestrictedScreen),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: cs.outlineVariant)),
                child: ImageView.networkCached(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBgGr2xGwrV7-zE72Rpbm9cmBYWcyJ8togMJfUkiWhVgB6vg0qjJgWjJXfhM1UaAiSSTMQ8FeZb9EnNzvIepdOBMM57H7zp0X0gXNV7w3_b-SSexz2tlMfVf64BSA_xDKr03_czGod1j3_S8eCS7lqNqxJBtXM4NAn7mdCreMFQHkCY7WrmGE7T2NSPpyFyev1b8mcR_hsV2d9i71OqyHV35byXylNVKiCkGO_Ca4tv1VLhjRCfpfs6',
                  fit: BoxFit.cover,
                  errorWidget: Container(
                    color: cs.surfaceContainerHigh,
                    alignment: Alignment.center,
                    child: Icon(Icons.person, color: cs.onSurfaceVariant),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good morning,', style: textTheme.labelSmall),
                Text('Solomon', style: textTheme.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          ScaleOnTap(
            onTap: () => AppNavigator.pushAndStackNamed(AppRoutes.notificationsScreen),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cs.surfaceContainerLowest,
                shape: BoxShape.circle,
                border: Border.all(color: cs.outlineVariant),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.notifications,),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesRow(BuildContext context) {
    final textTheme = context.textTheme;
    final cs = context.colors;
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final selected = _selectedCategory == index;
          final cat = _categories[index];
          return ScaleOnTap(
            onTap: () => setState(() => _selectedCategory = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? (context.isDarkTheme?cs.surfaceContainerHighest:cs.primary) :(context.isDarkTheme?cs.primary:cs.surfaceContainerHighest),
                borderRadius: BorderRadius.circular(14),
                border: selected ? Border.all(color: cs.outlineVariant) : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(cat.icon, size: 18, color: selected ? cs.onPrimary : cs.onSurface),
                  const SizedBox(width: 8),
                  Text(
                    cat.label,
                    style: textTheme.labelMedium?.copyWith(color: selected ? cs.onPrimary : cs.onSurface),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    final textTheme = context.textTheme;
    final cs = context.colors;
    return Container(
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(color: cs.primaryFixed, borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -50,
            child: Opacity(
              opacity: 0.2,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(shape: BoxShape.circle, color: cs.primary),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: textTheme.headlineMedium?.copyWith(height: 1.2, color: cs.onPrimaryFixed),
                    children: [
                      const TextSpan(text: 'Find your next home\n'),
                      TextSpan(text: 'without agent fees.', style: TextStyle(color: cs.secondaryContainer)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ScaleOnTap(
                  onTap: () => AppNavigator.pushAndStackNamed(AppRoutes.explorePropertiesScreen),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(10)),
                    child: Text('Explore Properties', style: textTheme.labelMedium?.copyWith(color: cs.onPrimary)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedHeader(BuildContext context) {
    final textTheme = context.textTheme;
    final cs = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text('Featured Properties', style: textTheme.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
        const SizedBox(width: 8),
        ScaleOnTap(
          onTap: () {},
          child: Text('View all', style: textTheme.labelMedium?.copyWith( decoration: TextDecoration.underline)),
        ),
      ],
    );
  }

  Widget _buildPropertyCard(BuildContext context, _FeaturedProperty p) {
    final textTheme = context.textTheme;
    final cs = context.colors;
    return ScaleOnTap(
      onTap: () => AppNavigator.pushAndStackNamed(AppRoutes.propertyDetailsScreen),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outlineVariant),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: ImageView.networkCached(
                    p.imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: Container(
                      color: cs.surfaceContainer,
                      alignment: Alignment.center,
                      child: Icon(Icons.image_not_supported_outlined, color: cs.onSurfaceVariant),
                    ),
                  ),
                ),
                if (p.verified)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: cs.secondaryContainer.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(999)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified, size: 13, color: cs.onSecondaryContainer),
                          const SizedBox(width: 3),
                          Text('Verified', style: textTheme.labelSmall?.copyWith(fontSize: 11, color: cs.onSecondaryContainer, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(p.price, style: textTheme.headlineSmall),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, size: 14, color: cs.secondaryContainer),
                            const SizedBox(width: 3),
                            Text('${p.rating}', style: textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(p.title, style: textTheme.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: cs.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(p.location, style: textTheme.labelMedium?.copyWith(color: cs.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}