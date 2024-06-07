import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class CustomCard extends StatelessWidget {
    CustomCard({super.key, required this.onDetails, required this.productImage, required this.productName, required this.productPrice,  this.selectButton, required this.onDelete, required this.weight});

    final VoidCallback onDetails;
    final VoidCallback onDelete;
    final String productImage;
    final String productName;
    final String productPrice;
    final String weight;
    final Widget? selectButton;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onDetails,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.whiteNormalWhite4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///====================== Product Image ======================

           /* CustomImage(
              size: 80.r,
              imageSrc: ,
              imageType: ImageType.png,
            ),*/
            CustomNetworkImage(imageUrl: productImage, height: 80.h, width: 80.w),

            SizedBox(
              width: 10.w,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///====================== Product Name ======================

                      CustomText(
                        text: productName,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.w,
                        bottom: 4.h,
                      ),
                        CustomText(text: weight),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      ///================== Product Price ==================

                      CustomText(
                        text:  productPrice,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.w,
                        right: 20.w,
                        color: AppColors.greenNormalhoverGreen5,
                      ),

                    ],
                  ),
                ],
              ),
            ),

            ///================== Delete Button ==================

            Column(
              children: [
                IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: AppColors.whiteNormalactiveWhite6,
                    )),

                ///================== select Button ===========================>
               /* Container(
                  padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 16.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.whiteNormalhoverWhite5,width: 1),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: selectButton,
                )*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
