import 'dart:convert';

class PrivacyModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  PrivacyModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory PrivacyModel.fromRawJson(String str) => PrivacyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
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
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    content: json["content"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "content": content,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
