import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/MyProfile/Controller/profile_controller.dart';
import 'package:razco_foods/view/screens/payment/payment_controller.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class PaymentScreen extends StatefulWidget {
    PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
    var uuid=Get.arguments[0];
    var subTotal=Get.arguments[1];
    var totalItem=Get.arguments[2];
    var cartId=Get.arguments[3];

    int totalPrice(){
    int  totalPrice= subTotal + 5;
      return totalPrice;
    }

    double point(){
      double totalPriceValue = totalPrice().toDouble(); // Convert int to double
      double point = totalPriceValue / 100; // Assign double value directly
      return point;
    }

    DateTime selectedDate = DateTime.now();
    List<String> payMethod=[
      AppStrings.card,
      AppStrings.cashonDelivery,
    ];

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    ProfileController profileController=Get.find<ProfileController>();
    PaymentController controller=Get.find<PaymentController>();

    @override
  void initState() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          profileController.getProfile();
        });
      });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: AppStrings.payment,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.greenNormalGreen4,
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              ///================================ Order No ===================================

              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: AppColors.greenLighthoverGreen2,
                child:   CustomText(text: "Order No : #$uuid",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.h,

                ),
              ),

              ///================================ Delivary Address ===================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: AppStrings.deliveryAddress,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.w,
                        ),

                        ///======================== Edit Address Button ==========================

                        IconButton(
                          onPressed: () {
                            controller.nameController.text=profileController.profileModel.value.data!.name!;
                            controller.contactController.text=profileController.profileModel.value.data!.phone!;
                            controller.addressController.text=profileController.profileModel.value.data!.address!;
                            Get.toNamed(AppRoute.editAddress);
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.blueNormalBleu4,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const CustomText(
                              text: AppStrings.editAddress,
                              color: AppColors.whiteLightWhite1,
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///======================== Name ==========================

                    CustomText(
                      bottom: 8.h,
                      text: "${AppStrings.name}: ${profileController.profileModel.value.data?.name ?? ""}",
                      fontWeight: FontWeight.w500,
                    ),

                    ///======================== Contact Num ==========================

                    CustomText(
                      bottom: 8.h,
                      text: "${AppStrings.contactNo}: ${profileController.profileModel.value.data?.phone ?? ""}",
                      fontWeight: FontWeight.w500,
                    ),

                    ///======================== Address ==========================

                    CustomText(
                      bottom: 8.h,
                      text: "Address : ${profileController.profileModel.value.data?.address ?? ""}",
                      fontWeight: FontWeight.w500,

                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                bottom: 8,
                                text: AppStrings.deliveryDate,
                              ),

                              ///===================== Delivary Date ======================

                              GestureDetector(
                                onTap: (){
                                  _selectDate(context);
                                  print(
                                      'Select Data=============${selectedDate.toLocal()}');
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColors.darkLightactiveDark3
                                      )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: DateFormat('yMMMd').format(selectedDate.toLocal()),
                                      ),
                                      Icon(Icons.date_range,color: AppColors.darkNormalDark4,size: 18,)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                bottom: 8,
                                text: AppStrings.deliveryTime,
                              ),

                              ///===================== Delivary Time ======================

                              /*   GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(14),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: AppColors.darkLightactiveDark3
                                        )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: DateFormat('yMMMd').format(selectedDate.toLocal()),
                                        ),
                                       const Icon(Icons.timer,color: AppColors.darkNormalDark4,size: 18,)
                                      ],
                                    ),
                                  ),
                                ),*/
                              TimePickerSpinnerPopUp(
                                mode: CupertinoDatePickerMode.time,
                                initTime: DateTime.now(),
                                onChange: (dateTime) {

                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                    CustomText(
                      top: 8.h,
                      bottom: 8.h,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      text: AppStrings.paymentOption,
                    ),
                    ///<=============================== payment option ===============================>

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.blueLightactiveBleu3),
                      child: Column(
                        children: List.generate(payMethod.length, (index){
                          return  ///========================= Card Check Box ======================
                            GestureDetector(
                              onTap: (){
                                controller.selectedIndex.value = index;
                                controller.refresh();
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8.h,top: 8.h),
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.whiteLightWhite1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: payMethod[index],
                                      fontWeight: FontWeight.w500,
                                    ),
                                    GestureDetector(
                                      onTap: (){

                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 14.h,
                                        width: 14.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.blueNormalBleu4
                                            )
                                        ),
                                        child: index== controller.selectedIndex.value ? Icon(Icons.check,size: 12.sp,):SizedBox(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    /// <===============================================Remember button==============================>
                    GestureDetector(
                      onTap: () {
                        controller.isPickup.value = ! controller.isPickup.value;
                        controller.refresh();
                        print(controller.isPickup);
                      },
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 14,
                            width: 14,
                            decoration: BoxDecoration(
                              color: controller.isPickup.value
                                  ? AppColors.blueDarkBleu7
                                  : AppColors.whiteDarkWhite7,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: controller.isPickup.value
                                  ? Icon(
                                Icons.check,
                                color: controller.isPickup.value
                                    ? AppColors.whiteLightWhite1
                                    : AppColors
                                    .darkLighthoverDark2,
                                size: 14,
                              )
                                  : const SizedBox(),
                            ),
                          ),
                          CustomText(
                            left: 8.w,
                            fontWeight: FontWeight.w500,
                            text: 'Request curbside pickup',
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          fontSize: 14,
                          text: AppStrings.subTotal,
                        ),

                        ///=================== Sub Total ======================

                        CustomText(
                          fontSize: 14,
                          text: '\$$subTotal',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          fontSize: 14,
                          text: AppStrings.deliveryFee,
                        ),

                        ///=================== Delivary ======================

                        CustomText(
                          fontSize: 14,
                          text: "\$5.00",
                        ),
                      ],
                    ),

                    const Divider(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          fontSize: 14,
                          text: AppStrings.total,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blueDarkBleu7,
                        ),

                        ///=================== Delivary ======================

                        CustomText(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blueDarkBleu7,
                          text: '\$${totalPrice().toString()}',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),

                    ///============================ Payment Button ========================
                    controller.selectedIndex==0 ?  CustomButton(
                      onTap: () {
                        controller.makePayment(amount: totalPrice(), totalItem: totalItem, points: point().toInt(), deliveryFee: 5, orderId: uuid, cartId: cartId, deliveryDate: selectedDate.toString(), isPickedUp: controller.isPickup.value);
                      },
                      title: 'Pay with stripe',
                    ):CustomButton(
                      onTap: () {
                        controller.cashOrder(orderId: uuid, totalItem: totalItem, price: totalPrice(), deliveryDate: selectedDate.toString(), deliveryFee: 5, cart: cartId, points: point().toInt(), paymentMethod: 'cashOnDelivery', isPick: controller.isPickup.value);
                      },
                      title: AppStrings.confirm,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
