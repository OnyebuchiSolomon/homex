// import 'package:craveconnect/extentions/size_responsive_extension.dart';
// import 'package:flutter/material.dart';
//
// import '../../configs/size_config.dart';
// import '../../di/injection.dart';
// import '../../features/animation_widgets/dynamic_animation.dart';
// import '../../features/view_models/product_view_models/product_view_model.dart';
// import '../../res/app_colors.dart';
// import '../../res/app_routes.dart';
// import '../../res/app_text_styles.dart';
// import '../../utils/app_utils.dart';
// import '../../utils/navigator/page_navigator.dart';
// import 'button_view.dart';
// import 'custom_card.dart';
//
// class CustomPriceCard extends StatelessWidget {
//   CustomPriceCard({super.key});
//
//   final cartViewModel = injector.get<ProductViewModel>();
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 105.h,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: CustomCard(
//           borderRadius: 32,
//           padding: const EdgeInsets.all(12.0),
//           child: ListenableBuilder(
//             listenable: cartViewModel,
//             builder: (context, child) {
//
//               // Products already contain cartId, quantity & amount
//               final products = cartViewModel.carts;
//
//               double subtotal = 0;
//
//               for (var product in products) {
//                 final price = product.isOffer
//                     ? (product.offeredAmount ?? 0)
//                     : double.tryParse(product.productAmount ?? "0") ?? 0;
//
//                 subtotal += price * (product.quantity ?? 1);
//               }
//
//               return _cardPrice(subtotal, products.length);
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _cardPrice(double subtotal, int qty) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text(
//               'Items: ',
//               style: AppTextStyles.inter(
//                 color: AppColors.subTextColor,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             Text(
//               '$qty',
//               style: AppTextStyles.inter(
//                 color: AppColors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//
//
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'Sub-Total: ',
//                   style: AppTextStyles.inter(
//                     color: AppColors.subTextColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 Text(
//                   AppUtils.formatPrice(subtotal),
//                   style: AppTextStyles.priceStyle(
//                     color: AppColors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(
//               height: 28.h,
//               width: SizeConfig.screenWidth / 4,
//               child: AnimatedWrapper(
//                 child: ButtonView(
//                   padding: EdgeInsets.zero,
//                   onPressed: () {
//                     AppNavigator.pushAndStackNamed(AppRoutes.cartScreen);
//                   },
//                   child: Text(
//                     'Checkout >',
//                     style: AppTextStyles.inter(
//                       color: AppColors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
//
//
