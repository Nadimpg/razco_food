import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/global/controller/general_controller.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final GeneralController controller = Get.find<GeneralController>();

  @override
  void initState() {
    SharePrefsHelper.setBool(AppConstants.onBoard, false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              ///===============================Step Count================================

              Expanded(
                child: Row(
                  children: List.generate(
                      controller.onBoardingImage.length,
                      (index) => Expanded(
                            child: Container(
                              height: 4.h,
                              color: controller.currentOnboarding.value == index
                                  ? AppColors.greenNormalGreen4
                                  : AppColors.whiteNormalactiveWhite6,
                            ),
                          )),
                ),
              ),

              const Expanded(child: SizedBox()),

              ///===============================Image================================

              Expanded(
                flex: 2,
                child: PageView.builder(
                  onPageChanged: (value) {
                    controller.currentOnboarding.value = value;
                    controller.currentOnboarding.refresh();
                  },
                  itemCount: controller.onBoardingImage.length,
                  itemBuilder: (context, index) {
                    return CustomImage(
                      imageSrc: controller.onBoardingImage[index],
                      imageType: ImageType.png,
                    );
                  },
                ),
              ),

              const Expanded(child: SizedBox()),

              ///===============================Button================================

              CustomButton(
                onTap: () {
                  Get.offAllNamed(AppRoute.logIn);
                },
                marginVerticel: 24.h,
              )
            ],
          ),
        );
      }),
    );
  }
}
