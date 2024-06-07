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
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/product_card/product_card.dart';

class OfferDetails extends StatefulWidget {
  OfferDetails({super.key});

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {

  HomeController controller=Get.find<HomeController>();

  final String id = Get.arguments[0];
  final String title = Get.arguments[1];

  var status;
  getStatus() async {
    status = await SharePrefsHelper.getBool(AppConstants.guestUser);
  }

  @override
  void initState() {
    getStatus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.productID=id;
      controller.getOfferProduct(offerName: id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: title,
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
                controller.getOfferProduct(offerName: title);
              });
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  controller.getOfferProduct(offerName: title);
                },
              );
            case Status.completed:
              return controller.offerProductList.isEmpty? const Center(
                child: CustomText(text: 'Empty',fontWeight: FontWeight.w500,),
              ) :  GridView.builder(
                padding: EdgeInsets.only(top: 20.h, left: 20, right: 20),
                itemCount: controller.offerProductList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 220,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.productDeatils,arguments:  controller.offerProductList[index].id ?? "");
                    },
                    child: ProductCard(
                      showOffer: true,
                      image: '${ApiConstant.baseUrl}${controller.offerProductList[index].productImage![0] ?? ""}',
                      title: controller.offerProductList[index].productName ?? "",
                      price: controller.offerProductList[index].price ?? 0,
                      oldPrice:controller
                          .offerProductList[index].discount!.isEmpty ? CustomText(text: ''):  CustomText(
                        decoration: TextDecoration.lineThrough,
                        text: '\$${controller
                            .offerProductList[index].discount ??
                            "0"}',
                        fontWeight: FontWeight.w400,
                        color: AppColors.redDarkRed7,
                      ),
                      quantity: '${ controller.offerProductList[index].weight ?? ""}kg',
                      percentagePrice: controller.offerProductList[index].offer?.percentage ?? 0,
                      bookMark: IconButton(
                          onPressed: () {

                            if (status == true && status != null) {
                              Get.toNamed(AppRoute.logIn);
                              SharePrefsHelper.remove(AppConstants.guestUser);
                            } else {
                              controller.offerProductBookmark(toggleBookmark: controller.offerProductList[index].id ?? "");
                              controller.update();
                            }

                          },
                          icon:controller.offerProductList[index].favorite! ? const CustomImage(
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
              ) ;
          }
        }),
    );
  }
}
