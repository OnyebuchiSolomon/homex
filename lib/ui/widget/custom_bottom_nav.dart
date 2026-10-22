// import 'package:craveconnect/configs/size_config.dart';
// import 'package:craveconnect/di/injection.dart';
// import 'package:craveconnect/extentions/size_responsive_extension.dart';
// import 'package:craveconnect/features/user/account/view_models/account_view_model.dart';
// import 'package:craveconnect/flavour_config/flavor_config.dart';
// import 'package:flutter/material.dart';
//
// import '../../core/theme/app_colors.dart';
// import '../../features/view_models/product_view_models/product_view_model.dart';
// import '../../res/app_colors.dart';
// import '../../res/app_text_styles.dart';
// import 'image_view.dart';
//
// class CustomBottomNavItem {
//   CustomBottomNavItem({
//     this.icon,
//     required this.label,
//     this.activeIcon,
//     this.child,
//   });
//   final String? icon;
//   final String? activeIcon;
//   final String label;
//   final Widget? child;
// }
//
// class CustomBottomNav extends StatefulWidget {
//   CustomBottomNav({
//     super.key,
//     required this.items,
//     required this.selectedColor,
//     required this.onTabSelected,
//     this.centerItemText,
//     this.height = 88.0,
//     this.iconSize = 24.0,
//     this.navItemCount = 5,
//     this.backgroundColor = AppColors.lightSurfaceContainerLow,
//     this.color = AppColors.onPrimaryFixed,
//     this.selectedIndex = 0,
//   }) {
//     assert(items.length == navItemCount);
//   }
//
//   final List<CustomBottomNavItem> items;
//   final String? centerItemText;
//   final double height;
//   final double iconSize;
//   final Color backgroundColor;
//   final Color color;
//   final Color selectedColor;
//   final ValueChanged<int> onTabSelected;
//   final int selectedIndex;
//   final int navItemCount;
//
//   @override
//   State<StatefulWidget> createState() => CustomBottomNavState();
// }
//
// class CustomBottomNavState extends State<CustomBottomNav> {
//   int _selectedIndex = 0;
//   final cart = injector.get<ProductViewModel>();
// final flavor = FlavorConfig.instance.flavor;
//   _updateIndex(int index) {
//     widget.onTabSelected(index);
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _selectedIndex = widget.selectedIndex;
//
//     return SafeArea(
//       child: ListenableBuilder(
//         listenable: cart,
//         builder: (BuildContext context, Widget? child) {
//           final c = cart.carts ?? [];
//           final f = cart.favourites ?? [];
//
//           return BottomAppBar(
//             color: Colors.transparent,
//             elevation: 5,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: List.generate(widget.items.length, (int index) {
//                 return Expanded(
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       _buildTabItem(
//                         item: widget.items[index],
//                         index: index,
//                         onPressed: _updateIndex,
//                       ),
//
//                       // CART BADGE → index 2
//                       if (index == 2 && c.isNotEmpty&&flavor==Flavor.user)
//                         Positioned(
//                           right: 20,
//                           top: 4,
//                           child: Container(
//                             height: 16,
//                             width: 16,
//                             decoration: const BoxDecoration(
//                               color: AppColors.lightPrimary,
//                               shape: BoxShape.circle,
//                             ),
//                             alignment: Alignment.center,
//                             child: Text(
//                               '${c.length}',
//                               style: AppTextStyles.poppine(
//                                 color: AppColors.white,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 8.5,
//                               ),
//                             ),
//                           ),
//                         ),
//
//                       // FAVOURITES BADGE → index 1
//                       if (index == 1 && f.isNotEmpty&&flavor==Flavor.user)
//                         Positioned(
//                           right: 20,
//                           top: 4,
//                           child: Container(
//                             height: 16,
//                             width: 16,
//                             decoration: const BoxDecoration(
//                               color: AppColors.lightPrimary,
//                               shape: BoxShape.circle,
//                             ),
//                             alignment: Alignment.center,
//                             child: Text(
//                               '${f.length}',
//                               style: AppTextStyles.poppine(
//                                 color: AppColors.white,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 8.5,
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 );
//               }),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildTabItem({
//     required CustomBottomNavItem item,
//     required int index,
//     required ValueChanged<int> onPressed,
//   }) {
//     bool isSelected = _selectedIndex == index;
//
//     return InkWell(
//       onTap: () => onPressed(index),
//       highlightColor: Colors.transparent,
//       splashColor: Colors.transparent,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           item.child ??
//               ImageView.svgs(
//                 isSelected ? item.activeIcon : item.icon,
//                 height: widget.iconSize,
//                 width: widget.iconSize,
//                 fit: BoxFit.contain,
//               ),
//           const SizedBox(height: 1),
//           Text(
//             item.label,
//             style: AppTextStyles.poppine(
//               color: isSelected ? widget.selectedColor : widget.color,
//               fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
//               fontSize: 10.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
