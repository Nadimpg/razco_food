import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/bar_code_scan/bar_code_scan.dart';
import 'package:razco_foods/view/screens/home/home.dart';
import 'package:razco_foods/view/screens/offer/offer.dart';
import 'package:razco_foods/view/screens/shop_screen/shop_screen.dart';
import 'package:razco_foods/view/screens/wishList/wish_list.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  var bottomNavIndex = 0;

  List<String> selectedText = [
    AppStrings.home,
    AppStrings.shop,
    AppStrings.scanner,
    AppStrings.offer,
    AppStrings.wishlist,
  ];

  List<String> unselectedIcon = [
    AppIcons.homeUnselected,
    AppIcons.shopUnselected,
    AppIcons.scanUnselected,
    AppIcons.offerUnselected,
    AppIcons.wishlistUnselected,
  ];

  List<String> selectedIcon = [
    AppIcons.homeselected,
    AppIcons.shopselected,
    AppIcons.scanSelected,
    AppIcons.offerSelected,
    AppIcons.wishlistselected,
  ];

  var status;
  getStatus()async{
    status= await SharePrefsHelper.getBool(AppConstants.guestUser);
  }

  @override
  void initState() {
    getStatus();
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }
  // @override
  // void initState() {
  //   bottomNavIndex = widget.currentIndex;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      height: 70.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
      ),
      alignment: Alignment.center,
      color: AppColors.greenNormalGreen4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
          (index) => InkWell(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: index == bottomNavIndex
                      ? AppColors.whiteLightWhite1
                      : null,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    index == bottomNavIndex
                        ? SvgPicture.asset(
                            selectedIcon[index],
                            height: 18.w,
                          )
                        : SvgPicture.asset(
                            unselectedIcon[index],
                            height: 18.w,
                          ),
                    if (index == bottomNavIndex)
                      CustomText(
                        left: index == bottomNavIndex ? 4 : 0,
                        top: 4.h,
                        color: index == bottomNavIndex
                            ? AppColors.greenNormalGreen4
                            : AppColors.whiteNormalWhite4,
                        fontSize: 10.h,
                        fontWeight: FontWeight.w400,
                        text: selectedText[index],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    // HomeController homeController = Get.find<HomeController>();
    // homeController.scrollController.dispose();
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.offAll(() => HomeScreen());
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {

        Get.offAll(() => ShopScreen());

      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {

        if(status==true && status!=null){
          Get.toNamed(AppRoute.logIn);
          SharePrefsHelper.remove(
              AppConstants
                  .guestUser);


        } else{
          Get.offAll(() =>   BarCodeScan());
        }

      }
    }
    //
    else if (index == 3) {
      if (!(widget.currentIndex == 3)) {

        Get.offAll(() =>  OfferScreen());

      }
    } else if (index == 4) {
      if (!(widget.currentIndex == 4)) {

        if(status==true && status!=null){
          Get.toNamed(AppRoute.logIn);
          SharePrefsHelper.remove(
              AppConstants
                  .guestUser);
        } else{
          Get.offAll(() => WishListScreen());
        }

      }
    }
  }
}
