import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:get/get.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/Settings/Controller/settings_controller.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class AboutUs extends StatefulWidget {
    AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
    SettingsController controller=Get.find<SettingsController>();

    @override
  void initState() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.getAbout();
      });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: AppStrings.aboutRazco,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.greenNormalGreen4,
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: (){
              controller.getAbout();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getAbout();
              },
            );

          case Status.completed:
           // return Center();
             return controller.aboutData.content!.isEmpty ? Center(child: CustomText(text: 'Empty',),): SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              physics: const BouncingScrollPhysics(),
              child: HtmlWidget(controller.aboutData.content.toString())
            );
        }
      }),
    );
  }
}
