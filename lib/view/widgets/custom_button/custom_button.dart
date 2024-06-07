import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.height = 48,
      this.width = double.maxFinite,
      required this.onTap,
      this.title = AppStrings.getStared,
      this.marginVerticel = 0,
      this.marginHorizontal = 0, this.backgroundColor=AppColors.greenNormalGreen4 });

  final double height;
  final double width;

  final VoidCallback onTap;

  final String title;
  final Color backgroundColor;

  final double marginVerticel;
  final double marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: marginVerticel, horizontal: marginHorizontal),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: backgroundColor),
        child: CustomText(
            fontWeight: FontWeight.w500,
            color: AppColors.whiteLightWhite1,
            textAlign: TextAlign.center,
            text: title),
      ),
    );
  }
}
//