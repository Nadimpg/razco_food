// To parse this JSON data, do
//
//     final shopModel = shopModelFromJson(jsonString);

import 'dart:convert';

ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  int? statusCode;
  bool? success;
  String? message;
  List<CatDatum>? catData;

  ShopModel({
    this.statusCode,
    this.success,
    this.message,
    this.catData,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    catData: json["catData"] == null ? [] : List<CatDatum>.from(json["catData"]!.map((x) => CatDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "catData": catData == null ? [] : List<dynamic>.from(catData!.map((x) => x.toJson())),
  };
}

class CatDatum {
  String? id;
  String? categoryName;
  String? categoryImage;
  int? subcategoryCreated;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CatDatum({
    this.id,
    this.categoryName,
    this.categoryImage,
    this.subcategoryCreated,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CatDatum.fromJson(Map<String, dynamic> json) => CatDatum(
    id: json["_id"],
    categoryName: json["categoryName"],
    categoryImage: json["categoryImage"],
    subcategoryCreated: json["subcategoryCreated"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryName": categoryName,
    "categoryImage": categoryImage,
    "subcategoryCreated": subcategoryCreated,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
