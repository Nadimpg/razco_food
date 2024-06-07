import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/screens/my_cart/generate_id.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class MyCartScreen extends StatefulWidget {
  MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final HomeController controller = Get.find<HomeController>();


  var quantity = 1;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getMYCard();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: AppStrings.myCart,
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
                controller.getMYCard();
              });
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  controller.getMYCard();
                },
              );
            case Status.completed:
              String cartID=controller.cartId.value;
              return controller.myCardList.isEmpty
                  ? const Center(
                      child: CustomText(
                        text: 'Empty',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.myCardList.length,
                      padding:
                          EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoute.productDeatils,arguments: controller.myCardList[index].product?.id);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.whiteNormalWhite4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///====================== Product Image ======================

                                // CustomImage(
                                //   size: 80.r,
                                //   imageSrc: AppImages.f1,
                                //   imageType: ImageType.png,
                                // ),
                                CustomNetworkImage(
                                    imageUrl:
                                        '${ApiConstant.baseUrl}${controller.myCardList[index].product?.productImage?[0] ?? ""}',
                                    height: 80.h,
                                    width: 80.w),

                                SizedBox(
                                  width: 10.w,
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ///====================== Product Name ======================

                                          CustomText(
                                            text: controller.myCardList[index]
                                                    .product?.productName ??
                                                "",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.w,
                                            bottom: 4.h,
                                          ),
                                          CustomText(
                                              text: controller.myCardList[index]
                                                      .product?.weight ??
                                                  ""),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          ///================== Product Price ==================

                                          CustomText(
                                            text:
                                                "\$${controller.myCardList[index].product?.price ?? ""}",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.w,
                                            right: 20.w,
                                          ),
                                          /* Row(
                                      children: [
                                        ///================== Minus Button ==================
                                        Container(
                                          height: 30.w,
                                          width: 30.w,
                                          color: AppColors.blueLighthoverBleu2,
                                          child: const Icon(Icons.remove),
                                        ),

                                        ///================== Quantity ==================
                                        Container(
                                          alignment: Alignment.center,
                                          height: 30.w,
                                          width: 30.w,
                                          color: AppColors.blueLighthoverBleu2,
                                          child: const CustomText(text: "1"),
                                        ),

                                        ///================== Add Button ==================

                                        Container(
                                          height: 30.w,
                                          width: 30.w,
                                          color: AppColors.blueLighthoverBleu2,
                                          child: const Icon(Icons.add),
                                        ),
                                      ],
                                    )*/
                                          Expanded(
                                            child: Row(
                                              children: [
                                                ///================== Minus Button ==================
                                                IconButton(
                                                    onPressed: () {
                                                      if (controller.myCardList[index].quantity != null && controller.myCardList[index].quantity! > 1) {
                                                        controller.myCardList[index].quantity = controller.myCardList[index].quantity! - 1;

                                                        controller.addCard(cardId: controller.myCardList[index].product?.id ?? "",
                                                          quantity: controller.myCardList[index].quantity!,
                                                        );
                                                      }
                                                    },
                                                    icon: Container(
                                                      color: AppColors
                                                          .blueLighthoverBleu2,
                                                      child: const Icon(
                                                          Icons.remove),
                                                    )),

                                                ///================== Quantity ==================
                                                Container(
                                                  alignment: Alignment.center,
                                                  color: AppColors
                                                      .blueLighthoverBleu2,
                                                  child: CustomText(
                                                      text: controller
                                                          .myCardList[index]
                                                          .quantity
                                                          .toString()
                                                  ),
                                                ),

                                                ///================== Add Button ==================

                                                IconButton(
                                                    onPressed: () {

                                                        controller.myCardList[index].quantity =(controller.myCardList[index].quantity! + 1);

                                                        controller.addCard(cardId: controller.myCardList[index].product?.id ?? "", quantity: controller.myCardList[index].quantity!,
                                                        );

                                                    },
                                                    icon: Container(
                                                      color: AppColors
                                                          .blueLighthoverBleu2,
                                                      child:
                                                          const Icon(Icons.add),
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                ///================== Delete Button ==================

                                IconButton(
                                    onPressed: () {
                                      controller.cardDelete(
                                          id: controller.myCardList[index]
                                                  .product?.id ??
                                              "");

                                      // controller.myCardList.removeAt(index);
                                      // controller.myCardList.refresh();
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever_outlined,
                                      color: AppColors.whiteNormalactiveWhite6,
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    );
          }
        }),
        bottomNavigationBar: SizedBox(
          height: controller.hasCoupon.value
              ? (MediaQuery.of(context).size.height / 3) +
              MediaQuery.of(context).viewInsets.bottom
              : (MediaQuery.of(context).size.height / 4) +
              MediaQuery.of(context).viewInsets.bottom,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ///========================== Coupon Input Field =========================

                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.all(0.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: AppColors.blueNormalBleu4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        left: 10,
                        text: AppStrings.haveaPromoCode,
                        color: AppColors.whiteLightWhite1,
                      ),
                      IconButton(
                          onPressed: () {
                            controller.hasCoupon.value =
                            !controller.hasCoupon.value;

                            controller.hasCoupon.refresh();
                          },
                          icon: controller.hasCoupon.value
                              ? const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.whiteLightWhite1,
                          )
                              : const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColors.whiteLightWhite1,
                          ))
                    ],
                  ),
                ),

                if (controller.hasCoupon.value)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ///====================== Enter Coupon Field ==========================

                        Expanded(
                            child: CustomTextField(
                              textEditingController:controller.promoCodeController ,
                              textInputAction: TextInputAction.done,
                              hintText: "promo code",
                            )),

                        ///============================ Apply Button ==========================

                        controller.loading? const CustomLoader():  TextButton(
                            onPressed: () {
                              controller.applyPromoCode(promoCode: controller.promoCodeController.text);
                            },
                            child: const CustomText(
                              text: AppStrings.apply,
                              color: AppColors.blueNormalBleu4,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  ),

                ///============================ Total Ammount ==========================

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: AppStrings.totalAmount,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    CustomText(text: "\$${controller.calculatePrice()}"),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///============================ Check Out Button ==========================
                CustomButton(
                  onTap: ()async{
                    String productID=await GenerateIDs().generateProductId();
                    Get.toNamed(AppRoute.payment,arguments: [productID,controller.calculatePrice(),controller.totalItem(),controller.cartId.value]);
                    print(controller.cartId.value);
                  },
                  title: AppStrings.checkOut,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
