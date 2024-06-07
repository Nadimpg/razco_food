import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/MyProfile/Controller/profile_controller.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/custom_text_field/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
    EditProfileScreen({super.key});

    List<String>  genderList=[
      "Male", "Female", "Others"
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteLightWhite1,
        centerTitle: true,
        title: const CustomText(
          text: "Edit Profile",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColors.greenNormalGreen4,
        ),
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, ),
                  color: AppColors.whiteLightWhite1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        width: double.maxFinite,
                        margin: EdgeInsets.symmetric(vertical: 20.h),
                        height: 160.h,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            controller.openGallery();
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.r),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                            ),
                            child: controller.proImage == null
                                ? CustomNetworkImage(
                                boxShape: BoxShape.circle,
                                imageUrl:  controller.profileModel.value.data?.profileImage!.startsWith('https') ?? false
                                    ? controller.profileModel.value.data?.profileImage ?? ""
                                    : '${ApiConstant.baseUrl}${controller.profileModel.value.data?.profileImage ?? ""}',
                                // imageUrl: AppImages.user3,
                                height: 80.w,
                                width: 80.w)
                                : Container(
                              height: 80.w,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(controller.proImage!.path),
                                      ), )),
                            ),
                          ),
                        ),
                      ),
                      ///<=============================== User name Section=====================================>
                   /*   CustomText(
                        text: "Cameron Williamson",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        top: 16.h,
                      ),

                      CustomText(
                        text: "deanna.curtis@example.com",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        top: 12.h,
                        bottom: 42.h,
                      ),*/

                      ///<================================ Personal Info section====================================>

                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              width: 1.w, color: AppColors.darkLightDark1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ///<=============================Expend Button==========================>
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  top: 12.h,
                                  text: AppStrings.personalInformation,
                                  color: AppColors.blueNormalBleu4,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  bottom: 20.h,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 24.r,
                                    ))
                              ],
                            ),

                            ///<===================================Input Section=========================>

                            ///<=======================Name Section==================================>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "${AppStrings.name}" " :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  top: 8.h,
                                  bottom: 20.h,
                                ),
                                  CustomTextField(
                                  textEditingController: controller.nameController,
                                  hintText: "Enter Your Name",
                                ),
                              ],
                            ),

                            ///<===================================Phone Number Section=========================>

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "${AppStrings.phoneNumber}" " :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  top: 20.h,
                                  bottom: 8.h,
                                ),
                                  CustomTextField(
                                    textEditingController: controller.phnNumberController,
                                  keyboardType: TextInputType.phone,
                                  hintText: "Enter Your Phone Number",
                                ),
                              ],
                            ),

                            ///<=======================Email Section==================================>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "${AppStrings.email}" " :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  top: 8.h,
                                  bottom: 20.h,
                                ),
                                  CustomTextField(
                                    textEditingController: controller.emailController,
                                  hintText: "Enter Your Email",
                                ),
                              ],
                            ),

                            ///<=======================Gender Section==================================>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "${AppStrings.gander}" " :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  top: 8.h,
                                  bottom: 20.h,
                                ),
                                  CustomTextField(
                                    readOnly: true,
                                    textEditingController: controller.genderController,
                                  hintText: "Select Gender",
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        controller.isGender = !controller.isGender;
                                        controller.update();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: controller.isGender
                                            ?  Icon(Icons.arrow_drop_down_sharp)
                                            : Icon(Icons.arrow_drop_up_outlined) ),
                                      ),
                                    ),

                              ],
                            ),

                            ///<========================= dropdown ============================>
                            controller.isGender
                                ? Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 16.w),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.sp),
                                          bottomRight: Radius.circular(10.sp))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(
                                      genderList.length,
                                          (index) => GestureDetector(
                                        onTap: () {
                                          controller.genderController.text =
                                          genderList[index];
                                          controller.isGender =!controller.isGender ;
                                          controller.update();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: const BoxDecoration(),
                                            child: CustomText(
                                              text: genderList[index],
                                              fontWeight: FontWeight.w500,
                                              bottom: 4.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            )
                                : const SizedBox(),

                            ///<=======================Address Section==================================>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "${AppStrings.address}" " :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  top: 8.h,
                                  bottom: 20.h,
                                ),
                                  CustomTextField(
                                    textEditingController: controller.addressController,
                                  hintText: "Enter Your address",
                                ),
                              ],
                            ),

                            SizedBox(height: 44.h,),

                          controller.profileUpdateLoading? const CustomLoader():  CustomButton(onTap:(){
                                controller.updateProfile();
                              // Get.toNamed(AppRoute.myProfile);
                            },title:AppStrings.saveUpdate,),
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
      ),
    );
  }
}
