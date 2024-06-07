import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/authentication/auth_controller/controller.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AuthController>(builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 45.h,
                  ),
                  const Center(
                      child: CustomText(
                    text: AppStrings.welcomeBack,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    bottom: 20,
                  )),

                  const CustomText(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                    maxLines: 3,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///<=======================================Email section======================================>
                          SizedBox(
                            height: 40.h,
                          ),

                          CustomText(
                            text: AppStrings.email,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            bottom: 8.h,
                          ),

                          CustomTextField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.fieldCantBeEmpty;
                              } else if (!AppStrings.emailRegexp
                                  .hasMatch(controller.signInEmail.text)) {
                                return AppStrings.enterValidEmail;
                              } else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.next,
                            textEditingController: controller.signInEmail,
                            hintText: AppStrings.email,
                          ),

                          ///<=======================================Password section======================================>
                          CustomText(
                            text: AppStrings.password,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            top: 16.h,
                            bottom: 8.h,
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
                            textEditingController: controller.passWordSignIn,
                            textInputAction: TextInputAction.done,
                            isPassword: true,
                            hintText: AppStrings.password,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// <===============================================Remember button==============================>
                              GestureDetector(
                                onTap: () {
                                controller.  isRemember = ! controller.isRemember;
                                controller.update();
                                  SharePrefsHelper.setBool(AppConstants.isRememberMe, controller.isRemember);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                        color: controller.isRemember
                                            ? AppColors.blueDarkBleu7
                                            : AppColors.whiteDarkWhite7,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: controller.isRemember
                                            ? Icon(
                                                Icons.check,
                                                color: controller.isRemember
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
                                      fontWeight: FontWeight.w400,
                                      text: AppStrings.rememberme,
                                    ),
                                  ],
                                ),
                              ),

                              /// <===============================================Forgot Password  Button============================>

                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.forgotPass);
                                },
                                child: const CustomText(
                                  text: AppStrings.forgotPasswordQue,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 45.h,
                          ),
                        ],
                      )),

                  ///<======================================Login Button=========================================>
                 controller.signInLoading? const CustomLoader(): CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                         controller.signInUser();
                      }
                    },
                    title: AppStrings.login,
                  ),

                  SizedBox(
                    height: 24.h,
                  ),
                  ///<====================== guest button =======================>
                  CustomButton(
                    onTap: () async {
                       Get.toNamed(AppRoute.homeScreen);
                     SharePrefsHelper.setBool(AppConstants.guestUser, true);
                    },
                    title: AppStrings.guestLogin,
                    backgroundColor: AppColors.whiteDarkhoverWhite8,
                  ),
                  SizedBox(
                    height: 52.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: AppStrings.youDontHaveAnAccount,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),

                      /// <============================== Sign Up ==============================>
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.signUp);
                        },
                        child: CustomText(
                          text: AppStrings.signUp,
                          fontSize: 12.h,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
