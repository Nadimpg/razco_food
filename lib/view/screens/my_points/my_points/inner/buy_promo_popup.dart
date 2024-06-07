import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/my_points/controller/points_controller.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class BuyPromoPopUp extends StatelessWidget {
    BuyPromoPopUp({super.key,this.discount,this.targetPoints,this.date,this.couponCode});
    var discount;
    var targetPoints;
    var date;
    var couponCode;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PointsController>(
      builder: (controller) {
        return AlertDialog(
          backgroundColor: Colors.white,
          buttonPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 12.w),
          title: Column(
            children: [
              ///<==================== offer ==========================>
              CustomText(text: 'buy this Coupon Offer ?',color: AppColors.blueNormalBleu4,fontWeight: FontWeight.w500,),

              ///<==================== discount ==========================>
              CustomText(text: '$discount% Discount',top: 4.h,bottom: 4.h,),

              ///<==================== date ==========================>
              CustomText(
                textAlign: TextAlign.center,
                maxLines: 2,
                text: 'Validity Date: ${date}',top: 4.h,bottom: 4.h,),

              ///<==================== price ==========================>
              CustomText(text: 'Target Points: ${targetPoints}',top: 4.h,bottom: 16.h,),

              ///<==================== button ==========================>
              GestureDetector(
                onTap: (){
                  controller.claim(couponCode: couponCode, couponDiscount: discount, expireDate: date, points: targetPoints);

                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: AppColors.greenNormalGreen4,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const CustomText(
                    text: 'Confirm',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
