// import 'dart:async';
// import 'package:another_flushbar/flushbar.dart';
//   import 'package:flutter/material.dart';
//
// import 'package:homex/ui/global.dart';
//
//
// class Modals {
//   static void showSnackBar(
//     String message, {
//      BuildContext? context,
//     MessageType? messageType,
//   }) {
//     final ctx = context ?? AppNavigator.currentContext;
//
//     ScaffoldMessenger.of(ctx)
//       ..removeCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(
//           duration:
//               messageType == MessageType.info
//                   ? const Duration(seconds: 30)
//                   : const Duration(seconds: 2),
//           content:
//               messageType == MessageType.info
//                   ? ProgressIndicators.circularProgressBar()
//                   : Text(message, textAlign: TextAlign.center),
//           backgroundColor:
//               messageType == MessageType.success
//                   ? Colors.green
//                   : messageType == MessageType.error
//                   ? Colors.red
//                   : null,
//         ),
//       );
//   }
//
//   static void showFlushBar(
//     String message, {
//     BuildContext? context,
//     MessageType? messageType,
//   }) {
//     final ctx = context ?? AppNavigator.currentContext;
//
//     final color =
//         messageType == MessageType.error
//             ? AppColors.error
//             : messageType == MessageType.info
//             ? AppColors.warning
//             : AppColors.success;
//     final icon =
//         messageType == MessageType.error
//             ? 'error image url'
//             : messageType == MessageType.info
//             ? 'info image url'
//             : 'sucess image url';
//     Flushbar(
//       flushbarPosition: FlushbarPosition.TOP,
//       flushbarStyle: FlushbarStyle.FLOATING,
//       reverseAnimationCurve: Curves.decelerate,
//       forwardAnimationCurve: Curves.elasticOut,
//       backgroundColor: color,
//       isDismissible: false,
//       duration: const Duration(seconds: 5),
//       margin: const EdgeInsets.symmetric(horizontal: 15.0),
//       borderRadius: BorderRadius.circular(10.0),
//       //borderWidth: 1,
//       //borderColor: color,
//       // icon: ImageView.svgs(
//       //   icon,
//       //   color: AppColors.lightCanvas,
//       //   height: 24,
//       //   width: 24,
//       // ),
//       showProgressIndicator: messageType == MessageType.info,
//       progressIndicatorBackgroundColor: AppColors.blueGrey,
//       messageText: Text(
//         message,
//         style: TextStyle(fontSize: 14.0, color: AppColors.white),
//       ),
//     ).show(ctx);
//   }
//
//   static Future<dynamic> showConfirmationDialog({
//     BuildContext? context,
//     required String title,
//     String? body,
//     Widget? bodyWidget,
//     required String? procceedLebel,
//     required VoidCallback proceedButtonTap,
//     bool barrierDismissible = false,
//     bool canPop = true,
//     bool isOrder = false,
//     Color? titleColor,
//     String? cancelLabel,
//     Widget? proceedBtnWidget,
//     VoidCallback? cancelButtonTap,
//   }) {
//     final ctx = context ?? AppNavigator.currentContext;
//     final theme = Theme.of(ctx);
//     return showDialog(
//       context: ctx,
//       barrierDismissible: barrierDismissible,
//       builder: (context) {
//         return PopScope(
//           canPop: canPop,
//           child: AlertDialog(
//             // backgroundColor:
//             // (state is ThemeDark) ? ColorDark.card : ColorLight.card,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.w),
//             ),
//             title: Text(
//               title,
//               style: theme.textTheme.bodyMedium!.copyWith(
//                 color: titleColor ?? AppColors.green,
//               ),
//             ),
//             content: SizedBox(
//               width: MediaQuery.of(context).size.width - 80,
//
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   isOrder?   ImageView.asset(AppImages.gifSuccess, width: 200.w, height: 200.h):SizedBox.shrink(),
//
//                   bodyWidget ?? SizedBox.shrink(),
//                   body != null
//                       ? Text(
//                         body,
//                         style: theme.textTheme.bodyMedium,
//                         textAlign: TextAlign.center,
//                       )
//                       : SizedBox.shrink(),
//                   const SizedBox(height: 25),
//                   SizedBox(
//                     height: 45,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: ButtonView(
//                             borderColor: theme.disabledColor,
//                             color: theme.disabledColor,
//                             onPressed:
//                                 cancelButtonTap ?? () => AppNavigator.pop(),
//                             child: Text(
//                               cancelLabel ?? 'Cancel',
//                               style: AppTextStyles.poppine(
//                                 color: AppColors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         proceedBtnWidget ??
//                             Expanded(
//                               child: ButtonView(
//                                 onPressed: proceedButtonTap,
//                                 color: theme.primaryColor,
//                                 child: Text(
//                                   procceedLebel ?? 'Proceed',
//                                   style: AppTextStyles.poppine(
//                                     color: AppColors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 // labelColor: Colors.white,
//                               ),
//                             ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   static void showHandOverDialog({
//     BuildContext? context,
//     required OrderModel order,
//     required VoidCallback onPress,
//   }) {
//     final ctx = context ?? AppNavigator.currentContext;
//
//     final theme = Theme.of(ctx);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showDialog(
//         context: ctx,
//         builder: (_) {
//           return AlertDialog(
//             title: Text(
//               "Handing over",
//               style: AppTextStyles.poppine(
//                 color: AppColors.lightPrimary,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             content: Text(
//               "Accept this order",
//               style: AppTextStyles.poppine(
//                 color: AppColors.appGrey,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: ButtonView(
//                   onPressed: onPress,
//                   color: theme.primaryColor,
//                   child: Text(
//                     'Accept Oder',
//                     style: AppTextStyles.poppine(
//                       color: AppColors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   // labelColor: Colors.white,
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     });
//   }
//
//   static Future<dynamic> showLoadingDialog({
//     BuildContext? context,
//     String? title,
//     bool barrierDismissible = false,
//   }) {
//     final ctx = context ?? AppNavigator.currentContext;
//
//      return showDialog(
//       context: ctx,
//       barrierDismissible: barrierDismissible,
//       barrierColor: Colors.transparent,
//       builder: (context) {
//         return PopScope(
//           canPop: false,
//           child: AlertDialog(
//             backgroundColor: Colors.transparent,
//             // backgroundColor:
//             // (state is ThemeDark) ? ColorDark.card : ColorLight.card,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.w),
//             ),
//             content: SizedBox(
//               width: MediaQuery.of(context).size.width - 80,
//               height: 150,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.lightPrimary),
//
//                       child: ProgressIndicators.spinningLinesProgressBar(context)),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   static Future<dynamic> showNetworkError({
//     BuildContext? context,
//     String? title,
//     String? err,
//     Function()? onPressed,
//     MessageType? messageType,
//     bool barrierDismissible = false,
//   }) {
//     final ctx = context ?? AppNavigator.currentContext;
//     final errMsg =
//         err == 'unavailable' || err == 'network-request_property-failed'
//             ? ErrorMessage.network
//             : err == 'wrong-password' || err == 'invalid-credential'
//             ? ErrorMessage.password
//             : err == 'insufficient'
//             ? ErrorMessage.insufficient
//             : ErrorMessage.other;
//     final theme = Theme.of(ctx);
//     return showDialog(
//       context: ctx,
//       barrierDismissible: barrierDismissible,
//       // barrierColor: Colors.transparent,
//       builder: (context) {
//         return PopScope(
//           child: AlertDialog(
//             // backgroundColor: Colors.transparent,
//             // backgroundColor:
//             // (state is ThemeDark) ? ColorDark.card : ColorLight.card,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.w),
//             ),
//             content: SizedBox(
//               width: MediaQuery.of(context).size.width - 80,
//
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if(messageType==MessageType.success)...[
//                     ImageView.asset(AppImages.imgSuccess,height: 100,width: 100,)
//                   ]else ...[
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundColor: AppColors.lightPrimary.withValues(
//                         alpha: .3,
//                       ),
//                       child:
//                       errMsg == ErrorMessage.network
//                           ? Icon(
//                         Icons.wifi_off,
//                         size: 35,
//                         color: AppColors.lightPrimary.withValues(
//                           alpha: .6,
//                         ),
//                       )
//                           : errMsg == ErrorMessage.insufficient
//                           ? Icon(
//                         Icons.earbuds_rounded,
//                         size: 35,
//                         color: AppColors.lightPrimary.withValues(
//                           alpha: .6,
//                         ),
//                       )
//                           : errMsg == ErrorMessage.password
//                           ? Icon(
//                         Icons.key_off,
//                         size: 35,
//                         color: AppColors.lightPrimary.withValues(
//                           alpha: .6,
//                         ),
//                       )
//                           : Icon(
//                         Icons.error,
//                         size: 35,
//                         color: AppColors.lightPrimary.withValues(
//                           alpha: .6,
//                         ),
//                       ),
//                     ),
//                   ],
//
//                   SizedBox(height: 8.h),
//                   Text(
//                     title ?? 'Loading...',
//                     style: theme.textTheme.titleSmall,
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 25.h),
//                   // ProgressIndicators.circularProgressBar(),
//                   if(err=='DUPLICATE-VENDOR')...[
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ButtonView(
//
//                         onPressed: () {
//                           AppNavigator.pop();
//                         },
//                         child: Text(
//                           'Cancel',
//                           style: theme.textTheme.titleMedium?.copyWith(color: AppColors.white),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ButtonView(
//                         color: AppColors.disableGreyColor,
//                         borderColor: AppColors.disableGreyColor,
//                         onPressed:onPressed?? () {
//                           AppNavigator.pop();
//                         },
//                         child: Text(
//                           'Clear cart',
//                           style: theme.textTheme.titleMedium?.copyWith(color: AppColors.white),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   ]else...
//                   [  Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ButtonView(
//                       height: 40,
//                       onPressed:onPressed?? () {
//                         AppNavigator.pop();
//                       },
//                       child: Text(
//                         'Okay',
//                         style: theme.textTheme.titleMedium?.copyWith(color: AppColors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),]
//
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   static Future<dynamic> confirmDialogue({
//     BuildContext? context,
//     required String title,
//     required Function() onPressed,
//     bool barrierDismissible = false,
//   }) {
//     final ctx = context ?? AppNavigator.currentContext;
//
//     final theme = Theme.of(ctx);
//     return showDialog(
//       context: ctx,
//       barrierDismissible: true,
//       // barrierColor: Colors.transparent,
//       builder: (context) {
//         return PopScope(
//           child: AlertDialog(
//             // backgroundColor: Colors.transparent,
//             // backgroundColor:
//             // (state is ThemeDark) ? ColorDark.card : ColorLight.card,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.w),
//             ),
//             content: SizedBox(
//               width: MediaQuery.of(context).size.width - 80,
//
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 25,
//                     backgroundColor: AppColors.lightPrimary.withValues(
//                       alpha: .3,
//                     ),
//                     child: Icon(
//                       Icons.error,
//                       size: 25,
//                       color: AppColors.lightPrimary.withValues(alpha: .6),
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     title,
//                     style: theme.textTheme.titleSmall,
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 25.h),
//                   // ProgressIndicators.circularProgressBar(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: ButtonView(
//                             height: 40,
//                             borderColor: AppColors.disableGreyColor,
//                             color: AppColors.disableGreyColor,
//                             onPressed: () {
//                               AppNavigator.pop();
//                             },
//                             child: Text(
//                               'Cancel',
//                               style: theme.textTheme.titleSmall,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 25.h),
//                         Expanded(
//                           child: ButtonView(
//                             height: 40,
//                             onPressed: onPressed,
//                             child: Text(
//                               'Yes, Proceed',
//                               style: theme.textTheme.titleSmall!.copyWith(color: AppColors.white),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   static Future<dynamic> showUpdate({
//     BuildContext? context,
//     bool canPop = true,
//     required UpdateVersion update
//   }) {
//     final ctx = context ?? AppNavigator.currentContext;
//
//     final theme = Theme.of(ctx);
//     return showDialog(
//       context: ctx,
//       barrierDismissible: canPop,
//       builder: (context) {
//         return PopScope(
//           canPop: !canPop,
//           child: AlertDialog(
//
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.w),
//
//             ),
//             title: Text(
//               'Latest version: ${update.latestVersion}',
//               style: theme.textTheme.titleMedium!.copyWith(color: AppColors.green,fontSize: 18),
//               textAlign: TextAlign.center,
//             ),
//             icon:  ImageView.asset(AppImages.updateImage, height: 150,width: 150,),
//             content: SizedBox(
//               width: MediaQuery.of(context).size.width - 80,
//
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                  children: [
//
//                   Text(
//                     '${update.updateMessage}',
//                     style: theme.textTheme.titleSmall,
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 25.h),
//                   // ProgressIndicators.circularProgressBar(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         update.forceUpdate!=true?  Expanded(
//                           child: ButtonView(
//                             height: 40,
//                             borderColor: AppColors.disableGreyColor,
//                             color: AppColors.disableGreyColor,
//                             onPressed: () {
//                               AppNavigator.pop();
//                             },
//                             child: Text(
//                               'Later',
//                               style: theme.textTheme.titleSmall,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ):SizedBox.shrink(),
//                         SizedBox(width: 25.h),
//                         Expanded(
//                           child: ButtonView(
//                             height: 40,
//                             onPressed: (){
//
//                               AppUtils.openStore(androidUrl: update.storeUrl!, iosUrl: update.iosStoreUrl!);
//                             },
//                             child: Text(
//                               'Yes, Proceed',
//                               style: theme.textTheme.titleSmall!.copyWith(color: AppColors.white),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//
//   static Future<dynamic> showBottomSheetModal({
//     BuildContext? context,
//     Widget? page,
//     double? heightFactor = 0.5,
//     bool showExitButton = true,
//     bool canPop = true,
//     bool isScrollControlled = false,
//     double borderRadius = 16.0,
//     bool isDismissible = true,
//     bool isExpanded = false,
//     String? title,
//     String? messageBody,
//     Function()? onPressed,
//     bool isW = false,
//   }) async {
//     final ctx = context ?? AppNavigator.currentContext;
//
//     final data = await showModalBottomSheet<dynamic>(
//       context: ctx,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
//       ),
//       backgroundColor: Theme.of(ctx).colorScheme.surface,
//       isScrollControlled: isScrollControlled,
//       isDismissible: isDismissible,
//       builder: (BuildContext bc) {
//         return PopScope(
//           canPop: canPop,
//           child: Padding(
//             padding: MediaQuery.of(ctx).viewInsets,
//             child: FractionallySizedBox(
//               heightFactor: heightFactor,
//               child: Column(
//                 mainAxisSize:
//                     isScrollControlled ? MainAxisSize.max : MainAxisSize.min,
//                 children: [
//                   if (showExitButton) ...[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         if (title != null) ...[
//                           const SizedBox(width: 42),
//                           Expanded(
//                             child: Text(
//                               title,
//                               maxLines: 1,
//                               textAlign: TextAlign.center,
//                               style: AppTextStyles.dmSans(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                         ],
//                         IconButton(
//                           onPressed: onPressed ?? () => Navigator.pop(ctx),
//                           icon: ImageView.svgs(AppImages.icCloseCircle),
//                         ),
//                       ],
//                     ),
//                   ],
//                   if (isExpanded) ...[
//                     Expanded(
//                       child: page ?? _successWidget(messageBody ?? '', isW),
//                     ),
//                   ] else ...[
//                     page ?? _successWidget(messageBody ?? '', isW),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//     return data;
//   }
//
//   static Future<dynamic> showDialogModal({
//     BuildContext? context,
//     required Widget page,
//     double borderRadius = 10.0,
//     bool barrierDismissible = true,
//     Color backgroundColor = AppColors.white,
//     Color? barrierColor,
//     bool enablePopWidget = true,
//     EdgeInsets insetPadding = const EdgeInsets.all(24.0),
//     Alignment? alignment,
//   }) async {
//     final ctx = context ?? AppNavigator.currentContext;
//
//     final data = await showDialog<dynamic>(
//       context: ctx,
//       barrierDismissible: barrierDismissible,
//       barrierColor: barrierColor,
//       builder: (_) {
//         return Dialog(
//           alignment: alignment,
//           insetPadding: insetPadding,
//           backgroundColor: backgroundColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ), //this right here
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               enablePopWidget
//                   ? Align(
//                     alignment: Alignment.topRight,
//                     child: IconButton(
//                       onPressed: () => Navigator.pop(ctx),
//                       icon: ImageView.svgs(AppImages.icCloseCircle),
//                     ),
//                   )
//                   : SizedBox.shrink(),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 24.0,
//                   right: 24.0,
//                   bottom: 24.0,
//                 ),
//                 child: page,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//     return data;
//   }
//
//   static _successWidget(String msg, bool isW) {
//     return Column(
//       children: [
//         if (isW) ...[
//           SizedBox(height: SizeConfig.heightOf(8.h),),
//           CircleAvatar(
//             radius: 40,
//             backgroundColor: AppColors.orange.withValues(alpha: .2),
//             child: Icon(
//               Icons.pending,
//               size: 50,
//               color: AppColors.orange.withValues(alpha: .8),
//             ),
//           ),
//           SizedBox(height: 20.h,),
//           Text(msg),
//           SizedBox(height: SizeConfig.heightOf(8.h),),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 50.0),
//             child: ButtonView(onPressed: (){
//               AppNavigator.popUntil((route) => route.settings.name == AppRoutes.vendorWrapperScreen);
//             }, child: Text('OK', style: AppTextStyles.poppine(
//               color: AppColors.white,
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),)),
//           )
//         ] else ...[
//           ImageView.asset(AppImages.gifSuccess, width: 200.w, height: 200.h),
//           Text(msg),
//         ],
//       ],
//     );
//   }
// }
