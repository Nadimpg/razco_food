import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/nav_bar/nav_bar.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});


  HomeController controller=Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: CustomText(
          text: AppStrings.shop,
          color: AppColors.greenNormalGreen4,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBar: const NavBar(currentIndex: 1),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: (){
              controller.getCategory();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getCategory();
              },
            );
          case Status.completed:
            return controller.catList.isEmpty? const Center(
              child: CustomText(
                text: 'Empty',
                fontWeight: FontWeight.w500,
              ),
            ) :GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                  mainAxisSpacing: 0),
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h),
              itemCount: controller.catList.length,
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.foodListScreen,arguments: [controller.catList[index].id,controller.catList[index].categoryName] );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: AppColors.greenNormalGreen4)),
                        child:

                        ///============================== Image ==================================>

                        CustomNetworkImage(imageUrl: '${ApiConstant.baseUrl}${controller.catList[index].categoryImage ?? ""}', height: 120.h, width: MediaQuery.of(context).size.width *.5)
                      ),
                    ),
                    CustomText(
                      text: controller.catList[index].categoryName ?? "",
                      fontSize: 14.h,
                      fontWeight: FontWeight.w500,
                      top: 8.h,
                    )
                  ],
                );
              },
            )  ;
        }
      }),
    );
  }
}
