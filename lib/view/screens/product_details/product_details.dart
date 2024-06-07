import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/global/const/const.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/product_card/product_card.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({super.key,this.id});

  var id;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final HomeController controller = Get.find<HomeController>();

  dynamic id = Get.arguments;
  var quantity=1;

  var status;
  getStatus()async{
    status= await SharePrefsHelper.getBool(AppConstants.guestUser);
  }

  // @override
  // void initState() {
  //   getStatus();
  //   super.initState();
  // }
// dynamic subCateName=Get.arguments[1];
  @override
  void initState() {

    getStatus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     // controller.relatedProductId = id;
      controller.getRelatedProduct(id: id);
      controller.getProductDetails(id: id);
      controller.relatedProductId=id;
      //controller.getRelatedProduct(id: id);
    });
    setState(() {

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          controller.isAddToCard.value = false;
          controller.isAddToCard.refresh();
        },
        child: Scaffold(
            bottomNavigationBar: controller.isAddToCard.value
                ? Container(
                    margin: EdgeInsets.only(bottom: 20.h,),
                    padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 8.h,bottom: 8.h),
                    color: AppColors.blueNormalBleu4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///======================= Item Price ========================

                          CustomText(
                          text: "${controller.quantity.value} Items/ \$${ controller
                              .productDetailsModel.value.data?.price}",
                          fontWeight: FontWeight.w400,
                          color: AppColors.whiteLightWhite1,
                        ),

                        ///======================= View Cart ========================

                        IconButton(
                            onPressed: () {
                              Get.toNamed(AppRoute.myCart);
                            },
                            icon: const Row(
                              children: [
                                CustomImage(
                                  imageSrc: AppIcons.cart,
                                  imageColor: AppColors.whiteLightWhite1,
                                ),
                                CustomText(
                                  left: 4,
                                  text: AppStrings.viewCart,
                                  color: AppColors.whiteLightWhite1,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: AppColors.whiteLightWhite1,
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                : null,
            appBar: AppBar(
              centerTitle: true,
              title: CustomText(
                text: AppStrings.details,
                color: AppColors.greenNormalGreen4,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ///======================== Product Image ==========================

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        controller.bannerIndex.value = value;

                        controller.pageController.value = PageController(
                            initialPage: controller.bannerIndex.value);
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.productDetailsModel.value.data?.productImage?.length,
                      itemBuilder: (context, index) {
                        return CustomNetworkImage(
                            imageUrl:
                                '${ApiConstant.baseUrl}${controller.productDetailsModel.value.data?.productImage?[index] ?? ""}',
                            height: 70.h,
                            width: MediaQuery.of(context).size.width - 100);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),

                  ///============================ Smooth Indicator ======================================

                  ConstValue.indicator(
                      controller: controller.pageController.value, count: 3),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ///================ Price ====================

                                CustomText(
                                  text:
                                      "\$${controller.productDetailsModel.value.data?.price ?? 0}",
                                  color: AppColors.greenNormalGreen4,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.w,
                                ),

                                ///================ Quantity ====================
                                CustomText(
                                  text:
                                      " / ${controller.productDetailsModel.value.data?.weight ?? ""}kg",
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ///================== Minus Button ==================
                                IconButton(
                                    onPressed: () {
                                      if (controller.quantity.value > 1) {
                                        controller.quantity.value -= 1;

                                        controller.quantity.refresh();
                                      }
                                    },
                                    icon: Container(
                                      height: 30.w,
                                      width: 30.w,
                                      color: AppColors.blueLighthoverBleu2,
                                      child: const Icon(Icons.remove),
                                    )),

                                ///================== Quantity ==================
                                Container(
                                  alignment: Alignment.center,
                                  height: 30.w,
                                  width: 50.w,
                                  color: AppColors.blueLighthoverBleu2,
                                  child: CustomText(
                                      text: controller.quantity.value.toString()),
                                ),

                                ///================== Add Button ==================

                                IconButton(
                                    onPressed: () {
                                      controller.quantity.value += 1;

                                      controller.quantity.refresh();
                                    },
                                    icon: Container(
                                      height: 30.w,
                                      width: 30.w,
                                      color: AppColors.blueLighthoverBleu2,
                                      child: const Icon(Icons.add),
                                    )),
                              ],
                            )
                          ],
                        ),

                        ///========================== Product Name ==========================

                        CustomText(
                          text: controller
                                  .productDetailsModel.value.data?.productName ??
                              "",
                          fontSize: 16.w,
                          fontWeight: FontWeight.w400,
                        ),

                        ///========================== Product Brand ==========================

                        CustomText(
                          top: 6.h,
                          bottom: 10.h,
                          text:
                              controller.productDetailsModel.value.data?.brand ??
                                  "",
                          fontSize: 12.w,
                          fontWeight: FontWeight.w300,
                        ),

                        ///========================== Product Details ==========================

                        CustomText(
                          top: 2.h,
                          bottom: 2.h,
                          text: AppStrings.productDeatils,
                          fontSize: 12.w,
                          fontWeight: FontWeight.w300,
                        ),
                        CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 10,
                          top: 4.h,
                          bottom: 30.h,
                          text: controller
                                  .productDetailsModel.value.data?.description ??
                              "",
                          fontWeight: FontWeight.w200,
                        ),

                        Row(
                          children: [
                            ///========================== Buy Now ==========================

                            // Expanded(
                            //   child: GestureDetector(
                            //     onTap: () {},
                            //     child: Container(
                            //       padding: EdgeInsets.symmetric(vertical: 12.h),
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(16.r),
                            //           border: Border.all(
                            //               color: AppColors.greenNormalGreen4)),
                            //       child: const CustomText(
                            //         text: AppStrings.buyNow,
                            //         color: AppColors.greenNormalGreen4,
                            //         fontWeight: FontWeight.w400,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 20.w,
                            // ),

                            ///========================== Add To Cart ==========================

                            Expanded(
                              child: GestureDetector(
                                onTap: () {

                                  if(status==true && status!=null){
                                    Get.toNamed(AppRoute.logIn);
                                    SharePrefsHelper.remove(
                                        AppConstants
                                            .guestUser);
                                  } else{
                                    controller.isAddToCard.value =
                                    !controller.isAddToCard.value;
                                    // ignore: invalid_use_of_protected_member
                                    controller.addCard(cardId:  controller
                                        .productDetailsModel.value.data?.id ?? "",quantity: controller.quantity.value
                                    );
                                    controller.refresh();
                                  }


                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      color: AppColors.greenNormalGreen4),
                                  child: const CustomText(
                                    fontWeight: FontWeight.w300,
                                    text: AppStrings.addtocart,
                                    color: AppColors.whiteLightWhite1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///========================= Related Product ==============================

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: AppStrings.relatedProduct,
                                fontSize: 14.w,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greenNormalGreen4,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoute.relatedProductScreen, arguments: id);
                                  },
                                  icon: const Row(
                                    children: [
                                      CustomText(
                                        text: AppStrings.viewAll,
                                        color: AppColors.blueDarkerBleu10,
                                      ),
                                      Icon(Icons.arrow_right_alt)
                                    ],
                                  )),
                            ],
                          ),
                        ),

                        controller.relatedProductList.isEmpty
                            ? const Center(
                                child: CustomText(
                                  text: 'Empty',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      controller.relatedProductList.length,
                                      (index) {

                                    return GestureDetector(
                                      onTap: (){
                                     //  Get.toNamed(AppRoute.productDeatils,arguments: controller.relatedProductList[index].id);

                                       // Get.to(()=>ProductDetails(id: controller.relatedProductList[index].id.toString()));

                                      },
                                      child: ProductCard(
                                        image:
                                            '${ApiConstant.baseUrl}${controller.relatedProductList[index].productImage![0] ?? ""}',
                                        title: controller.relatedProductList[index]
                                                .productName ??
                                            "",
                                        price: controller
                                                .relatedProductList[index].price ??
                                            0,
                                        oldPrice:controller
                                            .relatedProductList[index].discount!.isEmpty ? CustomText(text: ''):  CustomText(
                                          decoration: TextDecoration.lineThrough,
                                          text: '\$${controller
                                              .relatedProductList[index].discount ??
                                              "0"}',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.redDarkRed7,
                                        ),
                                        quantity: '${controller.relatedProductList[index].weight ?? ""}kg',
                                        bookMark: IconButton(
                                            onPressed: () {
                                              controller.relatedProductBookmark(
                                                  toggleBookmark: controller
                                                          .relatedProductList[index]
                                                          .id ??
                                                      "");
                                              controller.relatedProductList.refresh();
                                            },
                                            icon: controller
                                                    .relatedProductList[index]
                                                    .favorite!
                                                ? const CustomImage(
                                                    imageSrc: AppIcons.love,
                                                    imageColor:
                                                        AppColors.greenNormalGreen4,
                                                  )
                                                : const CustomImage(
                                                    imageSrc: AppIcons.bookmark,
                                                    imageColor:
                                                        AppColors.greenNormalGreen4,
                                                  )),
                                      ),
                                    );
                                  }),
                                ),
                              ),

                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }
}
