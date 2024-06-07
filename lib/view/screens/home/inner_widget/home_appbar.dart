import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/date_converter.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/notification/notification_controller.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class HomeAppBar extends StatefulWidget {
  HomeAppBar({
    super.key,
    required this.scaffoldKey,
    required this.myProfile,
    required this.name,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget myProfile;
  final String name;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  NotificationController controller = Get.find<NotificationController>();

  var status;
  getStatus()async{
    status= await SharePrefsHelper.getBool(AppConstants.guestUser);
  }

  @override
  void initState() {
    getStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 44.h,
      ),
      child: Column(
        children: [
          ///====================================Top Section================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ///==================== Profile =====================
                  // CustomImage(
                  //   imageSrc: image,
                  //   imageType: ImageType.png,
                  //   size: 60.w,
                  // ),

                  widget.myProfile,

                  SizedBox(
                    width: 16.w,
                  ),

                  ///========================== location =====================
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: DateConverter.getTimePeriod()),
                      CustomText(
                        text: widget.name,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  ///<==================== notification ====================>
                  /*IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.notification);
                      },
                      icon: const Icon(Icons.notifications)),*/
                  IconButton(
                      onPressed: () {

                        if(status==true && status!=null){
                          Get.toNamed(AppRoute.logIn);
                          SharePrefsHelper.remove(
                              AppConstants
                                  .guestUser);
                        } else{
                          controller.readNotification();
                          controller.notificationCount.refresh();
                        }

                      },
                      icon: Stack(
                        children: [
                          const Icon(
                            Icons.notifications_none,
                            size: 26,
                          ),
                          Positioned(
                            top: -4,
                            right: -2,
                            child: Container(

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:   controller.unReadNotification ==
                                    0
                                    ? null
                                    :
                                AppColors.greenNormalGreen4,
                              ),
                              // height: 8,
                              // width: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CustomText(
                                  text:controller.unReadNotification  ==
                                      0? '' : controller.unReadNotification.toString()  ,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),

                  ///<==================== Menu Bar ====================>
                  IconButton(
                      onPressed: () {
                        widget.scaffoldKey.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu))
                ],
              )
            ],
          ),

          //====================================Search Section================================

          SizedBox(
            height: 8.h,
          ),
          Row(children: [
            ///================Search Text Form Field==============

            Expanded(
                child: CustomTextField(
                  onTapClick: () {
                    Get.toNamed(AppRoute.searchScreen);
                  },
                  readOnly: true,
                  hintText: AppStrings.searchProduct,
                  isPrefixIcon: true,
                )),
            SizedBox(
              width: 12.w,
            ),

            ///================Filter Button==============///
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.filterScreen);
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.greenNormalGreen4,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.filterScreen);
                    },
                    icon: const Icon(
                      Icons.filter_alt_sharp,
                      color: AppColors.whiteLightWhite1,
                    )),
              ),
            )
          ])
        ],
      ),
    );
  }
}
