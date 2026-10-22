  import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../res/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    super.key,
    this.backGroundColor,
    this.titleColor,
    this.titleSize,
    this.automaticallyImplyLeading = true, this.bottom,
  });
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backGroundColor;
  final Color? titleColor;
  final double? titleSize;
  final bool automaticallyImplyLeading;
final PreferredSizeWidget? bottom;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor:
          backGroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      leading: leading ??
          (automaticallyImplyLeading ? IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),
          ) : null),
      centerTitle: centerTitle,
      title: title != null
          ? Text(
              title!,
              style: AppTextStyles.displayLarge,
            )
          : null,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
