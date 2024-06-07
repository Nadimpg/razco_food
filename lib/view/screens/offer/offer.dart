import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/nav_bar/nav_bar.dart';

class OfferScreen extends StatelessWidget {
    OfferScreen({super.key});

    HomeController controller=Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 3),
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: CustomText(
          text: AppStrings.offer,
          color: AppColors.greenNormalGreen4,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: (){
              controller.getOffer();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getOffer();
              },
            );
          case Status.completed:
            return controller.offerList.isEmpty? Center(
              child: CustomText(
                text:'Empty',
                fontWeight: FontWeight.w500,
              ),
            ):  ListView.builder(
              padding: EdgeInsets.only(top: 24.h, right: 20.w, left: 20.w),
              itemCount: controller.offerList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.offerDetails, arguments: [controller.offerList[index].id,controller.offerList[index].offerName]  );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 120.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image:   DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${ApiConstant.baseUrl}${controller.offerList[index].offerImage ?? ""}')
                        )),
                    child: CustomText(
                      text: controller.offerList[index].offerName ?? "",
                      color: AppColors.whiteLightWhite1,
                      fontSize: 20.r,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ) ;
        }
      }),
    );
  }
}
