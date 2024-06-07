import 'package:get/get.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/service/api_check.dart';
import 'package:razco_foods/service/api_client.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/snackbar_toastmsg.dart';
import 'package:razco_foods/view/screens/my_points/my_points/coupon_offer_model.dart';
import 'package:razco_foods/view/screens/order_history/model/order_history_model.dart';
import 'package:razco_foods/view/screens/scan_history/scan_model.dart';
import 'package:razco_foods/view/screens/scan_history_list/scan_history_list_model.dart';

class OrderHistoryController extends GetxController{
  bool expendInfo=true;
  bool expandPrice=true;

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///<========================== scan history =============================>

  RxList<ScanDatum> scanList = <ScanDatum>[].obs;

  getScanHistory({String id=''}) async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      '${ApiConstant.barcode}/$id',
    );

    if (response.statusCode == 200) {
      scanList.value = List<ScanDatum>.from(
          response.body["data"].map((x) => ScanDatum.fromJson(x)));
      Get.toNamed(AppRoute.scanHistoryScreen);
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

  ///<========================== order history =============================>

  RxList<Datum> orderList = <Datum>[].obs;

  getOrderHistory() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.orderHistory,
    );

    if (response.statusCode == 200) {
      orderList.value = List<Datum>.from(
          response.body["data"].map((x) => Datum.fromJson(x)));

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

  ///<========================== Scan history list =============================>

  RxList<ScanHistoryListDatum> scanHistoryList = <ScanHistoryListDatum>[].obs;

  getScanHistoryList() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.scanHistoryList,
    );

    if (response.statusCode == 200) {
      scanHistoryList.value = List<ScanHistoryListDatum>.from(
          response.body["data"].map((x) => ScanHistoryListDatum.fromJson(x)));

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

  ///<============================ card delete =================================>

  scanHistoryDelete({String code = ''}) async {
    var response = await ApiClient.deleteData('${ApiConstant.scanHistoryBarcode}/$code');

    if (response.statusCode == 200) {
      toastMessage(message: response.body['message']);
      getScanHistoryList();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  @override
  void onInit() {
    getOrderHistory();
    getScanHistoryList();
   // getScanHistory();

    super.onInit();
  }
}