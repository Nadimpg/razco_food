import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                CustomImage(
                  size: 100.r,
                  imageSrc: AppImages.check,
                  imageType: ImageType.png,
                ),
                CustomText(
                  top: 40.h,
                  text: AppStrings.signUpSuccessfully,
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoute.logIn);
              },
            )
          ],
        ),
      ),
    );
  }
}
