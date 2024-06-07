import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/widgets/custom_category/custom_category.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class SubCategoryScreen extends StatelessWidget {
  SubCategoryScreen({super.key});

  HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            color: AppColors.greenNormalGreen4,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            text: 'Popular Category'),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: (){
              controller.getSubCategory();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getSubCategory();
              },
            );
          case Status.completed:
            return controller.subCatList.isEmpty
                ? const Center(
                    child: CustomText(
                      text: 'Empty',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.only(top: 20.h),
                    itemCount: controller.subCatList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.subCateName= controller.subCatList[index].subcategoryName ?? "";
                          print(controller.subCateName);
                          Get.toNamed(AppRoute.subCategoryProduct);
                          // Get.toNamed(AppRoute.subCategoryProduct);
                        },
                        child: CustomCatagory(
                            paddingRight: 0,
                            title:
                                controller.subCatList[index].subcategoryName ??
                                    "",
                            image:
                                '${ApiConstant.baseUrl}${controller.subCatList[index].subcategoryImage ?? ""}'),
                      );
                    },
                  );
        }
      }),
    );
  }
}
