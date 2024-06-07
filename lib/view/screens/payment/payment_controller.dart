import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_check.dart';
import 'package:razco_foods/service/api_client.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:http/http.dart' as http;
import 'package:razco_foods/utils/snackbar_toastmsg.dart';
import 'package:razco_foods/view/screens/MyProfile/Controller/profile_controller.dart';
import 'package:razco_foods/view/screens/notification/notification_controller.dart';

class PaymentController extends GetxController {

  ProfileController profileController =Get.find<ProfileController>();
  NotificationController notificationController =Get.find<NotificationController>();
  RxInt selectedIndex = 0.obs;
  RxBool isPickup=false.obs;

  ///<-------------------------- edit address --------------------------------- >

  TextEditingController nameController=TextEditingController();
  TextEditingController contactController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  bool loading = false;
  editAddress(
      {String name = "", String phone = "", String address = ""}) async {
    loading = true;

    update();
    var body = {
      "name": name,
      "phone": phone,
      "address": address,
    };

    var response = await ApiClient.patchData(
      ApiConstant.editAddress,
      body,
    );
    if (response.statusCode == 200) {

      toastMessage(message: "Edit successfully");
      Get.back();
      profileController.getProfile();
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    loading = false;
    update();
  }


  ///========================= Create Payment Intent =========================
  Map<String, dynamic>value = {};

  Future<Map<String,dynamic>> createPaymentIntent (
      {required int price}) async {
     var bearerToken =
    await SharePrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      //'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body = {
      "price": price,

    };
    try {
      var response = await ApiClient.postData(
        ApiConstant.paymentIntent,
        jsonEncode(body),
        headers: mainHeaders
      );
      debugPrint("Payment Intent body ${response.body}");

      if(response.statusCode==200){

        value =  response.body["data"];
        return value;

      }else{
        ApiChecker.checkApi(response);
        return {};
      }

    } catch (error) {
      Get.snackbar("Error", error.toString());
      print(error);
      return {};

    }
  }

  ///========================= Make Payment =========================

  Future<void> makePayment({
    required int amount,
    required int totalItem,
    required int points,
    required int deliveryFee,
    required String orderId,
    required String cartId,
    required String deliveryDate,
    required bool isPickedUp,
  }) async {

    try {

    Map<String,dynamic>  paymentIntentData = await createPaymentIntent(price: amount);

      print('===========-------------------------${paymentIntentData}');


      if (paymentIntentData.isNotEmpty) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters:  SetupPaymentSheetParameters(
              merchantDisplayName: 'Nadim',
              paymentIntentClientSecret: paymentIntentData['client_secret'],
              allowsDelayedPaymentMethods: true,
              style: ThemeMode.light,
            ));
        await Stripe.instance.presentPaymentSheet();

        /// >><><><><><><<><><><><><><> Send response in server <><><><><><><><><><<><><><><><><<

        makeOrder(
            orderId: orderId,
            totalItem: totalItem,
            price: amount,
            deliveryDate:  deliveryDate,
            deliveryFee: deliveryFee,
            cart:  cartId,
            points: points,
            paymentMethod: 'online',
            transactionId: paymentIntentData['transactionId'] ?? "", isPicked: isPickedUp
        );
      /*  requiterSubscription(
          packageID: packageID,
          currency: currency,
          transactionId: paymentIntentData["id"],
          amount:amount,
          email:homeController.profileModel.value.data!.email.toString(),
          name:homeController.profileModel.value.data!.fullName.toString(),
          paymentType:paymentType,
          status:"successful",
        );*/
        toastMessage(message:"Payment Successful");
      }
    } catch (e) {
      debugPrint("Error ================>>>>>>>>>>>>>${e.toString()}");
      toastMessage(message: "Error $e");
    }
  }

  ///============================ Send Response to server ==============================

  makeOrder({
    required String orderId,
    required int totalItem,
    required int price,
    required String deliveryDate,
    required int deliveryFee,
    required String cart,
    required int points,
    required String paymentMethod,
    required String transactionId,
    required bool isPicked,
  }) async {

    var bearerToken =
    await SharePrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      //'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    Map<String, dynamic> body = {
      "orderId":orderId,
      "totalItem":totalItem ,
      "price":price ,
      "deliveryDate":deliveryDate,
      "deliveryFee":deliveryFee ,
      "cart":cart,
      "points":points ,
      "transactionId":transactionId ,
      "callForPickup": isPicked,
      "paymentMethod":paymentMethod,
    };
    var response =
    await ApiClient.postData(ApiConstant.order,jsonEncode(body),headers: mainHeaders);
    if (response.statusCode == 200){
      Get.toNamed(AppRoute.orderHistoryScreen);
      notificationController.getNotification();
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  ///============================ Send Response to server ==============================

  cashOrder({
    required String orderId,
    required int totalItem,
    required int price,
    required String deliveryDate,
    required int deliveryFee,
    required String cart,
    required int points,
    required String paymentMethod,
    required bool isPick,

  }) async {

    var bearerToken =
    await SharePrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      //'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    Map<String, dynamic> body = {
      "orderId":orderId,
      "totalItem":totalItem ,
      "price":price ,
      "deliveryDate":deliveryDate,
      "deliveryFee":deliveryFee ,
      "cart":cart,
      "points":points ,
      "callForPickup": isPick,
      "paymentMethod":paymentMethod,
    };
    var response =
    await ApiClient.postData(ApiConstant.order,jsonEncode(body),headers: mainHeaders);
    if (response.statusCode == 200){
      Get.toNamed(AppRoute.orderHistoryScreen);
      notificationController.getNotification();
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
  }


}
