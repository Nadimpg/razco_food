import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/utils/snackbar_toastmsg.dart';
import 'package:razco_foods/view/screens/notification/notification_controller.dart';
import 'package:razco_foods/view/screens/order_history/order_history_controller/order_history_controller.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderHistoryDetails extends StatefulWidget {
  OrderHistoryDetails({super.key});

  @override
  State<OrderHistoryDetails> createState() => _OrderHistoryDetailsState();
}

class _OrderHistoryDetailsState extends State<OrderHistoryDetails> {
  NotificationController notificationController=Get.find<NotificationController>();

  var data = Get.arguments;

 // var item = Get.arguments[1];

  Uri dialNumber=Uri(scheme: 'tel' , path: '01923647795');

  callNumber()async{
    await launchUrl(dialNumber);
  }

/*  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationController.getCallPick();
    });
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteLightWhite1,
        centerTitle: true,
        title: CustomText(
          text: 'Order No #${data.orderId ?? ""}',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.greenNormalGreen4,
        ),
      ),
      bottomNavigationBar: GetBuilder<OrderHistoryController>(
        builder: (controller) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h,horizontal: 20.w),
            child:data.callForPickup ==false?SizedBox() :CustomButton(onTap: (){
              toastMessage(message: 'Please wait few minutes.we are coming with the product');
              notificationController.getCallPick();
              callNumber();

            },title: 'Call For Pickup',),
          );
        }
      ),
      body: GetBuilder<OrderHistoryController>(builder: (controller) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///<====================== order num & status ======================>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Order No : #${data.orderId ?? ""}',
                        fontSize: 16.h,
                        fontWeight: FontWeight.w500,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                            color: AppColors.blueLightactiveBleu3,
                            borderRadius: BorderRadius.circular(8)),
                        child: CustomText(text: data.status ?? ""),
                      )
                    ],
                  ),

                  ///<======================  Date ======================>
                  CustomText(
                    text: 'date : ${ DateFormat.yMMMd().format(data.deliveryDate!)}',
                    top: 4.h,
                    bottom: 4.h,
                  ),

                  ///<======================  Date ======================>
                  CustomText(
                    text: 'Address : ${data.user.address ?? ""}',
                    top: 4.h,
                  ),

                  ///<======================  Total Products ======================>
                  CustomText(
                    text: 'Total Products : ${data.totalItem ?? 0}',
                    top: 4.h,
                    bottom: 4.h,
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: AppColors.whiteDarkWhite7,
              ),

              ///<============================= products ==============================>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: AppStrings.products,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.whiteDarkactiveWhite9,
                      ),
                      IconButton(
                          onPressed: () {
                            controller.expendInfo = !controller.expendInfo;
                            controller.update();
                          },
                          icon: controller.expendInfo == true
                              ? SvgPicture.asset(AppIcons.expandBottom)
                              : SvgPicture.asset(
                                  AppIcons.expandRight,
                                  color: Colors.black,
                                )),
                    ],
                  ),
                  if (controller.expendInfo == true)
                    Column(
                      children: List.generate(
                          data.cart?.products.length,
                          (index) => Container(
                                margin: EdgeInsets.only(bottom: 10.h),

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.whiteNormalWhite4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ///====================== Product Image ======================

                                    // CustomImage(
                                    //   size: 80.r,
                                    //   imageSrc: AppImages.f1,
                                    //   imageType: ImageType.png,
                                    // ),
                                    CustomNetworkImage(
                                      borderRadius: BorderRadius.circular(8.sp),
                                        imageUrl:
                                            '${ApiConstant.baseUrl}${data.cart?.products?[index].product?.productImage[0] ?? ""}',
                                        height: 80.h,
                                        width: 80.w),

                                    SizedBox(
                                      width: 10.w,
                                    ),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ///====================== Product Name ======================

                                              CustomText(
                                                text: data
                                                        .cart
                                                        !.products![index]
                                                        .product
                                                        !.productName.toString(),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.w,
                                                bottom: 4.h,
                                              ),
                                                CustomText(text:'${data.cart?.products?[index].product?.weight ?? ""}/${data.cart?.products?[index].quantity ?? 0}pcs'),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///================== Product Price ==================

                                    CustomText(
                                      text:
                                          '\$${data.cart?.products?[index].product?.price ?? 0}',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.w,
                                      right: 20.w,
                                      color: AppColors.whiteDarkactiveWhite9,
                                    ),
                                  ],
                                ),
                              )),
                    ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: AppColors.whiteDarkWhite7,
              ),

              ///<============================= price ==============================>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: AppStrings.price,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.whiteDarkactiveWhite9,
                      ),
                      IconButton(
                          onPressed: () {
                            controller.expandPrice = !controller.expandPrice;
                            controller.update();
                          },
                          icon: controller.expandPrice == true
                              ? SvgPicture.asset(AppIcons.expandBottom)
                              : SvgPicture.asset(
                                  AppIcons.expandRight,
                                  color: Colors.black,
                                )),
                    ],
                  ),
                  if (controller.expandPrice == true)
                    Column(
                      children: [
                        ///<===================== paymentOption =======================>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(text: AppStrings.paymentOption),
                            CustomText(text: data.paymentMethod ?? "")
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///<===================== sub total =======================>
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(text: AppStrings.subTotal),
                            CustomText(text: '\$${subTotal()}')
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///<===================== deliveryFee =======================>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(text: AppStrings.deliveryFee),
                            CustomText(text: '\$${data.deliveryFee ?? ""}')
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///<===================== total =======================>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: AppStrings.total,
                              color: AppColors.blueNormalBleu4,
                              fontWeight: FontWeight.w500,
                            ),
                            CustomText(
                              text: '\$${data.price ?? ""}',
                              color: AppColors.blueNormalBleu4,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    )
                ],
              ),
            ],
          ),
        );
      }),
    );

  }

  int subTotal() {
    int subTotal = 0;

    subTotal= data.price - 5;

    return subTotal;
  }
}
