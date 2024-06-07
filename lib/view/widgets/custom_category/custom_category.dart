import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class CustomCatagory extends StatelessWidget {
  const CustomCatagory(
      {super.key,
      required this.title,
      required this.image,
      this.paddingRight = 20});

  final String title;
  final String image;

  final double paddingRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight.w),
      child: Column(
        children: [
          ///=============================Image===========================

          Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: AppColors.whiteLightWhite1,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xffDBDBDB),
                      blurRadius: 4,
                      offset: Offset(0, 4))
                ],
                border: Border.all(color: AppColors.whiteNormalWhite4),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child:

                  CustomNetworkImage(
                      borderRadius: BorderRadius.circular(8.r),
                      imageUrl: image,
                      height: 50.w,
                      width: 50.w),

              //     CustomImage(
              //   size: 50.r,
              //   imageSrc: image,
              //   imageType: ImageType.png,
              // )
          ),

          ///=============================Text===========================

          CustomText(top: 4.h, text: title)
        ],
      ),
    );
  }
}
