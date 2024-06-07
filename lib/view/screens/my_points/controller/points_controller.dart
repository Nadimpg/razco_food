import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_check.dart';
import 'package:razco_foods/service/api_client.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/view/screens/my_points/coupon_store/coupon_store_model.dart';
import 'package:razco_foods/view/screens/my_points/my_points/coupon_offer_model.dart';
import 'package:razco_foods/view/screens/my_points/my_points/total_poits_model.dart';

class PointsController extends GetxController{

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  ///<========================== Coupon Offer =============================>

  var totalPage = 0;
  var currentPage = 0;

  ScrollController scrollController = ScrollController();

  //===================Pagination Scroll Controller===============

  Future<void> addScrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMore();
    }
  }

  RxList<CouponDatum> couponOfferList = <CouponDatum>[].obs;

  getCouponOffer() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.coupon,
    );

    if (response.statusCode == 200) {
      couponOfferList.value = List<CouponDatum>.from(
          response.body["data"].map((x) => CouponDatum.fromJson(x)));

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

  //==================================Pagination============================

  var isLoadMoreRunning = false.obs;
  RxInt pages = 1.obs;

  loadMore() async {
    debugPrint("===============load more=============");
    if (rxRequestStatus.value != Status.loading &&
        isLoadMoreRunning.value == false &&
        totalPage != currentPage) {
      isLoadMoreRunning(true);
      pages.value += 1;
      refresh();

      Response response = await ApiClient.getData(
        "${ApiConstant.coupon}?page=$pages",
      );
      currentPage = response.body['pagination']['page'];
      totalPage = response.body['pagination']['total'];

      if (response.statusCode == 200) {
        var demoList = List<CouponDatum>.from(
            response.body["data"].map((x) => CouponDatum.fromJson(x)));
        couponOfferList.addAll(demoList);

        couponOfferList.refresh();

      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

  ///<=============================== getTotalPoints ================================>

  Rx<TotalPointsModel> totalPointsModel = TotalPointsModel().obs;

  Future<void> getTotalPoints() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiConstant.totalPoints);

    if (response.statusCode == 200) {

      totalPointsModel.value = TotalPointsModel.fromJson(response.body);

      setRxRequestStatus(Status.completed);
      update();

    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///<=============================== coupon store ================================>

  RxList<CouponStoreDatum> couponStoreList = <CouponStoreDatum>[].obs;

  getCouponStore() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.couponStore,
    );

    if (response.statusCode == 200) {
      couponStoreList.value = List<CouponStoreDatum>.from(
          response.body["data"].map((x) => CouponStoreDatum.fromJson(x)));

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


  ///<=============================== coupon store ================================>

  bool loading = false;
  claim({required String couponCode,required int couponDiscount,required String expireDate,required int points}) async {
    loading = true;

    update();

    var body = {
      "couponCode": couponCode ,
      "couponDiscount": couponDiscount ,
      "expireDate": expireDate,
      "points": points,

    };
    var bearerToken =
    await SharePrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      //'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    var response =await ApiClient.postData(
      ApiConstant.claimCoupon,
        jsonEncode(body),
      headers: mainHeaders
    );

    if (response.statusCode == 200) {
      Get.toNamed(AppRoute.couponStoreScreen);

    } else {
      ApiChecker.checkApi(response);
    }

    loading = false;
    update();
  }


  @override
  void onInit() {
    getCouponOffer();
    getTotalPoints();
    getCouponStore();
    scrollController.addListener(addScrollListener);

    super.onInit();
  }
}