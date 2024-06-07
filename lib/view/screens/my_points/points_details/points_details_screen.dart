import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class PointsDetailsScreen extends StatelessWidget {
  const PointsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteLightWhite1,
        centerTitle: true,
        title: const CustomText(
          text: 'Points Details',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.greenNormalGreen4,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24.h,horizontal: 20.w),
        child: Column(
          children: List.generate(8, (index) => Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            margin: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
                color: AppColors.whiteLightactiveWhite3,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.whiteNormalactiveWhite6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Order No: #${758766}',
                    ),
                    CustomText(
                      text: 'Date: ${'20-dec-2024'}',
                      bottom: 4.h,
                      top: 4.h,
                    ),
                  ],
                ),
                const Row(
                  children: [
                    CustomText(
                      text: 'Price:',
                      fontWeight: FontWeight.w500,
                      color: AppColors.blueNormalBleu4,
                      right: 4,
                    ),
                    CustomImage(imageSrc: AppIcons.point,imageType: ImageType.svg,size: 12,),
                    CustomText(
                      text: ' 50',
                      fontWeight: FontWeight.w500,
                      color: AppColors.blueNormalBleu4,
                    ),
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
