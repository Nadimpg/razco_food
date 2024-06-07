import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/global/controller/general_controller.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigate() async {
    bool? onBoarding = await SharePrefsHelper.getBool(AppConstants.onBoard);

    bool? isRememberMe =
    await SharePrefsHelper.getBool(AppConstants.isRememberMe);

    String? token = await SharePrefsHelper.getString(AppConstants.bearerToken);

    GeneralController generalController = Get.find<GeneralController>();

    Future.delayed(const Duration(seconds: 3), () {
      if (onBoarding == null || false) {
        Get.offAllNamed(AppRoute.onBoarding);
      } else if (isRememberMe == true ) {
        //&& token.isNotEmpty
       // generalController.getUserID();
        Get.offAllNamed(AppRoute.homeScreen);
      } else {
        Get.offNamed(AppRoute.logIn);
      }
    });
  }
  @override
  void initState() {
   /* Future.delayed(const Duration(seconds: 2), () {
      Get.toNamed(AppRoute.onBoarding);
    });*/
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().scaleWidth,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            AppColors.greenNormalGreen4,
            AppColors.greenNormalhoverGreen5,
            AppColors.greenDarkGreen7,
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(60.r),
        child: const CustomImage(
          imageSrc: AppImages.logo,
          imageType: ImageType.png,
        ),
      ),
    );
  }
}
