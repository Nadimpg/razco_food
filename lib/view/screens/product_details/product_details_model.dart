// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  ProductDetailsModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? productName;
  List<String>? productImage;
  String? productId;
  String? barcode;
  int? price;
  String? offer;
  String? discount;
  int? discountPrice;
  String? category;
  String? subcategory;
  String? expireDate;
  int? store;
  String? weight;
  String? brand;
  String? description;
  bool? favorite;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.productName,
    this.productImage,
    this.productId,
    this.barcode,
    this.price,
    this.offer,
    this.discount,
    this.discountPrice,
    this.category,
    this.subcategory,
    this.expireDate,
    this.store,
    this.weight,
    this.brand,
    this.description,
    this.favorite,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    productName: json["productName"],
    productImage: json["productImage"] == null ? [] : List<String>.from(json["productImage"]!.map((x) => x)),
    productId: json["productId"],
    barcode: json["barcode"],
    price: json["price"],
    offer: json["offer"],
    discount: json["discount"],
    discountPrice: json["discountPrice"],
    category: json["category"],
    subcategory: json["subcategory"],
    expireDate: json["expireDate"],
    store: json["store"],
    weight: json["weight"],
    brand: json["brand"],
    description: json["description"],
    favorite: json["favorite"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "productImage": productImage == null ? [] : List<dynamic>.from(productImage!.map((x) => x)),
    "productId": productId,
    "barcode": barcode,
    "price": price,
    "offer": offer,
    "discount": discount,
    "discountPrice": discountPrice,
    "category": category,
    "subcategory": subcategory,
    "expireDate": expireDate,
    "store": store,
    "weight": weight,
    "brand": brand,
    "description": description,
    "favorite": favorite,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
