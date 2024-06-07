import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:razco_foods/view/screens/FeedBack/feed_back.dart';
import 'package:razco_foods/view/screens/MyProfile/EditProfile/edit_profile.dart';
import 'package:razco_foods/view/screens/MyProfile/my_profile.dart';
import 'package:razco_foods/view/screens/Settings/InnerScreen/change_pass.dart';
import 'package:razco_foods/view/screens/Settings/settings.dart';
import 'package:razco_foods/view/screens/about_us/about_us.dart';
import 'package:razco_foods/view/screens/authentication/forget_password/forgot_password.dart';
import 'package:razco_foods/view/screens/authentication/otp/otp.dart';
import 'package:razco_foods/view/screens/authentication/set_password/set_password.dart';
import 'package:razco_foods/view/screens/authentication/sign_in/sign_in.dart';
import 'package:razco_foods/view/screens/authentication/sign_up/sign_up.dart';
import 'package:razco_foods/view/screens/authentication/sign_up_otp/sign_up_otp.dart';
import 'package:razco_foods/view/screens/authentication/sign_up_success/sign_up_success.dart';
import 'package:razco_foods/view/screens/best_deals/best_deals.dart';
import 'package:razco_foods/view/screens/faq/faq.dart';
import 'package:razco_foods/view/screens/home/home.dart';
import 'package:razco_foods/view/screens/my_cart/my_cart.dart';
import 'package:razco_foods/view/screens/my_points/coupon_store/coupon_store_screen.dart';
import 'package:razco_foods/view/screens/my_points/my_points/my_points-screen.dart';
import 'package:razco_foods/view/screens/my_points/points_details/points_details_screen.dart';
import 'package:razco_foods/view/screens/new_arrival/new_arrival.dart';
import 'package:razco_foods/view/screens/notification/notification.dart';
import 'package:razco_foods/view/screens/offer/offer.dart';
import 'package:razco_foods/view/screens/offer_details/offer_details.dart';
import 'package:razco_foods/view/screens/onboarding/onboarding.dart';
import 'package:razco_foods/view/screens/foods_list_screen/foods_list_screen.dart';
import 'package:razco_foods/view/screens/order_history/order_history/order_history_screen.dart';
import 'package:razco_foods/view/screens/order_history/order_history_details/order_history_details.dart';
import 'package:razco_foods/view/screens/payment/edit_address.dart';
import 'package:razco_foods/view/screens/payment/payment.dart';
import 'package:razco_foods/view/screens/privacy_policy/privacy_policy.dart';
import 'package:razco_foods/view/screens/product_details/product_details.dart';
import 'package:razco_foods/view/screens/related_product/related_product_screen.dart';
import 'package:razco_foods/view/screens/scan_history/scan_history_screen.dart';
import 'package:razco_foods/view/screens/scan_history_list/scan_history_list.dart';
import 'package:razco_foods/view/screens/search/filter_screen.dart';
import 'package:razco_foods/view/screens/search/search_screen.dart';
import 'package:razco_foods/view/screens/splash_screen/splash_screen.dart';
import 'package:razco_foods/view/screens/sub_category_product/sub_category_product.dart';
import 'package:razco_foods/view/screens/terms_condition/terms_condition.dart';

class AppRoute {
  //========================Initial Screens======================
  static const String splashscreen = "/splash_screen";
  static const String onBoarding = "/onBoarding";

  //========================Authentication Screens======================

  static const String logIn = "/logIn";
  static const String signUp = "/signUp";
  static const String forgotPass = "/forgotPass";
  static const String otpScreen = "/otpScreen";
  static const String resetPass = "/resetPass";
  static const String signUpSuccess = "/signUpSuccess";

  //=============================NavBar Screens===========================
  static const String homeScreen = "/homeScreen";

  //=============================Home Screens Inner===========================
  static const String foodListScreen = "/popularCategory";
  static const String bestDeals = "/bestDeals";
  static const String newArrival = "/newArrival";
  static const String notification = "/notification";
  static const String searchScreen = "/searchScreen";
  static const String filterScreen = "/filterScreen";

  //============================= Product Deatils ===========================
  static const String productDeatils = "/productDeatils";
  static const String myCart = "/myCart";

  //============================= Offer Screen ===========================
  static const String offers = "/offers";
  static const String offerDetails = "/offerDetails";

  //============================= App Info Screen ===========================
  static const String faq = "/faq";
  static const String aboutUs = "/aboutUs";
  static const String privacyPolicy = "/privacyPolicy";
  static const String termsCondition = "/termsCondition";

  //============================= Payment Screen ===========================

  static const String payment = "/payment";
  static const String editAddress = "/editAddress";

  ///<====================================Profile Section===========================>
  static const String myProfile = "/myProfile";
  static const String editProfileScreen = "/editProfileScreen";

  ///<===========================Settings===========================================>
  static const String settingsScreen = "/settingsScreen";
  static const String changePassScreen = "/changePassScreen";
  static const String feedBackScreen = "/feedBackScreen";
  static const String scanHistoryScreen = "/scan_history_screen";
  static const String orderHistoryScreen = "/order_history_screen";
  static const String orderHistoryDetails = "/order_history_details";
  static const String myPointsScreen = "/my_points_screen";
  static const String pointsDetailsScreen = "/points_details_screen";
  static const String couponStoreScreen = "/coupon_store-screen";
  static const String subCategoryProduct = "/sub_category_product";
  static const String signUpOtp = "/sign_up_otp";
  static const String relatedProductScreen = "/related_product_screen";
  static const String scanHistoryList = "/scan_history_list";

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=====================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  static List<GetPage> routes = [
    //========================Initial Screens======================

    GetPage(name: splashscreen, page: () => const SplashScreen()),
    GetPage(name: scanHistoryList, page: () =>   ScanHistoryList()),
    GetPage(name: relatedProductScreen, page: () =>  RelatedProductScreen()),
    GetPage(name: subCategoryProduct, page: () =>   SubCategoryProduct()),
    GetPage(name: couponStoreScreen, page: () =>   CouponStoreScreen()),
    GetPage(name: pointsDetailsScreen, page: () => const PointsDetailsScreen()),
    GetPage(name: myPointsScreen, page: () =>   MyPointsScreen()),
    GetPage(name: orderHistoryDetails, page: () =>   OrderHistoryDetails()),
    GetPage(name: onBoarding, page: () => OnboardingScreen()),
    GetPage(name: scanHistoryScreen, page: () => ScanHistoryScreen()),

    //========================Authentication Screens======================

    GetPage(name: logIn, page: () => SignInScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: forgotPass, page: () => ForgotPassWord()),
    GetPage(name: otpScreen, page: () => const OtpScreen()),
    GetPage(name: resetPass, page: () => SetpassWordScreen()),
    GetPage(name: signUpSuccess, page: () => const SignUpSuccessScreen()),

    //=============================NavBar Screens===========================

    GetPage(name: homeScreen, page: () => HomeScreen()),


    //=============================Home Screens Inner===========================
    GetPage(name: foodListScreen, page: () => FoodsListScreen()),
    GetPage(name: bestDeals, page: () => BestDeals()),
    GetPage(name: newArrival, page: () => NewArrival()),
    GetPage(name: notification, page: () =>   NotificationScreen()),
    GetPage(name: searchScreen, page: () => SearchScreen()),
    GetPage(name: filterScreen, page: () => FilterScreen()),

    //============================= Product Deatils ===========================
    GetPage(name: productDeatils, page: () => ProductDetails()),

    ///<================================== Profile Section ==============================>
    GetPage(name: myProfile, page: () => MyProfileScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfileScreen()),

    ///<=====================================Settings =====================================>
    GetPage(
      name: settingsScreen,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: changePassScreen,
      page: () => ChangePassWordScreen(),
    ),
    GetPage(name: myCart, page: () => MyCartScreen()),

    //============================= Offer Screen ===========================
    GetPage(name: offers, page: () =>  OfferScreen()),
    GetPage(name: offerDetails, page: () => OfferDetails()),

    //============================= App Info Screen ===========================

    GetPage(name: faq, page: () => FAQ()),
    GetPage(name: aboutUs, page: () =>   AboutUs()),
    GetPage(name: privacyPolicy, page: () =>  PrivacyPolicy()),
    GetPage(name: termsCondition, page: () => TermsCondition()),

    //============================= Payment Screen ===========================
    GetPage(name: payment, page: () =>  PaymentScreen()),
    GetPage(name: editAddress, page: () => EditAddress()),
    GetPage(name: feedBackScreen, page: () =>   FeedBackScreen()),
    GetPage(name: orderHistoryScreen, page: () =>   OrderHistoryScreen()),
    GetPage(name: signUpOtp, page: () => const SignUpOtp()),
  ];
}
