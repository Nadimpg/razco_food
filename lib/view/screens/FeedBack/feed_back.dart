import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/Settings/Controller/settings_controller.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class FeedBackScreen extends StatelessWidget {
    FeedBackScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteLightWhite1,
          centerTitle: true,
          title: const CustomText(
            text: AppStrings.feedback,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.greenNormalGreen4,
          ),
        ),
        body: GetBuilder<SettingsController>(
          builder: (controller) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),

                    ///<==========================Name Section=====================>
                    CustomText(
                      text: "${AppStrings.name}" " :",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      top: 12.h,
                      bottom: 12.h,
                    ),

                      CustomTextField(
                        textEditingController: controller.nameFeedback,
                      hintText: "Enter Your Name",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else {
                            return null;
                          }
                        },
                    ),

                    ///<==========================Description Section=====================>
                    CustomText(
                      text: "${Feedback}" " :",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      top: 20.h,
                      bottom: 12.h,
                    ),

                      CustomTextField(
                        textEditingController: controller.descriptionFeedback,
                      maxLines: 5,
                      hintText: "Enter Your description",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else {
                            return null;
                          }
                        },
                    ),

                    SizedBox(
                      height: 40.h,
                    ),
                  controller.loading? const CustomLoader():  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ///<=========================== Cancel Button ==========================>
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 16.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      width: 1.w,
                                      color: AppColors.greenNormalGreen4)),
                              child: const CustomText(
                                text: AppStrings.cancel,
                                color: AppColors.greenNormalGreen4,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 16.w,
                        ),

                        ///<============================== Submit button =======================>
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if(formKey.currentState!.validate()){
                                controller.feedback();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 16.h),
                              decoration: BoxDecoration(
                                  color: AppColors.greenNormalGreen4,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      width: 1.w,
                                      color: AppColors.greenNormalGreen4)),
                              child: const CustomText(
                                text: AppStrings.submit,
                                color: AppColors.whiteLightWhite1,
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
        ));
  }
}
