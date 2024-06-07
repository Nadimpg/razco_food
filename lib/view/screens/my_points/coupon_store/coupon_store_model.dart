// To parse this JSON data, do
//
//     final couponStoreModel = couponStoreModelFromJson(jsonString);

import 'dart:convert';

CouponStoreModel couponStoreModelFromJson(String str) => CouponStoreModel.fromJson(json.decode(str));

String couponStoreModelToJson(CouponStoreModel data) => json.encode(data.toJson());

class CouponStoreModel {
  int? statusCode;
  bool? success;
  String? message;
  List<CouponStoreDatum>? couponStoreData;

  CouponStoreModel({
    this.statusCode,
    this.success,
    this.message,
    this.couponStoreData,
  });

  factory CouponStoreModel.fromJson(Map<String, dynamic> json) => CouponStoreModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    couponStoreData: json["data"] == null ? [] : List<CouponStoreDatum>.from(json["data"]!.map((x) => CouponStoreDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "couponStoreData": couponStoreData == null ? [] : List<dynamic>.from(couponStoreData!.map((x) => x.toJson())),
  };
}

class CouponStoreDatum {
  String? couponCode;
  int? couponDiscount;
  String? expireDate;
  String? id;

  CouponStoreDatum({
    this.couponCode,
    this.couponDiscount,
    this.expireDate,
    this.id,
  });

  factory CouponStoreDatum.fromJson(Map<String, dynamic> json) => CouponStoreDatum(
    couponCode: json["couponCode"],
    couponDiscount: json["couponDiscount"],
    expireDate: json["expireDate"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "couponCode": couponCode,
    "couponDiscount": couponDiscount,
    "expireDate": expireDate,
    "_id": id,
  };
}
