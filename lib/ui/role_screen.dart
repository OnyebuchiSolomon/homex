// import 'dart:convert';
//
// import 'package:craveconnect/configs/size_config.dart';
// import 'package:craveconnect/extentions/size_responsive_extension.dart';
// import 'package:craveconnect/ui/global.dart';
//  import 'package:flutter/material.dart';
// import '../flavour_config/flavor_config.dart';
//  import 'package:shared_preferences/shared_preferences.dart';
//
// class RoleSelectionPage extends StatefulWidget {
//     RoleSelectionPage({super.key});
//
//   @override
//   State<RoleSelectionPage> createState() => _RoleSelectionPageState();
// }
//
// class _RoleSelectionPageState extends State<RoleSelectionPage> {
//   Future<void> _selectRole(BuildContext context, Flavor flavor) async {
//
//     this.flavor= flavor;
//
//   }
//   late Flavor flavor;
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// appBar: CustomAppBar(title: 'Select role', automaticallyImplyLeading: false,),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//
//             children: [
//               SizedBox(height: SizeConfig.heightOf(5)),
//               ImageView.asset(AppImages.roleConnectIcon,height: 125,width: 125,fit: BoxFit.fill,),
//               SizedBox(height: 35.h),
//               Text(
//                 "Choose your  Role",
//                 style: AppTextStyles.poppine(
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textColor,
//                   fontSize: 24,
//
//                 ),
//                  textAlign: TextAlign.center,
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Text(
//                   "Use cards, bank transfers, or your wallet. Enjoy peace of mind with secured transactions.",
//                   style: AppTextStyles.poppine(
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.subTextColor,
//                     fontSize: 14,
//
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//                SizedBox(height: 20.h),
//               SizedBox(
//                 height: SizeConfig.heightOf(12),
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   physics: BouncingScrollPhysics(),
//                   children: [
//                       //             _buildButton(context, "Admin", Flavor.admin, 5, AppImages.roleConnectIcon),
//                     //
//                      _buildButton(context, "Guest", Flavor.ques, 1, AppImages.icQuestOption),
//                     _buildButton(context, "Customer", Flavor.user, 2, AppImages.icUserOption),
//                     _buildButton(context, "Restaurant", Flavor.vendor, 3, AppImages.icVendorOption),
//                     _buildButton(context, "Rider", Flavor.rider, 4, AppImages.icRiderOption),
//
//                   ],
//                 ),
//               ),
//               SizedBox(height: SizeConfig.heightOf(16)),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: ButtonView(
//                   borderRadius: 24,
//                   height: 48,
//                   borderColor: Colors.transparent,
//                   disabled: currentIndex ==0,
//                   onPressed: () async {
//                   if(currentIndex !=0){
//                     if(flavor==Flavor.ques){
//                       AppNavigator.pushNamedAndRemoveUntil(AppRoutes.userWrapperScreen);
//                       FlavorConfig.initialize(flavor);
//                     }else{
//                       final prefs = await SharedPreferences.getInstance();
//                       await prefs.setString('selected_role', flavor.name);
//                       FlavorConfig.initialize(flavor);
//                       AppNavigator.pushNamedAndRemoveUntil(AppRoutes.signInScreen);
//                     }
//
//
//                   }
//                 }, child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Next",
//                       style: AppTextStyles.poppine(
//                         fontWeight: FontWeight.w500,
//                         color:currentIndex ==0?AppColors.black: AppColors.white,
//                         fontSize: 22,
//
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(width: 4,),
//                     Icon(Icons.arrow_forward_outlined,color:currentIndex ==0?AppColors.black: AppColors.white,size: 25,)
//                   ],
//                 ),),
//               )
//                  ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _buildButton(BuildContext context, String text, Flavor flavor, int index, String url) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal:  8.0),
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectRole(context, flavor);
//             currentIndex=index;
//           });
//
//         },
//         child: Container(
//           width: 131,
// height: 90,
//          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 8),
//          decoration:  BoxDecoration(
//            borderRadius: BorderRadius.circular(16),
//            border: Border.all(color:currentIndex==index? AppColors.lightPrimary:AppColors.subTextColor,width: .5)
//          ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//         ImageView.asset(url,height: 44,width: 44,fit: BoxFit.fill,),
//
//           Text(
//             '$text',
//             style: AppTextStyles.poppine(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: AppColors.subTextColor,
//
//             ),
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//           ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
