import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razco_foods/core/app_routes/app_routes.dart';
import 'package:razco_foods/helper/prefs_helper.dart';
import 'package:razco_foods/service/api_check.dart';
import 'package:razco_foods/service/api_client.dart';
import 'package:razco_foods/service/api_url.dart';
import 'package:razco_foods/utils/app_const.dart';
import 'package:razco_foods/view/screens/MyProfile/model/profile_model.dart';

class ProfileController extends GetxController {

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  bool isGender=false;

  ///<================================================This is for pick image=============================>
  File? proImage;
  String? proImgURL = "";

  void openGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      proImage = File(pickedFile.path);
      update();
    }
  }

  ///<=============================== get profile ================================>

  Rx<ProfileModel> profileModel = ProfileModel().obs;

  Future<void> getProfile() async {
    setRxRequestStatus(Status.loading);
    refresh();
    //String userID = await SharePrefsHelper.getString(AppConstants.profileID);

    var response = await ApiClient.getData(ApiConstant.getProfile);

    if (response.statusCode == 200) {

        profileModel.value = ProfileModel.fromJson(response.body);

        SharePrefsHelper.setString(AppConstants.profileID, response.body["data"]["_id"]);
        print('id =================${response.body["data"]["_id"]}');
        //saveProfileID(iD: profileModel.value.user!.id!);
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

  ///<================================ update profile ==============================>

  TextEditingController nameController = TextEditingController();
  TextEditingController phnNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  updateProfileControllerValue(ProfileModel profileModel) {
    proImgURL = profileModel.data!.profileImage ?? "";
    nameController =
        TextEditingController(text: profileModel.data!.name ?? "");
    phnNumberController =
        TextEditingController(text: profileModel.data!.phone ?? "");
    emailController = TextEditingController(text: profileModel.data!.email ?? "");
    genderController = TextEditingController(text: profileModel.data!.gender ?? "");
    addressController =
        TextEditingController(text:profileModel.data!.address ?? "");

    update();

    Get.toNamed(AppRoute.editProfileScreen);
  }

  bool profileUpdateLoading = false;
  updateProfile() async {
    profileUpdateLoading = true;

    update();

    var body = {
      "name": nameController.text,
      "phone": phnNumberController.text,
      "gender": genderController.text,
      "address": addressController.text,
    };

    var response =

    proImage == null
        ? await ApiClient.patchData(
      ApiConstant.profileUpdate,
      body,
    )
        :

    await ApiClient.patchMultipartData(ApiConstant.profileUpdate, body,
        multipartBody: [
          MultipartBody("profileImage",File( proImage!.path)),
        ]);

    if (response.statusCode == 200) {
      proImgURL = "";
      getProfile();
      navigator!.pop();
    } else {
      ApiChecker.checkApi(response);
    }

    profileUpdateLoading = false;
    update();
  }

@override
  void onInit() {
    getProfile();
    super.onInit();
  }

}
