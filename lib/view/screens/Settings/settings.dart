import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/Settings/InnerScreen/delete_popup.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteLightWhite1,
        centerTitle: true,
        title: const CustomText(
          text: AppStrings.settings,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.greenNormalGreen4,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: AppColors.whiteLightWhite1,
              child: Column(
                children: [
                  ///<============================== Change Pass Section=======================>
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.changePassScreen);
                    },
                    child: ListTile(
                      leading: SvgPicture.asset(
                        AppIcons.lockgrey,
                        height: 16.h,
                        width: 16.w,
                      ),
                      title: const CustomText(
                        text: AppStrings.changePassword,
                        textAlign: TextAlign.start,
                        color: AppColors.whiteDarkactiveWhite9,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  ///<============================== Delete Account Section=======================>
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: DeletePopU(),
                          );
                        },
                      );
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: AppColors.whiteDarkactiveWhite9,
                      ),
                      title: CustomText(
                        text: AppStrings.deleteAccount,
                        textAlign: TextAlign.start,
                        color: AppColors.whiteDarkactiveWhite9,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
