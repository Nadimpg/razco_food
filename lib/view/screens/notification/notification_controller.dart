import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_check.dart';
import 'package:razco_foods/service/api_client.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/service/socket.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/snackbar_toastmsg.dart';
import 'package:razco_foods/view/screens/notification/call_pick_model.dart';
import 'package:razco_foods/view/screens/notification/notification_model.dart';

class NotificationController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

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

  ///<========================== notification =============================>

  RxList<Datum> notificationList = <Datum>[].obs;

  int unReadNotification = 0;

  getNotification() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.notifications,
    );
    if (response.statusCode == 200) {
      notificationList.value =
          List<Datum>.from(response.body["data"].map((x) => Datum.fromJson(x)));

      NotificationModel notificationModel =
          NotificationModel.fromJson(response.body);

      unReadNotification = notificationModel.unreadNotifications!;

      if (notificationList.isNotEmpty) {
        currentPage = response.body['pagination']['page'];
        totalPage = response.body['pagination']['total'];
      }
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
        "${ApiConstant.notifications}?page=$pages",
      );
      currentPage = response.body['pagination']['page'];
      totalPage = response.body['pagination']['total'];

      if (response.statusCode == 200) {
        var demoList = List<Datum>.from(
            response.body["data"].map((x) => Datum.fromJson(x)));
        notificationList.addAll(demoList);

        notificationList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

  ///====================== Read Notification ======================
  readNotification() async {
    var response = await ApiClient.patchData(ApiConstant.readNotification, {});

    if (response.statusCode == 200) {
      Get.toNamed(AppRoute.notification);
      getNotification();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  RxInt notificationCount = 0.obs;

  listenNotification() async {
    var profileID = await SharePrefsHelper.getString(AppConstants.profileID);
    SocketApi.socket.on("notification::$profileID", (data) {
      Map<String, dynamic> value = data;
      debugPrint("Notification Socket========>>>>>>>$value");
      getNotification();
      Datum newNotification = Datum.fromJson(value);

      notificationList.insert(notificationCount.value, newNotification);
      notificationCount.value += 1;
      refresh();

      notificationCount.refresh();
    });
  }

  ///<==================================== call for pick =================================>

  CallPickModel callPickModel = CallPickModel();

  getCallPick() async {
    setRxRequestStatus(Status.loading);
    update();

    var response = await ApiClient.getData(ApiConstant.callPick);

    if (response.statusCode == 200) {
      callPickModel = CallPickModel.fromJson(response.body);

     // toastMessage(message: response.body['message']);
      toastMessage(message: 'Please wait few minutes.we are coming with the product');
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
    listenNotification();
     getNotification();
    scrollController.addListener(addScrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    getNotification();
    super.dispose();
  }
}
