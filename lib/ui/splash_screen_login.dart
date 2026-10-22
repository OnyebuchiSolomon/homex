// import 'dart:async';
// import 'package:craveconnect/extentions/size_responsive_extension.dart';
// import 'package:craveconnect/features/rider/bloc/view_models/rider_account_view_model.dart';
// import 'package:craveconnect/features/user/account/view_models/account_view_model.dart';
//  import 'package:craveconnect/flavour_config/flavor_config.dart';
// import 'package:flutter/material.dart';
//  import 'package:craveconnect/ui/global.dart';
//
// import '../configs/size_config.dart';
//
// class SplashScreenLogin extends StatefulWidget {
//   const SplashScreenLogin({super.key});
//   @override
//   State<SplashScreenLogin> createState() => _SplashScreenLoginState();
// }
//
// class _SplashScreenLoginState extends State<SplashScreenLogin> {
//   startTimeout() => Timer(const Duration(seconds: 5), handleTimeout);
//   final flavor = FlavorConfig.instance.flavor;
//   void handleTimeout() => changeScreen();
//
//   Future<void> changeScreen() async {
//
//     if (flavor == Flavor.vendor) {
//       final vendorVM = injector.get<VendorAccountViewModel>();
//        final timeout = Duration(seconds: 3);
//       final startTime = DateTime.now();
//
//       await Future.doWhile(() async {
//         await Future.delayed(const Duration(milliseconds: 100));
//         final elapsed = DateTime.now().difference(startTime);
//         // Exit if userData is loaded or timeout reached
//         return vendorVM.vendorUserData == null && elapsed < timeout;
//       });
//
//       final userData = vendorVM.vendorUserData;
//       if (userData!=null&&userData.isLoggedIn!) {
//         AppNavigator.pushNamedAndRemoveUntil(AppRoutes.vendorWrapperScreen,);
//       } else if (userData!=null){
//         AppNavigator.pushAndReplaceName(AppRoutes.signInScreen,);
//       }else{
//         AppNavigator.pushNamedAndRemoveUntil(AppRoutes.roleSelectionPage,);
//
//       }
//     } else if (flavor == Flavor.user) {
//       final vendorVM = injector.get<AccountViewModel>();
//
//       // Wait until userData is loaded or timeout after 3 seconds
//       final timeout = Duration(seconds: 3);
//       final startTime = DateTime.now();
//
//       await Future.doWhile(() async {
//         await Future.delayed(const Duration(milliseconds: 100));
//         final elapsed = DateTime.now().difference(startTime);
//         // Exit if userData is loaded or timeout reached
//         return vendorVM.userData == null && elapsed < timeout;
//       });
//
//       final userData = vendorVM.userData;
//
//       if (userData != null && userData.isLoggedIn == true) {
//         AppNavigator.pushNamedAndRemoveUntil(AppRoutes.userWrapperScreen,);
//       } else if (userData!=null){
//         AppNavigator.pushAndReplaceName(AppRoutes.signInScreen,);
//       }else{
//         AppNavigator.pushNamedAndRemoveUntil(AppRoutes.roleSelectionPage,);
//
//       }
//     } else if (flavor == Flavor.rider) {
//       final vendorVM = injector.get<RiderAccountViewModel>();
//       // Wait until userData is loaded or timeout after 3 seconds
//
//       final timeout = Duration(seconds: 3);
//       final startTime = DateTime.now();
//
//       await Future.doWhile(() async {
//         await Future.delayed(const Duration(milliseconds: 100));
//         final elapsed = DateTime.now().difference(startTime);
//         // Exit if userData is loaded or timeout reached
//         return vendorVM.riderData == null && elapsed < timeout;
//       });
//
//       final userData = vendorVM.riderData;
//
//       if (userData!=null&&userData.isLoggedIn!) {
//         AppNavigator.pushNamedAndRemoveUntil(AppRoutes.riderUserWrapperScreen,);
//       } else if (userData!=null){
//         AppNavigator.pushAndReplaceName(AppRoutes.signInScreen,);
//       }else{
//         AppNavigator.pushNamedAndRemoveUntil(AppRoutes.roleSelectionPage,);
//
//       }
//     } else if (flavor == Flavor.ques || flavor==Flavor.admin) {
//       AppNavigator.pushNamedAndRemoveUntil(AppRoutes.roleSelectionPage,);
//     }
//     // final userData = injector.get<AccountViewModel>().userData;
//     //
//     // if (userData?.cache == true) {
//
//     // } else {
//     //   AppNavigator.pushAndReplaceName(AppRoutes.welcomeScreen);
//     // }
//
//     //Show status bar
//
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     startTimeout();
//
//
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     SizeConfig().init(context);
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
