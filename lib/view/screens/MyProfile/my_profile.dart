import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/MyProfile/Controller/profile_controller.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  ProfileController controller = Get.find<ProfileController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getProfile();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteLightWhite1,
        centerTitle: true,
        title: const CustomText(
          text: AppStrings.myProfile,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColors.greenNormalGreen4,
        ),
        actions: [
          IconButton(
              onPressed: () {
                controller.updateProfileControllerValue(
                    controller.profileModel.value);
              },
              icon: SvgPicture.asset(AppIcons.edit)),
        ],
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(onTap: (){
              controller.getProfile();
            });
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getProfile();
              },
            );
          case Status.completed:
            var data=controller.profileModel.value.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    color: AppColors.whiteLightWhite1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 90.h,
                          width: 90.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CustomNetworkImage(
                              borderRadius: BorderRadius.circular(100.r),
                              imageUrl:  data?.profileImage!.startsWith('https') ?? false
                                  ? data?.profileImage ?? ""
                                  : '${ApiConstant.baseUrl}${data?.profileImage ?? ""}',
                              height: 85.h,
                              width: 85.w),
                        ),

                        ///<=============================== User name Section=====================================>
                        CustomText(
                          text: controller.profileModel.value.data!.name ?? "",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          top: 16.h,
                        ),

                        CustomText(
                          text: data?.email ?? "",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          top: 12.h,
                          bottom: 42.h,
                        ),

                        ///<================================ Personal Info section====================================>

                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                                width: 1.w, color: AppColors.darkLightDark1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  CustomText(
                                    text: AppStrings.personalInformation,
                                    color: AppColors.blueNormalBleu4,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    bottom: 20.h,
                                  ),
                                  const SizedBox(),
                                ],
                              ),

                              ///<==================================Name Section============================================>
                              CustomText(
                                text: "${AppStrings.name}" " :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteDarkerWhite10,
                                bottom: 8.h,
                              ),
                              CustomText(
                                text: data?.name ?? "",
                                maxLines: 2,
                                color: AppColors.whiteDarkhoverWhite8,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                bottom: 20.h,
                              ),

                              ///<==================================Phone Number  Section============================================>
                              CustomText(
                                text: "${AppStrings.phoneNumber}" " :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteDarkerWhite10,
                                bottom: 8.h,
                              ),
                              CustomText(
                                text: data?.phone ?? "",
                                maxLines: 2,
                                color: AppColors.whiteDarkhoverWhite8,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                bottom: 20.h,
                              ),

                              ///<================================== Email Section============================================>
                              CustomText(
                                text: "${AppStrings.email}" " :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteDarkerWhite10,
                                bottom: 8.h,
                              ),
                              CustomText(
                                text: data?.email ?? "",
                                maxLines: 2,
                                color: AppColors.whiteDarkhoverWhite8,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                bottom: 20.h,
                              ),

                              ///<=================================Gender Section============================================>
                              CustomText(
                                text: "${AppStrings.gander}" " :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteDarkerWhite10,
                                bottom: 8.h,
                              ),
                              CustomText(
                                text: data?.gender ?? "",
                                maxLines: 2,
                                color: AppColors.whiteDarkhoverWhite8,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                bottom: 20.h,
                              ),

                              ///<==================================Address  Section============================================>
                              CustomText(
                                text: "${AppStrings.address}" " :",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteDarkerWhite10,
                                bottom: 8.h,
                              ),
                              CustomText(
                                text: data?.address ?? "",
                                maxLines: 2,
                                color: AppColors.whiteDarkhoverWhite8,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                bottom: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
