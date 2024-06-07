import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/screens/order_history/order_history_controller/order_history_controller.dart';
import 'package:razco_foods/view/widgets/custom_card/custom_card.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class ScanHistoryList extends StatelessWidget {
  ScanHistoryList({super.key});

  OrderHistoryController controller = Get.find<OrderHistoryController>();
  @override
  Widget build(BuildContext context) {
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
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: (){
              controller.getScanHistoryList();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getScanHistoryList();
              },
            );
          case Status.completed:
            return  controller.scanHistoryList.isEmpty? const Center(
              child: CustomText(text: 'Empty',fontWeight: FontWeight.w500,),
            ): SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child: Column(
                   children: List.generate(
              controller.scanHistoryList.length,
                  (index) => CustomCard(
                onDetails: () {
                  Get.toNamed(AppRoute.productDeatils,
                      arguments:
                      controller.scanHistoryList[index].id);
                },
                productImage: '${ApiConstant.baseUrl}${controller.scanHistoryList[index].productImage?[index] ?? ""}',
                productName: controller.scanHistoryList[index].productName ?? "",
                productPrice: '\$${controller.scanHistoryList[index].price ?? ""}',

                onDelete: () {
                  controller.scanHistoryDelete(code: controller.scanHistoryList[index].barcode ?? "");
                },
                    weight: controller.scanHistoryList[index].weight ?? "",)),
                  ),
            );
        }
      }),
    );
  }
}
