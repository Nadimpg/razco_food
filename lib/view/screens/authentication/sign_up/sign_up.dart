import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/authentication/auth_controller/controller.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (controller) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),

                ///<==================================Title text===============================>

                const Center(
                    child: CustomText(
                  text: AppStrings.createAccount,
                  textAlign: TextAlign.center,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///<===================================Name section============================>
                      SizedBox(
                        height: 31.h,
                      ),

                      CustomText(
                        text: AppStrings.fullName,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        bottom: 8.h,
                      ),

                      CustomTextField(
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value.length < 4) {
                            return AppStrings.enterAValidName;
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        textEditingController: controller.fullNameSignUp,
                        hintText: AppStrings.fullName,

                      ),

                      ///<===========================Email section======================================>

                      CustomText(
                        text: AppStrings.email,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        bottom: 8.h,
                        top: 8.h,
                      ),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.pleaseEnterYourEmailAddresss;
                          } else if (!AppStrings.emailRegexp
                              .hasMatch(controller.emailSignUp.text)) {
                            return AppStrings.enterValidEmail;
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        textEditingController: controller.emailSignUp,
                        hintText: AppStrings.email,
                      ),

                      ///<=================================phone number section=============================>
                      CustomText(
                        text: AppStrings.phoneNumber,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        bottom: 8.h,
                        top: 8.h,
                      ),

                      CustomTextField(
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value.length < 4) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                        textEditingController: controller.phoneSignUp,
                        textInputAction: TextInputAction.next,
                        hintText: AppStrings.phoneNumber,
                      ),

                      ///<=================================== address ============================>

                      ///<==============================Password section====================================>
                      CustomText(
                        text: AppStrings.password,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        bottom: 8.h,
                        top: 8.h,
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
                        textEditingController: controller.passSignUp,
                        isPassword: true,
                        hintText: AppStrings.password,
                      ),

                      ///<==========================Confirm password========================================>
                      CustomText(
                        text: AppStrings.confirmPassword,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        bottom: 8.h,
                        top: 8.h,
                      ),

                      CustomTextField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value != controller.passSignUp.text) {
                            return "Password should match";
                          }
                          return null;
                        },
                        textEditingController: controller.confirmPassSignup,
                        textInputAction: TextInputAction.done,
                        isPassword: true,
                        hintText: AppStrings.confirmPassword,
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                    controller.signUpLoading? const CustomLoader() :  CustomButton(
                        onTap: () {
                           if (formKey.currentState!.validate()) {
                                controller.signUpUser();
                           }
                        },
                        title: AppStrings.signUp,
                      ),
                    ],
                  ),
                ),

                ///<==============================================Sign Up Button==========================================>



                SizedBox(
                  height: 32.h,
                ),

                ///<=================================Terms and Condition, Privacy Policy======================================>

                RichText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            "By clicking sign up you certify that you agree to our ",
                        style: TextStyle(
                            color: AppColors.darkNormalactiveDark6,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.sp),
                      ),
                      TextSpan(
                        text: AppStrings.privacyPolicy,
                        style: TextStyle(
                            color: AppColors.darkDarkerDark10,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Get.toNamed(AppRoute.termsOfServicesSCreen);
                          },
                      ),
                      TextSpan(
                        text: " and ",
                        style: TextStyle(
                            color: AppColors.darkDarkerDark10,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp),
                      ),
                      TextSpan(
                        text: AppStrings.terms,
                        style: TextStyle(
                            color: AppColors.darkDarkerDark10,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //Get.toNamed(AppRoute.privacyPolicyScreen);
                          },
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 16.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: AppStrings.alreadyHaveAnAccount,

                      /// <==============================Sign in text==============================>
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.toNamed(AppRoute.signInScreen);
                        navigator!.pop();
                      },
                      child: CustomText(
                        text: AppStrings.logIn,
                        fontSize: 12.h,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 18.h,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
