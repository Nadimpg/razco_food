import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/authentication/sign_in/sign_in.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/screens/scan_history_list/scan_history_list.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:url_launcher/url_launcher.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  //Uri dialNumber = Uri(scheme: 'tel', path: '');

  var status;
  getStatus() async {
    status = await SharePrefsHelper.getBool(AppConstants.guestUser);
  }

  @override
  void initState() {
    getStatus();
    super.initState();
  }


/*  Uri dialNumber=Uri(scheme: 'tel' , path: '01923647795');
  callNumber()async{
    await launchUrl(dialNumber);
  }*/



  Widget customRow(
          {required String image,
          required String title,
          required VoidCallback onTap}) =>
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 18.h),
          child: Row(
            children: [
              CustomImage(
                size: 18.r,
                imageColor: AppColors.whiteDarkactiveWhite9,
                imageSrc: image,
              ),
              CustomText(
                color: AppColors.whiteDarkactiveWhite9,
                left: 16.w,
                text: title,
                fontSize: 14.w,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r)),
          color: AppColors.whiteLightWhite1,
        ),
        height: double.maxFinite,
        width: MediaQuery.of(context).size.width / 1.3,
        child: Padding(
          padding: EdgeInsets.only(top: 0.h),
          child: Column(
            children: [
              ///================================ APP LOGO ==============================///
              Container(
                padding: EdgeInsets.all(10.r),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.r),
                  ),
                  color: AppColors.greenNormalGreen4,
                ),
                height: 60.h,
                width: double.maxFinite,
                child: const CustomImage(
                  imageSrc: AppImages.logo2,
                  imageType: ImageType.png,
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                    child: Column(
                      children: [
                        ///================== My Profile ================>
                        customRow(
                            image: AppIcons.user,
                            onTap: () {

                              if(status==true && status!=null){
                                Get.toNamed(AppRoute.logIn);
                                SharePrefsHelper.remove(
                                    AppConstants
                                        .guestUser);
                              } else{
                                Get.toNamed(AppRoute.myProfile);
                              }

                              },
                            title: AppStrings.myProfile),

                        ///================== Settings ================

                        customRow(
                            image: AppIcons.settingGrey,
                            onTap: () {
                              if(status==true && status!=null){
                                Get.toNamed(AppRoute.logIn);
                                SharePrefsHelper.remove(
                                    AppConstants
                                        .guestUser);
                              } else{
                                Get.toNamed(AppRoute.settingsScreen);
                              }

                              },
                            title: AppStrings.settings),

                        ///================== FeedBack ================

                        customRow(
                            image: AppIcons.feedbackGrey,
                            onTap: () {
                              if(status==true && status!=null){
                                Get.toNamed(AppRoute.logIn);
                                SharePrefsHelper.remove(
                                    AppConstants
                                        .guestUser);
                              } else{
                                Get.toNamed(AppRoute.feedBackScreen);
                              }

                              },
                            title: AppStrings.feedback),

                        const Divider(
                          color: AppColors.whiteNormalhoverWhite5,
                        ),

                        SizedBox(height: 8.h,),
/*
                        ///================================= Call For Pickup ===============================
                        GestureDetector(
                          onTap: (){
                            callNumber();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.call,size: 20,color: AppColors.whiteDarkactiveWhite9,),
                              CustomText(text: 'Call For Pickup',fontSize: 14.h,fontWeight: FontWeight.w500,color: AppColors.whiteDarkactiveWhite9,left: 14,)
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h,),*/

                        ///================== my card ================
                     /*   customRow(
                            image: AppIcons.scanUnselected,
                            onTap: () {
                              Get.toNamed(AppRoute.myCart);
                            },
                            title: 'My Cards'),*/

                          GestureDetector(
                            onTap: (){
                              if(status==true && status!=null){
                                Get.toNamed(AppRoute.logIn);
                                SharePrefsHelper.remove(
                                    AppConstants
                                        .guestUser);
                              } else{
                                Get.toNamed(AppRoute.myCart);
                              }

                            },
                            child: Row(
                              children: [
                                Icon(Icons.shopping_cart,size: 20,color: AppColors.whiteDarkactiveWhite9,),
                                CustomText(text: 'My Cart',fontSize: 14.h,fontWeight: FontWeight.w500,color: AppColors.whiteDarkactiveWhite9,left: 16,)
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 12.h,
                        ),
                        ///================== Scan History ================
                        customRow(
                            image: AppIcons.scanUnselected,
                            onTap: () {
                              if(status==true && status!=null){
                                Get.toNamed(AppRoute.logIn);
                                SharePrefsHelper.remove(
                                    AppConstants
                                        .guestUser);
                              } else{
                                 Get.toNamed(AppRoute.scanHistoryList);
                              }
                            },
                            title: AppStrings.scanHistory),

                        ///================== Order History ================

                        customRow(
                            image: AppIcons.history,
                            onTap: () {
                              if(status==true && status!=null){
                                Get.toNamed(AppRoute.logIn);
                                SharePrefsHelper.remove(
                                    AppConstants
                                        .guestUser);
                              } else{
                                Get.toNamed(AppRoute.orderHistoryScreen);
                              }
                            },
                            title: AppStrings.orderHistory),

                        ///================== my points ================

                        customRow(
                            image: AppIcons.coins,
                            onTap: () {
                              if(status==true && status!=null){
                                Get.toNamed(AppRoute.logIn);
                                SharePrefsHelper.remove(
                                    AppConstants
                                        .guestUser);
                              } else{
                                Get.toNamed(AppRoute.myPointsScreen);
                              }
                            },
                            title: AppStrings.myPoints),

                        const Divider(
                          color: AppColors.whiteNormalhoverWhite5,
                        ),

                        SizedBox(
                          height: 18.h,
                        ),

                        ///================== About Razco ================
                        customRow(
                            image: AppIcons.aboutGrey,
                            onTap: () {
                              Get.toNamed(AppRoute.aboutUs);
                            },
                            title: AppStrings.aboutRazco),

                        ///================== FAQ ================

                        customRow(
                            image: AppIcons.faq,
                            onTap: () {
                              Get.toNamed(AppRoute.faq);
                            },
                            title: AppStrings.fAQ),

                        ///================== Privacy Policy ================

                        customRow(
                            image: AppIcons.coin2Grey,
                            onTap: () {
                              Get.toNamed(AppRoute.privacyPolicy);
                            },
                            title: AppStrings.privacyPolicy),

                        ///================== Terms Of Use ================

                        customRow(
                            image: AppIcons.bookMarkGrey,
                            onTap: () {
                              Get.toNamed(AppRoute.termsCondition);
                            },
                            title: AppStrings.termsofuse),

                        const Divider(
                          color: AppColors.whiteNormalhoverWhite5,
                        ),
                        SizedBox(
                          height: 18.h,
                        ),

                        ///================== Log Out ================

                        customRow(
                            image: AppIcons.logoutGrey,
                            onTap: () {
                              SharePrefsHelper.remove(AppConstants.isRememberMe);

                              SharePrefsHelper.remove(
                                  AppConstants
                                      .bearerToken);

                              SharePrefsHelper.remove(
                                  AppConstants
                                      .profileID);

                              SharePrefsHelper.remove(
                                  AppConstants
                                      .guestUser);

                              // HomeController controller =Get.find<HomeController>();
                              // controller.dispose();

                              Get.to(()=>SignInScreen());
                            },
                            title: AppStrings.logOut),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
