import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/order_history/order_history_controller/order_history_controller.dart';
import 'package:razco_foods/view/widgets/custom_card/custom_card.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class ScanHistoryScreen extends StatelessWidget {
    ScanHistoryScreen({super.key});

    final OrderHistoryController controller = Get.find<OrderHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.whiteLightWhite1,
            centerTitle: true,
            title: const CustomText(
              text: AppStrings.scanHistory,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.greenNormalGreen4,
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            child: Column(
              children: List.generate(
                  controller.scanList.length,
                  (index) => CustomCard(
                      onDetails: () {
                        Get.toNamed(AppRoute.productDeatils,
                            arguments:
                            controller.scanList[index].id);
                      },
                      productImage: '${ApiConstant.baseUrl}${controller.scanList[index].productImage?[index] ?? ""}',
                      productName: controller.scanList[index].productName ?? "",
                      productPrice: '\$${controller.scanList[index].price ?? ""}',
                   /*   selectButton: GestureDetector(
                        onTap: (){
                          controller.isAddToCard.value =
                          !controller.isAddToCard.value;
                          // ignore: invalid_use_of_protected_member
                          controller.refresh();
                        },
                        child: CustomImage(
                          imageSrc: AppIcons.scan,
                          imageType: ImageType.svg,
                        ),
                      ),*/
                      onDelete: () {}, weight: controller.scanList[index].weight ?? "",)),
            ),
          ),
        /*  bottomNavigationBar: controller.isAddToCard.value
              ? Container(
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.all(5.r),
            color: AppColors.blueNormalBleu4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///======================= Item Price ========================

                const CustomText(
                  text: "1 Items/ \$98",
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteLightWhite1,
                ),

                ///======================= View Cart ========================

                IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.myCart);
                    },
                    icon: const Row(
                      children: [
                        CustomImage(
                          imageSrc: AppIcons.cart,
                          imageColor: AppColors.whiteLightWhite1,
                        ),
                        CustomText(
                          left: 4,
                          text: AppStrings.viewCart,
                          color: AppColors.whiteLightWhite1,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: AppColors.whiteLightWhite1,
                        )
                      ],
                    ))
              ],
            ),
          )
              : null,*/
        );
      }
    );
  }
}
