import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';
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
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:razco_foods/view/widgets/product_card/product_card.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});



  HomeController controller=Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.whiteLightWhite1),
        title: CustomText(
          text: AppStrings.search,
          color: AppColors.whiteLightWhite1,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: AppColors.greenNormalGreen4,
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: (){
              controller.getSearch();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getSearch(isFilter: true);
              },
            );
          case Status.completed:
            return  Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(20),
                    color: AppColors.greenNormalGreen4,
                    child: Row(children: [
                      ///================Search Text Form Field==============
                        Expanded(
                          child: CustomTextField(
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                controller.getSearch(
                                     search: value );
                              }
                            },
                            fillColor: AppColors.whiteLightWhite1,
                            hintText: AppStrings.searchProduct,
                            isPrefixIcon: true,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.getSearch();
                                },
                                icon: const Icon(Icons.close)),
                          )),
                      SizedBox(
                        width: 12.w,
                      ),

                      ///================Filter Button==============///
                      ///
                      IconButton(
                          onPressed: () {
                            Get.toNamed(AppRoute.filterScreen);
                          },
                          icon: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppColors.greenLighthoverGreen2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.filter_alt_sharp))),
                    ])),

                ///============================== Searched Content ===========================///

                Expanded(
                  child:controller.searchList.isEmpty?const Center(
                    child: CustomText(text: 'Empty',
                    fontWeight: FontWeight.w500,
                    ),
                  ): GridView.builder(
                    padding: EdgeInsets.only(top: 20.h, left: 20, right: 20),
                    itemCount: controller.searchList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        crossAxisCount: 2,
                        mainAxisExtent: 210,
                        mainAxisSpacing: 15),
                    itemBuilder: (context, index) {
                      var data=controller.searchList[index];
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoute.productDeatils,arguments:data.id);
                        },
                        child: ProductCard(
                          paddingRight: 0,
                          image: '${ApiConstant.baseUrl}${data.productImage![0] ?? ""}',
                          title: data.productName ?? "",
                          price: data.price ?? 0,
                          oldPrice:data.discount!.isEmpty ? CustomText(text: ''):  CustomText(
                            decoration: TextDecoration.lineThrough,
                            text: '\$${data.discount ??
                                "0"}',
                            fontWeight: FontWeight.w400,
                            color: AppColors.redDarkRed7,
                          ),
                          quantity: data.weight ?? "",
                          bookMark: IconButton(
                            onPressed: () {
                              controller.bookmark(toggleBookmark: data.id ?? "");
                              controller.update();
                            },
                            icon:data.favorite! ? const CustomImage(
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
                )
              ],
            ) ;
        }
      }),
    );
  }
}
