import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';

import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/authentication/auth_controller/controller.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class ForgotPassWord extends StatelessWidget {
  ForgotPassWord({super.key});

  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 44.h),
              child: Form(
                key: fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///<========================================Title text=========================================================>

                    Column(
                      children: [
                        const Center(
                            child: CustomText(
                          text: AppStrings.forgotPassWord,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                        CustomText(
                          text:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                          maxLines: 3,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          top: 8.h,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 77.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///<========================================Email Section=========================================================>
                        CustomText(
                          text: AppStrings.email,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          bottom: 8.h,
                          top: 8.h,
                        ),
                        CustomTextField(
                          textEditingController: controller.forgotPassEmailController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppStrings.fieldCantBeEmpty;
                            } else if (value.length < 8) {
                              return AppStrings.enterValidEmail;
                            } else if (!AppStrings.emailRegexp.hasMatch(value)) {
                              return AppStrings.enterValidEmail;
                            } else {
                              return null;
                            }
                          },
                          hintText: AppStrings.email,
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(height: 76.h),

                        ///<==============================================Send Otp button===============================================>
                        CustomButton(
                          onTap: () {
                            if(fromKey.currentState!.validate()){
                              controller.handleForgetPassword();
                            }

                          },
                          title: AppStrings.sendACode,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  
  
  }
}
