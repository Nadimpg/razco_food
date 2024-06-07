import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/global/const/const.dart';
import 'package:razco_foods/helper/general_error.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/MyProfile/Controller/profile_controller.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/screens/home/inner_widget/home_appbar.dart';
import 'package:razco_foods/view/screens/home/inner_widget/side_drawer.dart';
import 'package:razco_foods/view/screens/no_internet/no_internet.dart';
import 'package:razco_foods/view/screens/sub_category_screen/sub_category_screen.dart';
import 'package:razco_foods/view/widgets/custom_category/custom_category.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/nav_bar/nav_bar.dart';
import 'package:razco_foods/view/widgets/product_card/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileController profileController = Get.find<ProfileController>();

  final HomeController controller = Get.find<HomeController>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var status;
  getStatus() async {
    status = await SharePrefsHelper.getBool(AppConstants.guestUser);
  }

  @override
  void initState() {
    getStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const SideDrawer(),
      bottomNavigationBar: const NavBar(currentIndex: 0),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.homeResponse();
        },
        child: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(onTap: () {
                controller.homeResponse();
              });
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  controller.homeResponse();
                },
              );
            case Status.completed:
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ///===================================Home AppBar===================================///

                      HomeAppBar(
                        scaffoldKey: scaffoldKey,
                        myProfile: GestureDetector(
                          onTap: () {
                            if (status == true && status != null) {
                              Get.toNamed(AppRoute.logIn);
                              SharePrefsHelper.remove(AppConstants.guestUser);
                            } else {
                              Get.toNamed(AppRoute.myProfile);
                            }
                          },
                          child: profileController
                                      .profileModel.value.data?.profileImage ==
                                  null
                              ? CustomNetworkImage(
                                  imageUrl: 'https://i.ibb.co/z5YHLV9/profile.png',
                                  height: 60.h,
                                  width: 60.w,
                                  borderRadius: BorderRadius.circular(50),
                                )
                              : CustomNetworkImage(
                                  imageUrl: profileController.profileModel.value
                                              .data?.profileImage!
                                              .startsWith('https') ??
                                          false
                                      ? profileController.profileModel.value
                                              .data?.profileImage ??
                                          ""
                                      : '${ApiConstant.baseUrl}${profileController.profileModel.value.data?.profileImage ?? ""}',
                                  height: 60.h,
                                  width: 60.w,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                        ),
                        name: profileController.profileModel.value.data?.name ??
                            "Guest User",
                      ),

                      ///============================Popular Categories============================///

                      controller.subCatList.isEmpty
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: AppStrings.popularCategories,
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.greenNormalGreen4,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.to(() => SubCategoryScreen());
                                    },
                                    icon: const Row(
                                      children: [
                                        CustomText(
                                          text: AppStrings.viewAll,
                                          color: AppColors.blueDarkerBleu10,
                                        ),
                                        Icon(Icons.arrow_right_alt)
                                      ],
                                    )),
                              ],
                            ),

                      SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 10),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(controller.subCatList.length,
                              (index) {
                            return GestureDetector(
                              onTap: () {
                                controller.subCateName = controller
                                        .subCatList[index].subcategoryName ??
                                    "";
                                print(controller.subCateName);
                                Get.toNamed(AppRoute.subCategoryProduct);
                              },
                              child: CustomCatagory(
                                  title: controller
                                          .subCatList[index].subcategoryName ??
                                      "",
                                  image:
                                      '${ApiConstant.baseUrl}${controller.subCatList[index].subcategoryImage ?? ""}'),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),

                      ///==============================Banner Image==========================

                      controller.bannerList.isEmpty
                          ? const SizedBox()
                          : CarouselSlider(
                              options: CarouselOptions(
                                height: 110.0.h,
                                autoPlay: true,
                                autoPlayCurve: Curves.ease,
                                pageSnapping: false,

                                //viewportFraction: 1,
                                onPageChanged: (int index, reason) {
                                  controller.bannerIndex.value = index;

                                  controller.pageController.value =
                                      PageController(
                                          initialPage:
                                              controller.bannerIndex.value);
                                },
                              ),
                              items: controller.bannerList.map((imagePath) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: 300.w,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${ApiConstant.baseUrl}${imagePath.bannerImage ?? ""}'))),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                      SizedBox(
                        height: 10.h,
                      ),

                      ///================ Smooth Indicator ====================

                      ConstValue.indicator(
                          controller: controller.pageController.value,
                          count: controller.bannerList.length),

                      ///============================Best Deals============================///

                      controller.homeProductList.isEmpty
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: AppStrings.bestDeals,
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.greenNormalGreen4,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed(AppRoute.bestDeals);
                                    },
                                    icon: const Row(
                                      children: [
                                        CustomText(
                                          text: AppStrings.viewAll,
                                          color: AppColors.blueDarkerBleu10,
                                        ),
                                        Icon(Icons.arrow_right_alt)
                                      ],
                                    )),
                              ],
                            ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              controller.homeProductList.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoute.productDeatils,
                                    arguments:
                                        controller.homeProductList[index].id);
                              },
                              child: ProductCard(
                                onTapCard: () {
                                  controller.addCard(
                                      cardId: controller
                                              .homeProductList[index].id ??
                                          "",
                                      quantity: 1);
                                },
                                image:
                                  '${ApiConstant.baseUrl}${controller.homeProductList[index].productImage![0] ?? ""}',
                                title: controller
                                        .homeProductList[index].productName ??
                                    "",
                                price:
                                    controller.homeProductList[index].price ??
                                        0,
                                oldPrice:  CustomText(
                                        decoration: TextDecoration.lineThrough,
                                        text:
                                            '\$${controller.homeProductList[index].discount ?? "0"}',
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.redDarkRed7,
                                      ),
                                quantity: '${controller.homeProductList[index].weight ??
                                    ""}kg',
                                bookMark: IconButton(
                                    onPressed: () {
                                      if (status == true && status != null) {
                                        Get.toNamed(AppRoute.logIn);
                                        SharePrefsHelper.remove(
                                            AppConstants.guestUser);
                                      } else {
                                        controller.bookmark(
                                            toggleBookmark: controller
                                                    .homeProductList[index]
                                                    .id ??
                                                "");
                                        controller.refresh();
                                      }
                                    },
                                    icon: controller
                                            .homeProductList[index].favorite!
                                        ? const CustomImage(
                                            imageSrc: AppIcons.love,
                                            imageColor:
                                                AppColors.greenNormalGreen4,
                                          )
                                        : const CustomImage(
                                            imageSrc: AppIcons.bookmark,
                                            imageColor:
                                                AppColors.greenNormalGreen4,
                                          )),
                              ),
                            );
                          }),
                        ),
                      ),

                      ///============================New Arrival============================///

                      controller.homeProductList.isEmpty
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: AppStrings.newArrival,
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.greenNormalGreen4,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed(AppRoute.newArrival);
                                    },
                                    icon: const Row(
                                      children: [
                                        CustomText(
                                          text: AppStrings.viewAll,
                                          color: AppColors.blueDarkerBleu10,
                                        ),
                                        Icon(Icons.arrow_right_alt)
                                      ],
                                    )),
                              ],
                            ),

                      controller.homeProductList.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 200.h,
                                ),
                                Center(
                                  child: CustomText(
                                    text: "Product Empty",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    controller.homeProductList.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoute.productDeatils,
                                          arguments: controller
                                              .homeProductList[index].id);
                                    },
                                    child: ProductCard(
                                      /*onTapCard: () {
                                  controller.addCard(
                                      cardId: controller
                                          .homeProductList[index].id ??
                                          "",
                                      quantity: 1);
                                },*/
                                      image:
                                          '${ApiConstant.baseUrl}${controller.homeProductList[index].productImage![0] ?? ""}',
                                      title: controller.homeProductList[index]
                                              .productName ??
                                          "",
                                      price: controller
                                              .homeProductList[index].price ??
                                          0,
                                      oldPrice:  CustomText(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              text:
                                                  '\$${controller.homeProductList[index].discount ?? "0"}',
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.redDarkRed7,
                                            ),
                                      quantity: '${controller.homeProductList[index].weight ?? ""}kg',
                                      bookMark: IconButton(
                                          onPressed: () {
                                            if (status == true &&
                                                status != null) {
                                              Get.toNamed(AppRoute.logIn);
                                              SharePrefsHelper.remove(
                                                  AppConstants.guestUser);
                                            } else {
                                              controller.bookmark(
                                                  toggleBookmark: controller
                                                          .homeProductList[
                                                              index]
                                                          .id ??
                                                      "");
                                              controller.update();
                                            }
                                          },
                                          icon: controller
                                                  .homeProductList[index]
                                                  .favorite!
                                              ? const CustomImage(
                                                  imageSrc: AppIcons.love,
                                                  imageColor: AppColors
                                                      .greenNormalGreen4,
                                                )
                                              : const CustomImage(
                                                  imageSrc: AppIcons.bookmark,
                                                  imageColor: AppColors
                                                      .greenNormalGreen4,
                                                )),
                                    ),
                                  );
                                }),
                              ),
                            ),
                      SizedBox(
                        height: 24.h,
                      )
                    ],
                  ),
                ),
              );
          }
        }),
      ),
    );
  }
}
