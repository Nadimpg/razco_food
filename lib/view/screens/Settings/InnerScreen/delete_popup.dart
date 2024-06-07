import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class DeletePopU extends StatelessWidget {
    DeletePopU({super.key});
    final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return SizedBox(
          height: 210.h,
          child: Form(
            key: formKey,
            child: Column(

              children: [
                ///<=========================== Title and cross button=======================>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 24.w,
                    ),
                    const CustomText(
                      text: AppStrings.deleteAccount,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 24.r,
                        )),
                  ],
                ),

                const CustomText(
                  text: AppStrings.areyouSureYouWant,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextField(
                  textEditingController: controller.passwordController,
                  hintText: 'enter your password',
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
                ),

                SizedBox(
                  height: 24.h,
                ),
                Row(

                  children: [
                    ///<=================================Yes Button===============================>
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.greenNormalGreen4,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: const CustomText(
                            text: AppStrings.cancel,
                            color: AppColors.whiteLightWhite1,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),

                    ///<========================================yes Button===================>
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if(formKey.currentState!.validate()){
                              controller.deleteAccount();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.redDarkRed7,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: const CustomText(
                            text: AppStrings.yes,
                            color: AppColors.whiteLightWhite1,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
