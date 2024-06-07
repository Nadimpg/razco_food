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
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/product_card/product_card.dart';

class SubCategoryProduct extends StatefulWidget {
  SubCategoryProduct({super.key});

  @override
  State<SubCategoryProduct> createState() => _SubCategoryProductState();
}

class _SubCategoryProductState extends State<SubCategoryProduct> {
  HomeController controller = Get.find<HomeController>();

  var status;
  getStatus() async {
    status = await SharePrefsHelper.getBool(AppConstants.guestUser);
  }

  @override
  void initState() {
    getStatus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSubCateWiseProduct(subCateName: controller.subCateName);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: AppStrings.popularCategories,
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
              controller.getSubCateWiseProduct();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getSubCateWiseProduct();
              },
            );
          case Status.completed:
            return controller.subCatWiseProductList.isEmpty?const Center(
              child: CustomText(text: 'Empty',fontWeight: FontWeight.w500,),
            ): Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child: GridView.builder(
                padding: EdgeInsets.only(
                  top: 20.h,
                ),
                itemCount: controller.subCatWiseProductList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    mainAxisExtent: 220,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.subCateName= controller.subCatWiseProductList[index].subcategory ?? "";
                      print(controller.subCateName);
                      Get.toNamed(AppRoute.productDeatils,arguments: controller.subCatWiseProductList[index].id);
                    },
                    child:  ProductCard(
                      image: '${ApiConstant.baseUrl}${controller.subCatWiseProductList[index].productImage![0] ?? ""}',
                      title: controller.subCatWiseProductList[index].productName ?? "",
                      price: controller.subCatWiseProductList[index].price ?? 0,
                      oldPrice:controller
                          .subCatWiseProductList[index].discount!.isEmpty ? CustomText(text: ''):  CustomText(
                        decoration: TextDecoration.lineThrough,
                        text: '\$${controller
                            .subCatWiseProductList[index].discount ??
                            "0"}',
                        fontWeight: FontWeight.w400,
                        color: AppColors.redDarkRed7,
                      ),
                      quantity:  '${controller.subCatWiseProductList[index].weight ?? ""}kg',
                      bookMark: IconButton(
                        onPressed: () {

                          if (status == true && status != null) {
                            Get.toNamed(AppRoute.logIn);
                            SharePrefsHelper.remove(AppConstants.guestUser);
                          } else {
                            controller.subCatBookmark(toggleBookmark: controller.subCatWiseProductList[index].id ?? "");
                            controller.refresh();
                          }

                        },
                        icon:controller.subCatWiseProductList[index].favorite! ? const CustomImage(
                          imageSrc: AppIcons.love,
                          imageColor: AppColors.greenNormalGreen4,
                        ): const CustomImage(
                          imageSrc: AppIcons.bookmark,
                          imageColor: AppColors.greenNormalGreen4,
                        )
                    ),
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
