import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';

import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/authentication/auth_controller/controller.dart';
import 'package:razco_foods/view/screens/authentication/sign_in/sign_in.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class SetpassWordScreen extends StatelessWidget {
  SetpassWordScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///<=================================Title Text=====================================>
                const Center(
                    child: CustomText(
                  text: AppStrings.setNewPassword,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
                const CustomText(
                  text:
                      "Create a new password. Ensure it differs from previous ones for security",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  maxLines: 3,
                  top: 8,
                ),

                SizedBox(
                  height: 56.h,
                ),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///<==============================Password section====================================>
                      CustomText(
                        text: AppStrings.password,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        bottom: 16.h,
                        top: 16.h,
                      ),

                      CustomTextField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value.length < 8 ||
                              !AppStrings.passRegexp.hasMatch(value)) {
                            return AppStrings.passwordLengthAndContain;
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        isPassword: true,
                        textEditingController: controller.newPassController,
                        hintText: AppStrings.password,
                      ),

                      ///<==============================Confirm Password section====================================>
                      CustomText(
                        text: AppStrings.confirmPassword,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        bottom: 16.h,
                        top: 24.h,
                      ),

                      CustomTextField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (controller.newPassController.text !=
                              controller.confirmPassController.text) {
                            return "Password should be match";
                          }
                          return null;
                        },
                        textEditingController: controller.confirmPassController,
                        textInputAction: TextInputAction.done,
                        isPassword: true,
                        hintText: AppStrings.confirmPassword,
                      ),

                      SizedBox(
                        height: 23.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<AuthController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            child:
                ///<============================================Upadte Button===============================================>
                CustomButton(
              onTap: () {
                 if (formKey.currentState!.validate()) {
                       controller.handleResetPassword();
                 }

              },
              title: AppStrings.updatePassword,
            ),
          );
        }
      ),
    );
  }
}
