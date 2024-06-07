import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/payment/payment_controller.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class EditAddress extends StatelessWidget {
  EditAddress({super.key});
  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: AppStrings.editAddress,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.greenNormalGreen4,
        ),
      ),
      body: GetBuilder<PaymentController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                      key: fromKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///<======================================== Name Section =========================================================>

                          CustomText(
                            text: AppStrings.name,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            bottom: 8.h,
                            top: 8.h,
                          ),
                          CustomTextField(
                            textEditingController: controller.nameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppStrings.fieldCantBeEmpty;
                              }else {
                                return null;
                              }
                            },
                            hintText: AppStrings.name,
                          ),
                          const SizedBox(
                            height: 12,
                          ),

                          ///<======================================== Contact Info Section =========================================================>

                          CustomText(
                            text: AppStrings.contactNo,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            bottom: 8.h,
                            top: 8.h,
                          ),
                          CustomTextField(
                            textEditingController: controller.contactController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppStrings.fieldCantBeEmpty;
                              } else if (value.length < 11) {
                                return AppStrings.enterValidNum;
                              }   else {
                                return null;
                              }
                            },
                            hintText: AppStrings.contactNo,
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          ///<======================================== Delivary Address Section =========================================================>

                          CustomText(
                            text: AppStrings.deliveryAddress,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            bottom: 8.h,
                            top: 8.h,
                          ),
                          CustomTextField(
                            textEditingController: controller.addressController,
                            maxLines: 5,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppStrings.fieldCantBeEmpty;
                              }   else {
                                return null;
                              }
                            },
                            hintText: AppStrings.deliveryAddress,
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      )),

                  ///<==============================================Send Otp button===============================================>
                controller.loading? const CustomLoader():  CustomButton(
                    onTap: () {
                       if(fromKey.currentState!.validate()){
                         controller.editAddress(
                           name: controller.nameController.text,
                           phone: controller.contactController.text,
                           address: controller.addressController.text
                         );
                       }
                       print("name -------------- ${controller.nameController.text}");
                       print("name -------------- ${controller.contactController.text}");
                       print("name -------------- ${controller.addressController.text}");
                    },
                    title: AppStrings.confirm,
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
