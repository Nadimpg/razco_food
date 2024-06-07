import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_check.dart';
import 'package:razco_foods/service/api_client.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/utils/snackbar_toastmsg.dart';
import 'package:razco_foods/view/screens/foods_list_screen/cate_wise_model.dart';
import 'package:razco_foods/view/screens/home/model/banner_model.dart';
import 'package:razco_foods/view/screens/home/model/related_product_model.dart';
import 'package:razco_foods/view/screens/home/model/sub_category_moodel.dart';
import 'package:razco_foods/view/screens/my_cart/my_card_model.dart';
import 'package:razco_foods/view/screens/offer/offer_model.dart';
import 'package:razco_foods/view/screens/product_details/product_details_model.dart';
import 'package:razco_foods/view/screens/search/search_model.dart';
import 'package:razco_foods/view/screens/shop_screen/shop_model.dart';
import 'package:razco_foods/view/screens/wishList/wishList_model.dart';
import 'package:razco_foods/view/widgets/custom_loader/custom_loader.dart';

class HomeController extends GetxController {
  RxInt bannerIndex = 0.obs;
  RxList<bool> isBookMarked = <bool>[].obs;
  Rx<PageController> pageController = PageController().obs;
  RxInt quantity = 1.obs;
  RxBool isAddToCard = false.obs;
  RxBool isAddToCardHome = false.obs;

  RxBool hasCoupon = false.obs;
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///<========================== sub category =============================>

  RxList<SubDatum> subCatList = <SubDatum>[].obs;

  Future<bool> getSubCategory() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.subcategory,
    );

    if (response.statusCode == 200) {
      subCatList.value = List<SubDatum>.from(
          response.body["data"].map((x) => SubDatum.fromJson(x)));

     // subName = subCatList[0].subcategoryName ?? "";
      return true;
      //setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
      return false;
    }
  }

  ///<========================== category wise =============================>

  RxList<CateWiseDatum> catWiseList = <CateWiseDatum>[].obs;

  getCateWise({String id = ''}) async {
    // setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      '${ApiConstant.categoryWise}/$id',
    );

    if (response.statusCode == 200) {
      catWiseList.value = List<CateWiseDatum>.from(
          response.body["data"].map((x) => CateWiseDatum.fromJson(x)));

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

  ///<========================== category =============================>

  RxList<CatDatum> catList = <CatDatum>[].obs;
  int selectedIndex = 0;

  getCategory() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.category,
    );

    if (response.statusCode == 200) {
      catList.value = List<CatDatum>.from(
          response.body["data"].map((x) => CatDatum.fromJson(x)));

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

  ///<========================== banner =============================>

  RxList<BannerDatum> bannerList = <BannerDatum>[].obs;

  Future<bool> getBanner() async {
    //setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.banner,
    );

    if (response.statusCode == 200) {
      bannerList.value = List<BannerDatum>.from(
          response.body["data"].map((x) => BannerDatum.fromJson(x)));

      return true;
      //setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
      return false;
    }
  }

  ///<============================== search ===============================>

  TextEditingController maxPriceController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  String subName = "";

  RxList<SearchDatum> searchList = <SearchDatum>[].obs;
  getSearch(
      {bool isFilter = false,
      String priceMin = "",
      String priceMax = "",
      String search = ""}) async {
    setRxRequestStatus(Status.loading);

    var response = isFilter
        ? await ApiClient.getData(
            "${ApiConstant.product}?minPrice=$priceMin&maxPrice=$priceMax&subcategory=$subName")
        : await ApiClient.getData("${ApiConstant.product}?search=$search");

    if (response.statusCode == 200) {
      searchList.value=[];
      if (isFilter) {
        searchList.value = List<SearchDatum>.from(
            response.body["data"].map((x) => SearchDatum.fromJson(x)));
        Get.toNamed(AppRoute.searchScreen);
      } else {
        searchList.value = List<SearchDatum>.from(
            response.body["data"].map((x) => SearchDatum.fromJson(x)));
      }

      if (search.isNotEmpty) {
        //clearSearch.value = false;
        refresh();
      }
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

  ///<============================== subCat wise product ===============================>

  dynamic subCateName = "";
  RxList<SearchDatum> subCatWiseProductList = <SearchDatum>[].obs;
  getSubCateWiseProduct({subCateName}) async {
    //setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
        '${ApiConstant.product}?subcategory=$subCateName');
    if (response.statusCode == 200) {
      subCatWiseProductList.value = List<SearchDatum>.from(
          response.body["data"].map((x) => SearchDatum.fromJson(x)));
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

  ///<============================== home product new arrival ===============================>
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

  RxList<SearchDatum> homeProductList = <SearchDatum>[].obs;
  Future<bool> getHomeProduct() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(ApiConstant.product);

    if (response.statusCode == 200) {
      homeProductList.value = List<SearchDatum>.from(
          response.body["data"].map((x) => SearchDatum.fromJson(x)));

      if (homeProductList.isNotEmpty) {
        currentPage = response.body['pagination']['page'];
        totalPage = response.body['pagination']['total'];
      }

      setRxRequestStatus(Status.completed);
      return true;
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
      return false;
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
        "${ApiConstant.product}?page=$pages",
      );
      currentPage = response.body['pagination']['page'];
      totalPage = response.body['pagination']['total'];

      if (response.statusCode == 200) {
        var demoList = List<SearchDatum>.from(
            response.body["data"].map((x) => SearchDatum.fromJson(x)));
        homeProductList.addAll(demoList);

        homeProductList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

  ///<=============================== get profile ================================>

  Rx<ProductDetailsModel> productDetailsModel = ProductDetailsModel().obs;

  Future<void> getProductDetails({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData('${ApiConstant.product}/$id');

    if (response.statusCode == 200) {
      productDetailsModel.value = ProductDetailsModel.fromJson(response.body);
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

  ///<========================== offer =============================>

  RxList<OfferDatum> offerList = <OfferDatum>[].obs;

  getOffer() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.offer,
    );

    if (response.statusCode == 200) {
      offerList.value = List<OfferDatum>.from(
          response.body["data"].map((x) => OfferDatum.fromJson(x)));

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

  ///<========================== offer product =============================>
  RxList<SearchDatum> offerProductList = <SearchDatum>[].obs;
  String offerName = "";
  getOfferProduct({offerName}) async {
    //setRxRequestStatus(Status.loading);
    var response =
        await ApiClient.getData('${ApiConstant.product}?offer=$offerName');
    if (response.statusCode == 200) {
      offerProductList.value = List<SearchDatum>.from(
          response.body["data"].map((x) => SearchDatum.fromJson(x)));
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

  ///<========================== wishList =============================>

  RxList<WishDatum> wishList = <WishDatum>[].obs;

  getWishList() async {
    // setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.wishlist,
    );

    if (response.statusCode == 200) {
      wishList.value = List<WishDatum>.from(
          response.body["data"].map((x) => WishDatum.fromJson(x)));

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

  ///<============================ post bookmark =================================>

  var productID = '';
  var relatedProductId = '';
  bookmark({String toggleBookmark = ''}) async {
    var body = {
      "product": toggleBookmark,
    };

    var response = await ApiClient.postData(
      ApiConstant.wishlistToggle,
      body,
    );

    if (response.statusCode == 200) {
      toastMessage(message: response.body['message']);
      getHomeProduct();
      getSearch();


     // getRelatedProduct(id: relatedProductId);//relatedProductId
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  relatedProductBookmark({String toggleBookmark = ''}) async {
    var body = {
      "product": toggleBookmark,
    };

    var response = await ApiClient.postData(
      ApiConstant.wishlistToggle,
      body,
    );

    if (response.statusCode == 200) {
      toastMessage(message: response.body['message']);
      getRelatedProduct(id: relatedProductId); //relatedProductId
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  subCatBookmark({String toggleBookmark = ''}) async {
    var body = {
      "product": toggleBookmark,
    };

    var response = await ApiClient.postData(
      ApiConstant.wishlistToggle,
      body,
    );

    if (response.statusCode == 200) {
      toastMessage(message: response.body['message']);

      getSubCateWiseProduct(subCateName: subCateName);

      getRelatedProduct(id: toggleBookmark); //relatedProductId
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  offerProductBookmark({String toggleBookmark = ''}) async {
    var body = {
      "product": toggleBookmark,
    };
    var response = await ApiClient.postData(
      ApiConstant.wishlistToggle,
      body,
    );

    if (response.statusCode == 200) {
      toastMessage(message: response.body['message']);

      getOfferProduct(offerName: productID);
      getRelatedProduct(id: toggleBookmark); //relatedProductId
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  ///<============================ add card =================================>

  static showPopUpLoader() {
    return showDialog(
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (_) {
          return const SizedBox(
            height: 70,
            child: AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              //child: CustomLoader(),
              content: CustomLoader(),
            ),
          );
        });
  }

  addCard({String cardId = '', int quantity = 1}) async {
    showPopUpLoader();
    var bearerToken =
        await SharePrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      //'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    Map<String, dynamic> body = {
      "product": cardId,
      "quantity": quantity,
    };

    var response = await ApiClient.postData(
        ApiConstant.addCard, jsonEncode(body),
        headers: mainHeaders);

    if (response.statusCode == 200) {
      // toastMessage(message: response.body['message']);
      getMYCard();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    navigator!.pop();
  }

  ///<============================ card delete =================================>

  cardDelete({String id = ''}) async {
    var response = await ApiClient.deleteData('${ApiConstant.cart}/$id');

    if (response.statusCode == 200) {
      toastMessage(message: response.body['message']);
      getMYCard();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  ///<========================== related product =============================>

  RxList<RelatedProductDatum> relatedProductList = <RelatedProductDatum>[].obs;

  getRelatedProduct({String id = ''}) async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      '${ApiConstant.relatedProduct}/$id',
    );

    if (response.statusCode == 200) {
      relatedProductList.value = List<RelatedProductDatum>.from(
          response.body["data"].map((x) => RelatedProductDatum.fromJson(x)));

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

  ///<========================== my cardt =============================>

  RxList<CardDatum> myCardList = <CardDatum>[].obs;

  var name = "";
  var phnNumber = "";
  var address = "";
  RxString cartId = ''.obs;

  getMYCard() async {
    // setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
      ApiConstant.cartProduct,
    );

    if (response.statusCode == 200) {
      myCardList.value = List<CardDatum>.from(
          response.body["data"]["products"].map((x) => CardDatum.fromJson(x)));
      MyCardModel myCardModel = MyCardModel.fromJson(response.body);
      cartId.value = myCardModel.data!.id!;

      print('========================== $cartId');
      // setRxRequestStatus(Status.completed);
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

/*  Rx<MyCardModel> myCardModel = MyCardModel().obs;

  Future<void> getMYCard() async {
    setRxRequestStatus(Status.loading);
    refresh();

    var response = await ApiClient.getData(ApiConstant.getProfile);

    if (response.statusCode == 200) {

      myCardModel.value = MyCardModel.fromJson(response.body);

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
  }*/

  ///<============================== calculate =============================== >

  TextEditingController promoCodeController = TextEditingController();
  bool loading = false;
  var percentage = 0;
  applyPromoCode({String promoCode = ""}) async {
    loading = true;

    update();
    var body = {
      "promoCode": promoCode,
    };
    /* var bearerToken =
    await SharePrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      //'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };*/
    var response = await ApiClient.postData(
      ApiConstant.promoCodeApply,
      body,
    );
    if (response.statusCode == 200) {
      percentage = response.body['data']['discount'];
    } else {
      ApiChecker.checkApi(response);
    }

    loading = false;
    update();
  }

  ///<============================== calculate =============================== >

  var price = 0;

  int calculatePrice() {
    double totalPrice = 0; // Change to double to handle decimal values
    for (var value in myCardList.value) {
      int price = (value.product?.price ?? 0) * (value.quantity ?? 0);
      totalPrice += price.toDouble(); // Convert price to double before adding
    }
    double percentageAmount =
        (totalPrice * percentage) / 100; // Calculate percentage as double
    totalPrice = totalPrice - percentageAmount;

    return totalPrice.toInt(); // Convert totalPrice to int before returning
  }

  int totalItem() {
    int totalItem = 0;

    for (var value in myCardList.value) {
      totalItem += value.quantity!;
    }
    return totalItem;
  }

  ///<====================================== delete account ==========================================>
  TextEditingController passwordController = TextEditingController();

  deleteAccount() async {
    loading = true;

    update();
    var body = {
      "password": passwordController.text,
    };

    var response =
        await ApiClient.deleteData(ApiConstant.deleteAccount, body: body);
    if (response.statusCode == 200) {
      SharePrefsHelper.remove(AppConstants.isRememberMe);
      Get.toNamed(AppRoute.logIn);
      toastMessage(message: response.body['message']);
      passwordController.clear();
    } else {
      ApiChecker.checkApi(response);
      toastMessage(message: response.body['message']);
    }

    loading = false;
    update();
  }

  homeResponse() async {
    bool banner = await getBanner();
    bool subCategory = await getSubCategory();
    bool homeProduct = await getHomeProduct();
    if (banner && subCategory && homeProduct) {
      setRxRequestStatus(Status.completed);
      refresh();
    }
  }

  @override
  void onInit() {
    homeResponse();
    getSearch();
    getCategory();
    getOffer();
    scrollController.addListener(addScrollListener);

    super.onInit();
  }
}
