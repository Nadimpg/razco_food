// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

OfferModel offerModelFromJson(String str) => OfferModel.fromJson(json.decode(str));

String offerModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
  int? statusCode;
  bool? success;
  String? message;
  List<OfferDatum>? offerData;

  OfferModel({
    this.statusCode,
    this.success,
    this.message,
    this.offerData,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    offerData: json["data"] == null ? [] : List<OfferDatum>.from(json["data"]!.map((x) => OfferDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "offerData": offerData == null ? [] : List<dynamic>.from(offerData!.map((x) => x.toJson())),
  };
}

class OfferDatum {
  String? id;
  String? offerName;
  int? setPercentage;
  String? offerImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  OfferDatum({
    this.id,
    this.offerName,
    this.setPercentage,
    this.offerImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OfferDatum.fromJson(Map<String, dynamic> json) => OfferDatum(
    id: json["_id"],
    offerName: json["offerName"],
    setPercentage: json["setPercentage"],
    offerImage: json["offerImage"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "offerName": offerName,
    "setPercentage": setPercentage,
    "offerImage": offerImage,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
