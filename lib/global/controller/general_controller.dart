import 'package:get/get.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_check.dart';
import 'package:razco_foods/service/api_client.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/app_image.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/faq/faq_model.dart';

class GeneralController extends GetxController {



  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  ///=======================OnBoarding===================

  RxInt currentOnboarding = 0.obs;
  RxList<String> onBoardingImage = [
    AppImages.onboarding1,
    AppImages.onboarding2,
    AppImages.onboarding3,
  ].obs;

  RxList<String> onBoardingTitle = [
    AppStrings.hi,
    AppStrings.easyOrderingSystem,
    AppStrings.easyPaymentMethod,
  ].obs;

  RxList<String> onBoardingDescription = [
    AppStrings.simplyDummyText,
    AppStrings.simplyDummyText,
    AppStrings.simplyDummyText,
  ].obs;




  RxString profileID = "".obs;

  ///================== Get User Id ====================
  getUserID() async {
    //profileID.value = await SharePrefsHelper.getString(AppConstants.profileID);
    profileID.refresh();
  }



//
  @override
  void onInit() {
    getUserID();

    super.onInit();
  }

}
