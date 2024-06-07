
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/snackbar_toastmsg.dart';


class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) async {
    if (response.statusCode == 401) {
      await SharePrefsHelper.remove(AppConstants.bearerToken);
      Get.offAllNamed(AppRoute.logIn);
    } else {
      showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
    }
  }
}
