// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  int? statusCode;
  bool? success;
  String? message;
  List<BannerDatum>? bannerData;

  BannerModel({
    this.statusCode,
    this.success,
    this.message,
    this.bannerData,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    bannerData: json["data"] == null ? [] : List<BannerDatum>.from(json["data"]!.map((x) => BannerDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "BannerData": bannerData == null ? [] : List<dynamic>.from(bannerData!.map((x) => x.toJson())),
  };
}

class BannerDatum {
  String? id;
  String? bannerName;
  String? bannerImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BannerDatum({
    this.id,
    this.bannerName,
    this.bannerImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BannerDatum.fromJson(Map<String, dynamic> json) => BannerDatum(
    id: json["_id"],
    bannerName: json["bannerName"],
    bannerImage: json["bannerImage"] ?? "",
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bannerName": bannerName,
    "bannerImage": bannerImage,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
