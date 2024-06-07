import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/screens/notification/notification_controller.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class NotificationScreen extends StatelessWidget {
    NotificationScreen({super.key});

    NotificationController controller=Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.notification,
          color: AppColors.greenNormalGreen4,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body:Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: (){
              controller.getNotification();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getNotification();
              },
            );
          case Status.completed:
            return controller.notificationList.isEmpty ? const Center(
              child: CustomText(text: 'Empty',fontWeight: FontWeight.w500,),
            ):  ListView.builder(
              controller: controller.scrollController,
              padding: EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
              itemCount: controller.notificationList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10.r),
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color:controller.notificationList[index].read! ? AppColors.whiteNormalWhite4: null,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///============================Icon=============================///

                      Container(
                        margin: EdgeInsets.only(right: 8.w),

                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greenLightactiveGreen3),
                        child: const CustomImage(
                          imageSrc: AppIcons.offerUnselected,
                          imageColor: AppColors.blueDarkBleu7,
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ///============================Title=============================///
                              CustomText(
                                textAlign: TextAlign.start,
                              maxLines: 4,
                              text: controller.notificationList[index].message ?? "",
                              fontWeight: FontWeight.w400,
                                fontSize: 14,
                                bottom: 10,
                            ),

                            ///============================Description=============================///

                            // CustomText(
                            //     top: 4.h,
                            //     bottom: 4.h,
                            //     textAlign: TextAlign.left,
                            //     maxLines: 2,
                            //     fontSize: 10,
                            //     text:
                            //     "Congrats! your offer has beenaccepted by the seller for 170,000"),

                            ///============================Time=============================///

                              CustomText(
                              fontSize: 12,

                              text:DateFormat('yMMMd').format(controller.notificationList[index].createdAt!.toLocal()),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ) ;
        }
      }) ,
    );
  }
}
