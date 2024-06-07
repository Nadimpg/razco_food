import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/widgets/custom_category/custom_category.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/product_card/product_card.dart';

class NewArrival extends StatefulWidget {
  NewArrival({super.key});

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  HomeController controller = Get.find<HomeController>();

  /* @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getHomeProduct();
    });

    super.initState();
  }*/
  var status;
  getStatus() async {
    status = await SharePrefsHelper.getBool(AppConstants.guestUser);
  }

  @override
  void initState() {
    getStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.newArrival,
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
            return NoInternetScreen(onTap: () {
              controller.getHomeProduct();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getHomeProduct();
              },
            );
          case Status.completed:
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child: GridView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.only(
                  top: 20.h,
                ),
                itemCount: controller.homeProductList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    crossAxisCount: 2,
                    mainAxisExtent: 230,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // controller.subCateName= controller.subCatWiseProductList[index].subcategory ?? "";
                      // print(controller.subCateName);
                      Get.toNamed(AppRoute.productDeatils,
                          arguments: controller.homeProductList[index].id);
                    },
                    child: ProductCard(
                      image:
                          '${ApiConstant.baseUrl}${controller.homeProductList[index].productImage![0] ?? ""}',
                      title:
                          controller.homeProductList[index].productName ?? "",
                      price: controller.homeProductList[index].price ?? 0,
                      oldPrice:CustomText(
                                  decoration: TextDecoration.lineThrough,
                                  text:
                                      '\$${controller.homeProductList[index].discount ?? "0"}',
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.redDarkRed7,
                                ),
                      quantity: '${controller.homeProductList[index].weight ?? ""}kg',
                      bookMark: GestureDetector(
                          onTap: () {
                            if (status == true && status != null) {
                              Get.toNamed(AppRoute.logIn);
                              SharePrefsHelper.remove(AppConstants.guestUser);
                            } else {
                              controller.bookmark(
                                  toggleBookmark:
                                      controller.homeProductList[index].id ??
                                          "");
                              controller.refresh();
                            }
                          },
                          child: controller.homeProductList[index].favorite!
                              ? const CustomImage(
                                  imageSrc: AppIcons.love,
                                  imageColor: AppColors.greenNormalGreen4,
                                )
                              : const CustomImage(
                                  imageSrc: AppIcons.bookmark,
                                  imageColor: AppColors.greenNormalGreen4,
                                )),
                    ),
                  );
                },
              ),
            );
        }
      }),
    );
  }
}
