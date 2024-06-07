// To parse this JSON data, do
//
//     final scanHistoryListModel = scanHistoryListModelFromJson(jsonString);

import 'dart:convert';

ScanHistoryListModel scanHistoryListModelFromJson(String str) => ScanHistoryListModel.fromJson(json.decode(str));

String scanHistoryListModelToJson(ScanHistoryListModel data) => json.encode(data.toJson());

class ScanHistoryListModel {
  int? statusCode;
  bool? success;
  String? message;
  List<ScanHistoryListDatum>? scanHistoryListData;

  ScanHistoryListModel({
    this.statusCode,
    this.success,
    this.message,
    this.scanHistoryListData,
  });

  factory ScanHistoryListModel.fromJson(Map<String, dynamic> json) => ScanHistoryListModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    scanHistoryListData: json["data"] == null ? [] : List<ScanHistoryListDatum>.from(json["data"]!.map((x) => ScanHistoryListDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "scanHistoryListData": scanHistoryListData == null ? [] : List<dynamic>.from(scanHistoryListData!.map((x) => x.toJson())),
  };
}

class ScanHistoryListDatum {
  String? id;
  String? productName;
  List<String>? productImage;
  String? barcode;
  int? price;
  String? discount;
  String? weight;

  ScanHistoryListDatum({
    this.id,
    this.productName,
    this.productImage,
    this.barcode,
    this.price,
    this.discount,
    this.weight,
  });

  factory ScanHistoryListDatum.fromJson(Map<String, dynamic> json) => ScanHistoryListDatum(
    id: json["_id"],
    productName: json["productName"],
    productImage: json["productImage"] == null ? [] : List<String>.from(json["productImage"]!.map((x) => x)),
    barcode: json["barcode"],
    price: json["price"],
    discount: json["discount"],
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "productImage": productImage == null ? [] : List<dynamic>.from(productImage!.map((x) => x)),
    "barcode": barcode,
    "price": price,
    "discount": discount,
    "weight": weight,
  };
}
