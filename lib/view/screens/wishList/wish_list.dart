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
import 'package:razco_foods/view/widgets/nav_bar/nav_bar.dart';
import 'package:razco_foods/view/widgets/product_card/product_card.dart';

class WishListScreen extends StatefulWidget {
  WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  HomeController controller=Get.find<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getWishList();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const NavBar(currentIndex: 4),
        appBar: AppBar(
          title: CustomText(
            text: AppStrings.wishlist,
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
                controller.getWishList();
              });
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  controller.getWishList();
                },
              );
            case Status.completed:
              return controller.wishList.isEmpty? const Center(
                child: CustomText(text: 'Empty',fontWeight: FontWeight.w500,),
              ): GridView.builder(
                padding: EdgeInsets.only(top: 20.h, left: 20,),
                itemCount: controller.wishList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 220,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.productDeatils,arguments:  controller.wishList[index].product?.id ?? "");
                    },
                    child:  ProductCard(
                      image: '${ApiConstant.baseUrl}${controller.wishList[index].product?.productImage![0] ?? ""}',
                      title: controller.wishList[index].product?.productName ?? "",
                      price: controller.wishList[index].product?.price ?? 0,
                      oldPrice:   CustomText(
                        decoration: TextDecoration.lineThrough,
                        text: '\$${controller
                            .wishList[index].product!.discount ??
                            "0"}',
                        fontWeight: FontWeight.w400,
                        color: AppColors.redDarkRed7,
                      ),
                      quantity:  '${controller.wishList[index].product?.weight ?? ""}kg',
                     // percentagePrice:  controller.wishList[index].product?.offer ?? "",
                      //showOffer: true,
                      bookMark: IconButton(
                        onPressed: () {
                          controller.bookmark(toggleBookmark: controller.wishList![index].product?.id ?? "");
                          controller.wishList.removeAt(index);
                          controller.wishList.refresh();
                        },
                        icon: const CustomImage(
                          imageSrc: AppIcons.love,
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
