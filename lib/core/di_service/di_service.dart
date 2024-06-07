import 'package:get/get.dart';
import 'package:razco_foods/global/controller/general_controller.dart';
import 'package:razco_foods/view/screens/MyProfile/Controller/profile_controller.dart';
import 'package:razco_foods/view/screens/Settings/Controller/settings_controller.dart';
import 'package:razco_foods/view/screens/authentication/auth_controller/controller.dart';
import 'package:razco_foods/view/screens/calculate/calculate_controller.dart';
import 'package:razco_foods/view/screens/home/controller/home_controller.dart';
import 'package:razco_foods/view/screens/my_points/controller/points_controller.dart';
import 'package:razco_foods/view/screens/notification/notification_controller.dart';
import 'package:razco_foods/view/screens/order_history/order_history_controller/order_history_controller.dart';
import 'package:razco_foods/view/screens/payment/payment_controller.dart';

class Dependancy extends Bindings {
  @override
  void dependencies() {
    ///=============================General Controller=========================///
    Get.lazyPut(() => GeneralController(), fenix: true);

    ///=============================Auth Controller=========================///

    Get.lazyPut(() => AuthController(), fenix: true);

    ///=============================Home Controller=========================///

    Get.lazyPut(() => HomeController(),fenix: true);

    ///<==============================Settings===============================>

    Get.lazyPut(() => SettingsController(),fenix: true);
    Get.lazyPut(() => ProfileController(),fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => OrderHistoryController(), fenix: true);
    Get.lazyPut(() => PointsController(), fenix: true);
    Get.lazyPut(() => CalculateController(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
  }
}
