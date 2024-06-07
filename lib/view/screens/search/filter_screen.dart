import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/utils/app_colors.dart';

import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final List<String> categoryList = [
    "Bowal",
    "Pizza",
    "Salad",
    "Burger",
    "Pizza",
    "Salad",
    "Burger",
    "Bowal",
  ];

  HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon: const Icon(Icons.close)),
        iconTheme: const IconThemeData(color: AppColors.whiteLightWhite1),
        title: CustomText(
          text: AppStrings.filter,
          color: AppColors.whiteLightWhite1,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: AppColors.greenNormalGreen4,
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppStrings.price,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                bottom: 10.h,
              ),

              ///============================ Price Range =============================
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    textEditingController: controller.minPriceController,
                    fillColor: AppColors.whiteLightWhite1,
                  )),
                  CustomText(
                    right: 15.w,
                    left: 15.w,
                    text: AppStrings.to,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Expanded(
                      child: CustomTextField(
                    textEditingController: controller.maxPriceController,
                    fillColor: AppColors.whiteLightWhite1,
                  )),
                ],
              ),

              ///============================ Categories =============================
              CustomText(
                top: 24.h,
                text: AppStrings.categories,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                bottom: 12.h,
              ),

              Expanded(
                child: GridView.builder(
                  itemCount: controller.subCatList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      mainAxisExtent: 40,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {

                    return GestureDetector(
                      onTap: () {

                        controller.subName= controller.subCatList[index].subcategoryName ?? "";
                        controller.selectedIndex = index;

                       print(controller.selectedIndex);
                       print(controller.subName);
                        controller.update();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                            color: controller.selectedIndex == index
                                ? AppColors.greenNormalGreen4
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border:
                                Border.all(color: AppColors.greenNormalGreen4)),
                        child: CustomText(
                            text:
                             controller.subCatList[index].subcategoryName ??
                                    ""),
                      ),
                    );
                  },
                ),
              ),

              ///============================ Apply Filter Button =============================
              CustomButton(
                onTap: () {
                   controller.getSearch(
                     isFilter: true,
                    priceMin: controller.minPriceController.text,
                    priceMax: controller.maxPriceController.text,
                   );
                  print(controller.subName);
                },
                title: AppStrings.applyFiltering,
              ),
              SizedBox(
                height: 24.h,
              )
            ],
          ),
        );
      }),
    );
  }
}
