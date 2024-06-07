import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/global/controller/general_controller.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_check.dart';
import 'package:razco_foods/service/api_client.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/snackbar_toastmsg.dart';
import 'package:razco_foods/view/screens/MyProfile/Controller/profile_controller.dart';

class AuthController extends GetxController {
  ProfileController profileController=Get.find<ProfileController>();
  ///<=========================== Sign in controller========================>
  TextEditingController signInEmail =
      TextEditingController(text: kDebugMode ? "wosoda7918@adrais.com" : "");
  TextEditingController passWordSignIn =
      TextEditingController(text: kDebugMode ? "Nadim12345" : "");

  bool signInLoading = false;
  signInUser() async {
    signInLoading = true;
    update();
    Map<String, String> body = {
      'email': signInEmail.text,
      'password': passWordSignIn.text,
    };

    var response = await ApiClient.postData(
      ApiConstant.login,
      body,
    );

    if (response.statusCode == 200) {
      SharePrefsHelper.setString(
          AppConstants.bearerToken, response.body["data"]);
      Get.offAllNamed(AppRoute.homeScreen);
      profileController.getProfile();
    } else {
      ApiChecker.checkApi(response);
    }
    signInLoading = false;
    update();
  }

  ///<================== sign up controller =======================>
  TextEditingController fullNameSignUp = TextEditingController();
  TextEditingController emailSignUp = TextEditingController();
  TextEditingController phoneSignUp = TextEditingController();
  //TextEditingController addressSignUp = TextEditingController();
  TextEditingController passSignUp = TextEditingController();
  TextEditingController confirmPassSignup = TextEditingController();

  bool signUpLoading = false;
  signUpUser() async {
    signUpLoading = true;
    update();
    Map<String, String> body = {
      'name': fullNameSignUp.text,
      'email': emailSignUp.text,
      'phone': phoneSignUp.text,
      'password': passSignUp.text,
    };
    var response = await ApiClient.postData(
      ApiConstant.register,
      body,
    );
    if (response.statusCode == 200) {
      Get.toNamed(AppRoute.signUpOtp);

      fullNameSignUp.clear();
      //emailSignUp.clear();
      phoneSignUp.clear();
      passSignUp.clear();
    } else {
      ApiChecker.checkApi(response);
    }
    signUpLoading = false;
    update();
  }

  ///<======================== verify otp ===================================>
  String signUpOtp = '';
  verifyOTP() async {
    signUpLoading = true;
    update();
    var body = {"email": emailSignUp.text, "code": signUpOtp};
    var response = await ApiClient.postData(
      ApiConstant.verified,
      body,
    );

    if (response.statusCode == 200) {
      print('email============${emailSignUp.text}');
      saveInformationInit(response: response);
      //
      // GeneralController generalController = Get.find<GeneralController>();
      //
      // generalController.getUserID();
      // Get.offAllNamed(AppRoute.subscriptionScreen);
      SharePrefsHelper.setString(
          AppConstants.bearerToken, response.body["token"]);
      Get.offAllNamed(AppRoute.signUpSuccess);
    } else {
      ApiChecker.checkApi(response);
    }
    signUpLoading = false;
    update();
  }

  ///<======================= sign up resent otp ===============================>
  signUpResentOtp() async {
    signUpLoading = true;
    update();
    var body = {"email": emailSignUp.text.trim()};
    var response = await ApiClient.postData(
      ApiConstant.signUpResendOtp,
      body,
    );
    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    signUpLoading = false;
    update();
  }

  ///<========================= forgot controller =========================>
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController forgotPassEmailController = TextEditingController();

  handleForgetPassword() async {
    signUpLoading = true;
    update();
    var body = {"email": forgotPassEmailController.text.trim()};
    var response = await ApiClient.postData(
      ApiConstant.forgetPass,
      body,
    );
    if (response.statusCode == 200) {
      Get.toNamed(AppRoute.otpScreen);
    } else {
      ApiChecker.checkApi(response);
    }
    signUpLoading = false;
    update();
  }

  var headers = {'Content-Type': 'application/json'};

  ///<======================== forgot otp ===================================>
  String otp = '';
  String token = '';
  forgotOTp() async {
    signUpLoading = true;
    update();
    Map<String, dynamic> body = {
      "email": forgotPassEmailController.text,
      "code": otp
    };
    var response = await ApiClient.postData(
      ApiConstant.forgotOtp,
      body,
    );

    if (response.statusCode == 200) {
      token = response.body["data"];
      Get.toNamed(AppRoute.resetPass);
    } else {
      ApiChecker.checkApi(response);
    }
    signUpLoading = false;
    update();

    //print('email============${emailController.text}');
  }

  ///<============================ reset password ==============================>
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  //var token='';

  handleResetPassword() async {
    signUpLoading = true;
    //var bearerToken = await SharePrefsHelper.getString(AppConstants.bearerToken);
    update();

    Map<String, String> header = {'authorization': token};
    var body = {
      "newPassword": newPassController.text,
      "confirmPassword": confirmPassController.text,
    };

    var response =
        await ApiClient.postData(ApiConstant.resetPass, body, headers: header);

    if (response.statusCode == 200) {
      Get.snackbar("Done", "Successfully updated");
      Get.offAllNamed(AppRoute.logIn);
    } else {
      ApiChecker.checkApi(response);
    }

    signUpLoading = false;
    update();
  }

  ///<==================== change password controller =======================>
  TextEditingController changeCurrentPassController = TextEditingController();
  TextEditingController changePassController = TextEditingController();
  TextEditingController changeConfirmPassController = TextEditingController();

  ///<============================For Sign In ==================================>
  bool isRemember = false;

  saveInformationInit({required Response<dynamic> response}) async {
    SharePrefsHelper.setString(AppConstants.bearerToken, response.body["data"]);
    //PrefsHelper.setBool(AppConstants.isSocialLogIn, false);

    //debugPrint('_id ==========================${response.body["user"]["id"]}');

    //signInEmailController.clear();
    //signInPassController.clear();

    GeneralController generalController = Get.find<GeneralController>();

    generalController.getUserID();
  }
}
