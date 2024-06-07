import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/Settings/Controller/settings_controller.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class ChangePassWordScreen extends StatelessWidget {
  ChangePassWordScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: AppStrings.changePassword,
          color: AppColors.greenNormalGreen4,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<SettingsController>(builder: (controller) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.h,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///<==============================Current Pass section====================================>
                    CustomText(
                      text: "Current PassWord",
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
                      textEditingController: controller.currentPassController,
                      hintText: "CurrentPassWord",
                    ),

                    ///<============================= New Pass section====================================>
                    CustomText(
                      text: "New Password",
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
                      hintText: "Enter New PassWord",
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
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),

        bottomNavigationBar:GetBuilder<SettingsController>(
          builder: (controller) {
            return Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                  child: controller.loading?const CustomLoader(): CustomButton(onTap:(){
                         if(formKey.currentState!.validate()){
                            controller.changePassword();
                         }
                  },title:AppStrings.saveUpdate,)

                  );
          }
        ),
    );
  }
}
