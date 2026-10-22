// import 'dart:async';
// import 'package:craveconnect/extentions/size_responsive_extension.dart';
// import 'package:craveconnect/flavour_config/flavor_config.dart';
// import 'package:craveconnect/handlers/app_handler.dart';
// import 'package:flutter/material.dart';
// import 'package:craveconnect/ui/global.dart';
// import 'package:flutter/services.dart';
//
// import '../configs/size_config.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   startTimeout() => Timer(const Duration(seconds: 5), handleTimeout);
//  // final flavor = FlavorConfig.instance.flavor;
//   void handleTimeout() => changeScreen();
//
//   Future<void> changeScreen() async {
//     AppNavigator.pushAndReplaceName(AppRoutes.onboardingScreen);
//     AppHandler.logPrint('naviage..............');
//     // final userData = injector.get<AccountViewModel>().userData;
//     //
//     // if (userData?.cache == true) {
//
//     // } else {
//     //   AppNavigator.pushAndReplaceName(AppRoutes.welcomeScreen);
//     // }
//
//     //Show status barOnboardingScreen
//
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     startTimeout();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     SizeConfig().init(context);
//     // SystemChrome.setPreferredOrientations([
//     //   DeviceOrientation.portraitUp,
//     //   DeviceOrientation.portraitDown,
//     // ]);
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent, // Set your desired color here
//         statusBarIconBrightness: Brightness.dark, // For Android (light icons on dark bar)
//         statusBarBrightness: Brightness.dark, // For iOS
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     // debugPrint(200.w.toString());
//     return Scaffold(
//       body: Container(
//         height: SizeConfig.screenHeight,
//         width: SizeConfig.screenWidth,
//         decoration: const BoxDecoration(color: AppColors.lightPrimary),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ImageView.svgs(AppImages.icLeftFlawer),
//                 ImageView.svgs(AppImages.icRightFlawer),
//               ],
//             ),
//             Column(
//               children: [
//                 ImageView.svgs(AppImages.icLogo, width: 228.w, height: 125.h),
//                 Text(
//                   'Connecting cravings with restaurants. ',
//                   style: AppTextStyles.poppine(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.lightTextColor,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ImageView.svgs(AppImages.icLeftFlawer),
//                 ImageView.svgs(AppImages.icRightFlawer),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
