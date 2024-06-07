import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';

import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/screens/order_history/order_history_controller/order_history_controller.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({super.key});

  OrderHistoryController controller = Get.find<OrderHistoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLightWhite1,
      appBar: AppBar(
        backgroundColor: AppColors.whiteLightWhite1,
        centerTitle: true,
        title: const CustomText(
          text: AppStrings.orderHistory,
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
              controller.getOrderHistory();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getOrderHistory();
              },
            );
          case Status.completed:
            return controller.orderList.isEmpty? const Center(
              child: CustomText(text: 'Empty',fontWeight: FontWeight.w500,),
            ): SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child: Column(
                children: List.generate(controller.orderList.length, (index) {
                  var data=controller.orderList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.orderHistoryDetails,arguments: data);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.whiteNormalhoverWhite5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///<====================== order num & status ======================>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'Order No : #${data.orderId ?? ""}'),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.h, horizontal: 12.w),
                                decoration: BoxDecoration(
                                    color: AppColors.blueLightactiveBleu3,
                                    borderRadius: BorderRadius.circular(8)),
                                child: CustomText(text: data.status ?? ""),
                              )
                            ],
                          ),

                          ///<======================  Total Products ======================>
                          CustomText(
                            text: 'Total Products : ${data.totalItem ?? 0}',
                           // text: data.cart!.products![index].quantity.toString(),
                            top: 8.h,
                            bottom: 8.h,
                          ),

                          ///<======================  Date ======================>
                          CustomText(
                           // text: 'date : ${data.deliveryDate ?? ""}',
                            text: 'date : ${data.deliveryDate != null ? DateFormat.yMMMd().format(data.deliveryDate!) : ''}',
                            top: 8.h,
                            bottom: 8.h,
                          ),

                          ///<======================  price ======================>
                          CustomText(
                            text: 'Price : \$${data.price ?? 0}',
                            top: 8.h,
                            bottom: 8.h,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
        }
      }),
    );
  }
}
