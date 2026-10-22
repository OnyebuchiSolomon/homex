 import 'package:flutter/material.dart';


 import 'package:homex/ui/global.dart';
class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key, required this.title, this.refreshTitle, this.onPress,  this.enableRefreshBtn=false});
final String title;
final String? refreshTitle;
final Function()? onPress;
final bool enableRefreshBtn;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(100),
                child:  ImageView.asset(
                  AppImages.emptyListImage,
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              title??'No comment yet',
              style: AppTextStyles.labelMedium,
            ),

           enableRefreshBtn? IconButton(onPressed: onPress, icon:   Text(
              '$refreshTitle',
              style: AppTextStyles.labelMedium,
            ),):SizedBox.shrink()
          ],
        ));
  }
}
