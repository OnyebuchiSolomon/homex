import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homex/features/home/presentation/screens/explore_properties_screen.dart';
import 'package:homex/features/request_property/portfolio_deals_hub_screen.dart';
 import 'package:homex/features/request_property/request_screen.dart';
import 'package:homex/features/settings/settings_screen.dart';
import 'package:homex/features/wallet/wallet_screen.dart';
import 'package:homex/ui/global.dart';


import 'home/model/home_model.dart';
import 'home/presentation/screens/home_screen.dart';
import 'home/presentation/screens/profile_screen.dart';

class UserWrapperScreen extends StatefulWidget {
  const UserWrapperScreen({super.key});

  @override
  State<UserWrapperScreen> createState() => UserWrapperScreenState();
}

class UserWrapperScreenState extends State<UserWrapperScreen>
    with WidgetsBindingObserver {
  int _backPressCounter = 0;
  bool _canExit = false;
  DateTime? _lastBackPressed;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (WrapperNavigator.page.value != 0) {
        onItemTapped(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: WrapperNavigator.page,
      builder: (BuildContext context, int page, Widget? child) {
        return PopScope(
          canPop: _canExit,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            // If user is on any page other than Home,
            // pressing back takes them back to Home.
            if (page != 0) {
              onItemTapped(0);
              return;
            }

            final shouldExit = await _onWillPop();

            if (!mounted) return;

            if (shouldExit) {
              setState(() {
                _canExit = true;
              });

              exit(0);
            }
          },
          child: Scaffold(
            body: IndexedStack(index: page, children: _pages),

            // IMPORTANT:
            // Bottom navigation belongs ONLY to the wrapper.
            // HomeScreen/ProfileScreen/etc. must NOT have their own one.
            bottomNavigationBar: MediaQuery.sizeOf(context).width < 900
                ? _buildBottomNavigation(context, page)
                : null,
          ),
        );
      },
    );
  }

  // ============================================================
  // PAGE NAVIGATION
  // ============================================================

  void onItemTapped(int index) {
    WrapperNavigator.navigateToPage(index);
  }

  // ============================================================
  // PAGES
  // ============================================================

  late final List<Widget> _pages = [
    const HomeScreen(),
    const ExplorePropertiesScreen(),
    const PortfolioDealsHubScreen(),
    const WalletScreen(),
    const AccountSettingsScreen(),
  ];

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation(BuildContext context, int currentPage) {
    final colors = context.colors;

    const items = [
      NavigationItem(icon: Icons.home_rounded, label: 'Home'),
      NavigationItem(icon: Icons.search_rounded, label: 'Explore'),
      NavigationItem(icon: Icons.qr_code_2_rounded, label: 'Portfolio'),
      NavigationItem(
        icon: Icons.account_balance_wallet_rounded,
        label: 'Wallet',
      ),
      NavigationItem(icon: Icons.person_rounded, label: 'Profile'),
    ];

    final mediaQuery = MediaQuery.of(context);

    final width = mediaQuery.size.width;
    final bottomInset = mediaQuery.padding.bottom;

    final bool isSmallPhone = width < 360;

    return Material(
      color: colors.surfaceContainerLowest,
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.only(
          left: isSmallPhone ? 4 : 8,
          right: isSmallPhone ? 4 : 8,
          top: 6,
          bottom: bottomInset + 6,
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            final bool selected = currentPage == index;

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (currentPage == index) return;

                  onItemTapped(index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: EdgeInsets.symmetric(
                    horizontal: isSmallPhone ? 1 : 2,
                  ),
                  padding: EdgeInsets.symmetric(vertical: isSmallPhone ? 5 : 7),
                  decoration: BoxDecoration(
                    color: selected ? colors.primaryFixed : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[index].icon,
                        size: isSmallPhone ? 20 : 23,
                        color: selected
                            ? colors.primary
                            : colors.onSurfaceVariant,
                      ),

                      const SizedBox(height: 3),

                      Text(
                        items[index].label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: isSmallPhone ? 10 : 12,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: selected
                              ? colors.primary
                              : colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ============================================================
  // APP LIFECYCLE
  // ============================================================

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _onAppResumed();
        break;

      case AppLifecycleState.inactive:
        break;

      case AppLifecycleState.paused:
        break;

      case AppLifecycleState.detached:
        WidgetsBinding.instance.removeObserver(this);
        break;

      case AppLifecycleState.hidden:
        break;
    }
  }

  Future<void> _onAppResumed() async {
    if (!mounted) return;

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (!mounted) return;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  // void showLogOut() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return logOutAndLogIn();
  //     },
  //   );
  // }

  // Widget logOutAndLogIn() {
  //   return Container(
  //     height: MediaQuery.sizeOf(context).height / 3,
  //     width: MediaQuery.sizeOf(context).width,
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(24),
  //         topRight: Radius.circular(24),
  //       ),
  //       color: Colors.white,
  //     ),
  //     child: Column(
  //       children: [
  //         const SizedBox(height: 24),
  //
  //         Container(
  //           height: 5,
  //           width: 55,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             color: const Color(0XFFE7ECFF),
  //           ),
  //         ),
  //
  //         SizedBox(height: 20.h),
  //
  //         Text(
  //           'Log Out',
  //           style: AppTextStyles.poppine(
  //             fontSize: 16,
  //             color: const Color(0XFF15141F),
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //
  //         SizedBox(height: 30.h),
  //
  //         Text(
  //           'Are you sure want to log out?',
  //           style: AppTextStyles.poppine(
  //             fontSize: 12,
  //             color: const Color(0XFF15141F),
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //
  //         SizedBox(height: 30.h),
  //
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: ButtonView(
  //                   borderColor: AppColors.grey,
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   color: AppColors.grey,
  //                   child: Text(
  //                     'Cancel',
  //                     style: AppTextStyles.poppine(
  //                       color: AppColors.white,
  //                       fontWeight: FontWeight.w500,
  //                       fontSize: 14,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //
  //               SizedBox(width: 12.w),
  //
  //               Expanded(
  //                 child: ButtonView(
  //                   child: Text(
  //                     'Logout',
  //                     style: AppTextStyles.poppine(
  //                       color: AppColors.white,
  //                       fontWeight: FontWeight.w500,
  //                       fontSize: 14,
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     if (!mounted) return;
  //
  //                     if (flavor == Flavor.ques) {
  //                       AppNavigator.pushNamedAndRemoveUntil(
  //                         AppRoutes.roleSelectionPage,
  //                       );
  //                     } else {
  //                       injector.get<AccountCubit>().logout();
  //
  //                       Navigator.pushNamedAndRemoveUntil(
  //                         context,
  //                         AppRoutes.signInScreen,
  //                         (route) => false,
  //                       );
  //                     }
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // ============================================================
  // BACK BUTTON
  // ============================================================

  Future<bool> _onWillPop() async {
    final DateTime now = DateTime.now();

    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      _backPressCounter = 1;

      _showExitMessage();

      return false;
    }

    _backPressCounter++;

    if (_backPressCounter >= 2) {
      return true;
    }

    _showExitMessage();

    return false;
  }

  void _showExitMessage() {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text('Press again to exit.', textAlign: TextAlign.center),
            ),
          ),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class FavouriteScreen  extends StatelessWidget{
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}
class HomeCartScreen  extends StatelessWidget{
  const HomeCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}
