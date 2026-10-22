import 'package:flutter/material.dart';

import '../../../../core/animation/app_animations.dart';
import '../../../../core/extensions/custom_context_extension.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/routes/navigator/page_navigator.dart';
import '../../data/onboarding_data.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _isLastPage {
    return _currentPage == OnboardingData.items.length - 1;
  }

  void _nextPage() {
    if (_isLastPage) {
      _finishOnboarding();
      return;
    }

    _pageController.nextPage(
      duration: AppAnimations.pageTransition,
      curve: AppAnimations.standard,
    );
  }

  void _skip() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    AppNavigator.pushNamedAndRemoveUntil(
      AppRoutes.userWrapperScreen,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ============================================================
            // TOP NAVIGATION
            // ============================================================
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthOf(6),
                  vertical: context.heightOf(1),
                ),
                child: TextButton(
                  onPressed: _skip,
                  style: TextButton.styleFrom(
                    foregroundColor: colors.onSurfaceVariant,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Skip',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),

            // ============================================================
            // ONBOARDING CONTENT
            // ============================================================
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: OnboardingData.items.length,
                onPageChanged: _onPageChanged,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    item: OnboardingData.items[index],
                    pageIndex: index,
                    currentPage: _currentPage,
                  );
                },
              ),
            ),

            // ============================================================
            // BOTTOM CONTROLS
            // ============================================================
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.widthOf(6),
                8,
                context.widthOf(6),
                context.heightOf(2),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ========================================================
                  // PAGE INDICATOR
                  // ========================================================
                  Expanded(
                    child: OnboardingIndicator(
                      currentIndex: _currentPage,
                      itemCount: OnboardingData.items.length,
                    ),
                  ),

                  const SizedBox(width: 20),

                  // ========================================================
                  // ACTION BUTTON
                  // ========================================================
                  AnimatedSwitcher(
                    duration: AppAnimations.fast,
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                        ) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: ElevatedButton(
                      key: ValueKey<bool>(_isLastPage),
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: colors.primary,
                        // foregroundColor: colors.onPrimary,
                        side: BorderSide(color: colors.outlineVariant),
                        elevation: 0,
                        minimumSize: const Size(0, 52),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),

                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isLastPage ? 'Get Started' : 'Next',
                            style: textTheme.labelMedium?.copyWith(
                              color: colors.onPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: colors.onPrimary,
                          ),
                        ],
                      ),
                    ),
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