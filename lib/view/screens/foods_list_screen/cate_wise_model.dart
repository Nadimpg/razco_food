// To parse this JSON data, do
//
//     final cateWiseModel = cateWiseModelFromJson(jsonString);

import 'dart:convert';

CateWiseModel cateWiseModelFromJson(String str) => CateWiseModel.fromJson(json.decode(str));

String cateWiseModelToJson(CateWiseModel data) => json.encode(data.toJson());

class CateWiseModel {
  int? statusCode;
  bool? success;
  String? message;
  List<CateWiseDatum>? cateWiseData;

  CateWiseModel({
    this.statusCode,
    this.success,
    this.message,
    this.cateWiseData,
  });

  factory CateWiseModel.fromJson(Map<String, dynamic> json) => CateWiseModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    cateWiseData: json["data"] == null ? [] : List<CateWiseDatum>.from(json["data"]!.map((x) => CateWiseDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "cateWiseData": cateWiseData == null ? [] : List<dynamic>.from(cateWiseData!.map((x) => x.toJson())),
  };
}

class CateWiseDatum {
  String? id;
  String? subcategoryName;
  String? subcategoryImage;
  int? clickedCount;
  String? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CateWiseDatum({
    this.id,
    this.subcategoryName,
    this.subcategoryImage,
    this.clickedCount,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CateWiseDatum.fromJson(Map<String, dynamic> json) => CateWiseDatum(
    id: json["_id"],
    subcategoryName: json["subcategoryName"] ?? "",
    subcategoryImage: json["subcategoryImage"] ?? "",
    clickedCount: json["clickedCount"],
    category: json["category"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "subcategoryName": subcategoryName,
    "subcategoryImage": subcategoryImage,
    "clickedCount": clickedCount,
    "category": category,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
