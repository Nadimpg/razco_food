import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_check.dart';
import 'package:razco_foods/service/api_client.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/view/screens/about_us/about_model.dart';
import 'package:razco_foods/view/screens/faq/faq_model.dart';
import 'package:razco_foods/view/screens/privacy_policy/privacy_model.dart';
import 'package:razco_foods/view/screens/terms_condition/terms_model.dart';

class SettingsController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///<============================== For change Password==========================>

  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool loading = false;
  changePassword() async {
    loading = true;

    var body = {
      "currentPassword": currentPassController.text,
      "newPassword": newPassController.text,
      "confirmPassword": confirmPassController.text
    };

    var response = await ApiClient.postData(
      ApiConstant.updatePassword,
      body,
    );

    if (response.statusCode == 200) {
      Get.snackbar("Done", "Successfully updated");
      Get.toNamed(AppRoute.settingsScreen);
    } else {
      ApiChecker.checkApi(response);
    }

    loading = false;
    update();
  }

  ///<============================== feedback ====================================>
  TextEditingController nameFeedback = TextEditingController();
  TextEditingController descriptionFeedback = TextEditingController();

  feedback() async {
    loading = true;
    var body = {
      "name": nameFeedback.text,
      "description": descriptionFeedback.text,
    };
    var response = await ApiClient.postData(
      ApiConstant.feedback,
      body,
    );
    if (response.statusCode == 200) {
      Get.snackbar("Done", "Successfully submitted");
      navigator?.pop();
    } else {
      ApiChecker.checkApi(response);
    }
    loading = false;
    update();
  }

  ///<================================ about us ===========================>
  AboutModel aboutModel = AboutModel();
  AboutData aboutData = AboutData();

  getAbout() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiConstant.about);

    if (response.statusCode == 200) {
      aboutModel = AboutModel.fromJson(response.body);

      var rawData = aboutModel!.aboutData;
      if (rawData != null) {
        aboutData = rawData;
        setRxRequestStatus(Status.completed);
        refresh();
        return;
      }
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///<================================ privacy us ===========================>
  PrivacyModel privacyModel = PrivacyModel();
  Data privacyData = Data();
  getPrivacy() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiConstant.privacy);

    if (response.statusCode == 200) {
      privacyModel = PrivacyModel.fromJson(response.body);
      if (privacyModel != null) {
        var rawData = privacyModel!.data;
        if (rawData != null) {
          privacyData = rawData;
          setRxRequestStatus(Status.completed);
          refresh();
          return;
        }
      }
    }
    // Handle null or error cases
    else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///<================================ terms ===========================>
  TermsModel termsModel = TermsModel();
  TermData termData = TermData();
  getTerms() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiConstant.terms);

    if (response.statusCode == 200) {
      termsModel = TermsModel.fromJson(response.body);

        var rawData = termsModel!.termData;

          termData = rawData!;
          setRxRequestStatus(Status.completed);
          refresh();


    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }


  ///======================= FAQ ===================
  RxInt selectedFqw = 100000.obs;

  RxList<FaqDatum> faqList = <FaqDatum>[].obs;

  getFaq() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.faq,
    );

    if (response.statusCode == 200) {
      SharePrefsHelper.setString(AppConstants.bearerToken, response.body["data"]);
      faqList.value = List<FaqDatum>.from(
          response.body["data"].map((x) => FaqDatum.fromJson(x)));

      setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  @override
  void onInit() {
    getAbout();
    getPrivacy();
    getTerms();
    getFaq();
    super.onInit();
  }
}
