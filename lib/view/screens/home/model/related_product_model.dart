// To parse this JSON data, do
//
//     final relatedProductModel = relatedProductModelFromJson(jsonString);

import 'dart:convert';

RelatedProductModel relatedProductModelFromJson(String str) => RelatedProductModel.fromJson(json.decode(str));

String relatedProductModelToJson(RelatedProductModel data) => json.encode(data.toJson());

class RelatedProductModel {
  int? statusCode;
  bool? success;
  String? message;
  Pagination? pagination;
  List<RelatedProductDatum>? relatedProductData;

  RelatedProductModel({
    this.statusCode,
    this.success,
    this.message,
    this.pagination,
    this.relatedProductData,
  });

  factory RelatedProductModel.fromJson(Map<String, dynamic> json) => RelatedProductModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    relatedProductData: json["data"] == null ? [] : List<RelatedProductDatum>.from(json["data"]!.map((x) => RelatedProductDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "pagination": pagination?.toJson(),
    "relatedProductData": relatedProductData == null ? [] : List<dynamic>.from(relatedProductData!.map((x) => x.toJson())),
  };
}

class Pagination {
  int? page;
  int? limit;
  int? totalPage;
  int? total;

  Pagination({
    this.page,
    this.limit,
    this.totalPage,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json["page"],
    limit: json["limit"],
    totalPage: json["totalPage"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "totalPage": totalPage,
    "total": total,
  };
}

class RelatedProductDatum {
  String? id;
  String? productName;
  List<String>? productImage;
  String? productId;
  String? barcode;
  int? price;
  Offer? offer;
  String? discount;
  double? discountPrice;
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

  RelatedProductDatum({
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

  factory RelatedProductDatum.fromJson(Map<String, dynamic> json) => RelatedProductDatum(
    id: json["_id"],
    productName: json["productName"],
    productImage: json["productImage"] == null ? [] : List<String>.from(json["productImage"]!.map((x) => x)),
    productId: json["productId"],
    barcode: json["barcode"],
    price: json["price"],
    offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
    discount: json["discount"],
    discountPrice: json["discountPrice"]?.toDouble(),
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
    "offer": offer?.toJson(),
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

class Offer {
  String? id;
  String? offerName;
  int? percentage;

  Offer({
    this.id,
    this.offerName,
    this.percentage,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["_id"],
    offerName: json["offerName"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "offerName": offerName,
    "percentage": percentage,
  };
}
