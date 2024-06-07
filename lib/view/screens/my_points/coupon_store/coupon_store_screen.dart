import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/view/screens/my_points/controller/points_controller.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class CouponStoreScreen extends StatelessWidget {
  CouponStoreScreen({super.key});

  PointsController controller = Get.find<PointsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteLightWhite1,
        centerTitle: true,
        title: const CustomText(
          text: 'Coupon Store',
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
            return const CustomLoader();
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getCouponStore();
              },
            );
          case Status.completed:
            return  controller.couponStoreList.isEmpty? const Center(
              child: CustomText(text: 'Empty',fontWeight: FontWeight.w500,),
            ): SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                child: Column(
                  children: List.generate(
                      controller.couponStoreList.length,
                      (index) => Container(
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
                                  text: '${controller.couponStoreList[index].couponDiscount ?? ""}% Discount',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                ),
                                CustomText(
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  text: 'Validity Date: ${controller.couponStoreList[index].expireDate ?? ""}',
                                  fontSize: 14,
                                  bottom: 8.h,
                                  top: 4.h,
                                ),
                                // const CustomText(
                                //   text: 'Price: ${'3k'}',
                                //   fontWeight: FontWeight.w500,
                                //   color: AppColors.blueNormalBleu4,
                                // ),
                                  Align(
                                  alignment: Alignment.center,
                                  child: CustomText(
                                    text: 'Coupon Code: ${controller.couponStoreList[index].couponCode ?? ""}',
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blueNormalBleu4,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          )),
                ));
        }
      }),
    );
  }
}
