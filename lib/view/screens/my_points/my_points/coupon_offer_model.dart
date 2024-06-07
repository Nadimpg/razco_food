// To parse this JSON data, do
//
//     final couponOfferModel = couponOfferModelFromJson(jsonString);

import 'dart:convert';

CouponOfferModel couponOfferModelFromJson(String str) => CouponOfferModel.fromJson(json.decode(str));

String couponOfferModelToJson(CouponOfferModel data) => json.encode(data.toJson());

class CouponOfferModel {
  int? statusCode;
  bool? success;
  String? message;
  List<CouponDatum>? couponData;

  CouponOfferModel({
    this.statusCode,
    this.success,
    this.message,
    this.couponData,
  });

  factory CouponOfferModel.fromJson(Map<String, dynamic> json) => CouponOfferModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    couponData: json["data"] == null ? [] : List<CouponDatum>.from(json["data"]!.map((x) => CouponDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "couponData": couponData == null ? [] : List<dynamic>.from(couponData!.map((x) => x.toJson())),
  };
}

class CouponDatum {
  String? id;
  String? couponCode;
  int? couponDiscount;
  String? expireDate;
  int? targetPoints;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CouponDatum({
    this.id,
    this.couponCode,
    this.couponDiscount,
    this.expireDate,
    this.targetPoints,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CouponDatum.fromJson(Map<String, dynamic> json) => CouponDatum(
    id: json["_id"],
    couponCode: json["couponCode"],
    couponDiscount: json["couponDiscount"],
    expireDate: json["expireDate"],
    targetPoints: json["targetPoints"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "couponCode": couponCode,
    "couponDiscount": couponDiscount,
    "expireDate": expireDate,
    "targetPoints": targetPoints,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
