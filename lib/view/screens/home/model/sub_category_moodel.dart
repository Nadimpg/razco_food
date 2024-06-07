import 'dart:convert';

class SubCategoryModel {
  int? statusCode;
  bool? success;
  String? message;
  Pagination? pagination;
  List<SubDatum>? subData;

  SubCategoryModel({
    this.statusCode,
    this.success,
    this.message,
    this.pagination,
    this.subData,
  });

  factory SubCategoryModel.fromRawJson(String str) => SubCategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    subData: json["data"] == null ? [] : List<SubDatum>.from(json["data"]!.map((x) => SubDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "pagination": pagination?.toJson(),
    "subData": subData == null ? [] : List<dynamic>.from(subData!.map((x) => x.toJson())),
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

  factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

class SubDatum {
  String? id;
  String? subcategoryName;
  String? subcategoryImage;
  int? clickedCount;
  Category? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SubDatum({
    this.id,
    this.subcategoryName,
    this.subcategoryImage,
    this.clickedCount,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubDatum.fromRawJson(String str) => SubDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubDatum.fromJson(Map<String, dynamic> json) => SubDatum(
    id: json["_id"],
    subcategoryName: json["subcategoryName"],
    subcategoryImage: json["subcategoryImage"],
    clickedCount: json["clickedCount"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "subcategoryName": subcategoryName,
    "subcategoryImage": subcategoryImage,
    "clickedCount": clickedCount,
    "category": category?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Category {
  String? id;
  String? categoryName;
  String? categoryImage;
  int? subcategoryCreated;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Category({
    this.id,
    this.categoryName,
    this.categoryImage,
    this.subcategoryCreated,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
