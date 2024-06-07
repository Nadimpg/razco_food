import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/global/controller/general_controller.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/Settings/Controller/settings_controller.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/expanded_animation/expanded_animation.dart';

class FAQ extends StatelessWidget {
  FAQ({super.key});
  final SettingsController settingsController = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: AppStrings.fAQ,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.greenNormalGreen4,
        ),
      ),
      body: Obx(() {
        switch (settingsController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: () {
              settingsController.getFaq();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                settingsController.getFaq();
              },
            );
          case Status.completed:
            var data = settingsController.faqList;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                children: List.generate(data.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CustomImage(
                              imageSrc: AppIcons.faq,
                            ),
                            SizedBox(width: 12.w,),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: CustomText(
                                      text: data[index].question ?? "",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.h,
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (settingsController.selectedFqw.value ==
                                            index) {
                                          settingsController.selectedFqw.value =
                                              100000;
                                        } else {
                                          settingsController.selectedFqw.value =
                                              index;
                                        }
                                  
                                        settingsController.selectedFqw.refresh();
                                      },
                                      icon: settingsController.selectedFqw.value ==
                                              index
                                          ? const Icon(
                                              Icons.keyboard_arrow_down_rounded)
                                          : const Icon(
                                              Icons.keyboard_arrow_right_rounded)),
                                ],
                              ),
                            )
                          ],
                        ),
                        index == settingsController.selectedFqw.value
                            ? CustomExpandedSection(
                                expand: index ==
                                        settingsController.selectedFqw.value
                                    ? true
                                    : false,
                                child: Container(
                                  padding: EdgeInsets.all(8.r),


                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                          color: AppColors.whiteNormalWhite4)),
                                  child: CustomText(
                                    textAlign: TextAlign.start,
                                    text: data[index].answer ?? "",
                                    fontSize: 14.h,
                                    maxLines: 6,
                                  ),
                                ))
                            : const SizedBox()
                      ],
                    ),
                  );
                }),
              ),
            );
        }
      }),
    );
  }
}
