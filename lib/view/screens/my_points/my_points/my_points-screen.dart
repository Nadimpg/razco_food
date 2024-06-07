import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/utils/snackbar_toastmsg.dart';
import 'package:razco_foods/view/screens/my_points/controller/points_controller.dart';
import 'package:razco_foods/view/screens/my_points/my_points/inner/buy_promo_popup.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class MyPointsScreen extends StatelessWidget {
  MyPointsScreen({super.key});

  PointsController controller = Get.find<PointsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteLightWhite1,
        centerTitle: true,
        title: const CustomText(
          text: AppStrings.myPoints,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.greenNormalGreen4,
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: (){
              controller.getCouponOffer();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getCouponOffer();
              },
            );
          case Status.completed:
            return SingleChildScrollView(
              controller: controller.scrollController,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 8,
                  color: AppColors.whiteNormalhoverWhite5,
                ),

                ///<====================== points ==========================>
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                  child: GestureDetector(
                    onTap: () {
                     // Get.toNamed(AppRoute.pointsDetailsScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        color: AppColors.blueNormalBleu4,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomImage(
                            imageSrc: AppIcons.point,
                            imageType: ImageType.svg,
                            size: 48,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                text:
                                    'Available Points: ${controller.totalPointsModel.value.totalData?.available ?? 0}',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.h,
                              ),
                              CustomText(
                                text:
                                    'Used Points: ${controller.totalPointsModel.value.totalData?.used ?? 0}',
                                color: AppColors.whiteNormalactiveWhite6,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.h,
                                top: 4.h,
                              ),
                            ],
                          ),
                          const CustomImage(
                            imageSrc: AppIcons.expandRight,
                            imageType: ImageType.svg,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  width: MediaQuery.of(context).size.width,
                  height: 8,
                  color: AppColors.whiteNormalhoverWhite5,
                ),

                ///<=========================== button ===========================>
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoute.couponStoreScreen);
                    },
                    title: 'Coupon Store',
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 16.h, top: 16.h),
                  width: MediaQuery.of(context).size.width,
                  height: 8,
                  color: AppColors.whiteNormalhoverWhite5,
                ),

                ///<===================== Coupon Offers ============================>
                CustomText(
                  text: 'Coupon Offers',
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                  left: 20.w,
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                    child: Column(
                      children: List.generate(

                        controller.couponOfferList.length,
                        (index) {
                          var data = controller.couponOfferList[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 12.w),
                            margin: EdgeInsets.only(bottom: 16.h),
                            decoration: BoxDecoration(
                                color: AppColors.whiteLightactiveWhite3,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColors.whiteNormalactiveWhite6)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text:
                                      '${controller.couponOfferList[index].couponDiscount ?? ""}% Discount',
                                ),
                                CustomText(
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  text:
                                      'Validity Date: ${controller.couponOfferList[index].expireDate}',
                                  bottom: 4.h,
                                  top: 4.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ///<=================== price =========================>
                                    CustomText(
                                      text:
                                          'Target Points: ${controller.couponOfferList[index].targetPoints ?? 0}',
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blueNormalBleu4,
                                    ),

                                    ///<================================ buy promo button =========================>



                                    controller.couponOfferList[index]
                                                .targetPoints! <=
                                            controller.totalPointsModel.value
                                                .totalData!.available!
                                        ? GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (index) {
                                                    return BuyPromoPopUp(
                                                      discount:
                                                          data.couponDiscount ??
                                                              "",
                                                      targetPoints:
                                                          data.targetPoints ??
                                                              "",
                                                      date:
                                                          data.expireDate ?? "",
                                                      couponCode: data.couponCode ?? "",
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h,
                                                  horizontal: 12.w),
                                              decoration: BoxDecoration(
                                                color: AppColors.greenNormalGreen4,
                                                //color: AppColors.whiteDarkhoverWhite8,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const CustomText(
                                                text: 'Claim',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              toastMessage(message: 'Not enough points');
                                             /* showDialog(
                                                  context: context,
                                                  builder: (index) {
                                                    return BuyPromoPopUp(
                                                      discount:
                                                          data.couponDiscount ??
                                                              "",
                                                      targetPoints:
                                                          data.targetPoints ??
                                                              "",
                                                      date:
                                                          data.expireDate ?? "",
                                                    );
                                                  });*/

                                              print(
                                                  controller.totalPointsModel.value
                                                      .totalData!.available);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h,
                                                  horizontal: 12.w),
                                              decoration: BoxDecoration(
                                                //color: AppColors.greenNormalGreen4,
                                                color: AppColors
                                                    .whiteDarkhoverWhite8,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const CustomText(
                                                text: 'Claim',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ))
              ],
            ));
        }
      }),
    );
  }
}
