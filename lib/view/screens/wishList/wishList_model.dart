// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

WishListModel wishListModelFromJson(String str) => WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  int? statusCode;
  bool? success;
  String? message;
  List<WishDatum>? wishData;

  WishListModel({
    this.statusCode,
    this.success,
    this.message,
    this.wishData,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    wishData: json["data"] == null ? [] : List<WishDatum>.from(json["data"]!.map((x) => WishDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "wishData": wishData == null ? [] : List<dynamic>.from(wishData!.map((x) => x.toJson())),
  };
}

class WishDatum {
  String? id;
  String? user;
  Product? product;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  WishDatum({
    this.id,
    this.user,
    this.product,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory WishDatum.fromJson(Map<String, dynamic> json) => WishDatum(
    id: json["_id"],
    user: json["user"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "product": product?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Product {
  String? id;
  String? productName;
  List<String>? productImage;
  String? productId;
  String? barcode;
  int? price;
  String? offer;
  String? discount;
  String? category;
  String? subcategory;

  int? store;
  String? weight;
  String? brand;
  String? description;
  bool? favorite;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Product({
    this.id,
    this.productName,
    this.productImage,
    this.productId,
    this.barcode,
    this.price,
    this.offer,
    this.discount,
    this.category,
    this.subcategory,

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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    productName: json["productName"],
    productImage: json["productImage"] == null ? [] : List<String>.from(json["productImage"]!.map((x) => x)),
    productId: json["productId"],
    barcode: json["barcode"],
    price: json["price"],
    offer: json["offer"],
    discount: json["discount"],
    category: json["category"],
    subcategory: json["subcategory"],

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
    "category": category,
    "subcategory": subcategory,

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
