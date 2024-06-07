import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/product_card/product_card.dart';

class RelatedProductScreen extends StatefulWidget {
  RelatedProductScreen({super.key});

  @override
  State<RelatedProductScreen> createState() => _RelatedProductScreenState();
}

class _RelatedProductScreenState extends State<RelatedProductScreen> {
  HomeController controller = Get.find<HomeController>();

  var id = Get.arguments;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getRelatedProduct(id: id);
      controller.relatedProductId = id;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Related Product',
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
            return const CustomLoader();
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getHomeProduct();
              },
            );
          case Status.completed:
            return controller.relatedProductList.isEmpty
                ? const Center(
                    child: CustomText(
                    text: 'Empty',
                    fontWeight: FontWeight.w500,
                  ))
                : Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                    child: GridView.builder(
                      controller: controller.scrollController,
                      padding: EdgeInsets.only(
                        top: 20.h,
                      ),
                      itemCount: controller.relatedProductList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 0,
                              crossAxisCount: 2,
                              mainAxisExtent: 230,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoute.productDeatils,arguments: controller.relatedProductList[index].id);
                          },
                          child: ProductCard(
                            image:
                            '${ApiConstant.baseUrl}${controller.relatedProductList[index].productImage![0] ?? ""}',
                            title: controller
                                .relatedProductList[index].productName ??
                                "",
                            price:
                            controller.relatedProductList[index].price ?? 0,
                            oldPrice:controller
                                .relatedProductList[index].discount!.isEmpty ? CustomText(text: ''):  CustomText(
                              decoration: TextDecoration.lineThrough,
                              text: '\$${controller
                                  .relatedProductList[index].discount ??
                                  "0"}',
                              fontWeight: FontWeight.w400,
                              color: AppColors.redDarkRed7,
                            ),
                            quantity:
                            '${controller.relatedProductList[index].weight ?? ""}kg',
                            bookMark: IconButton(
                                onPressed: () {
                                  controller.relatedProductBookmark(
                                      toggleBookmark: controller
                                          .relatedProductList[index].id ??
                                          "");
                                  controller.refresh();
                                },
                                icon: controller.relatedProductList[index].favorite!
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
