import 'dart:convert';

class AboutModel {
  int? statusCode;
  bool? success;
  String? message;
  AboutData? aboutData;

  AboutModel({
    this.statusCode,
    this.success,
    this.message,
    this.aboutData,
  });

  factory AboutModel.fromRawJson(String str) => AboutModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    aboutData: json["data"] == null ? null : AboutData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "aboutData": aboutData?.toJson(),
  };
}

class AboutData {
  String? id;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AboutData({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AboutData.fromRawJson(String str) => AboutData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AboutData.fromJson(Map<String, dynamic> json) => AboutData(
    id: json["_id"],
    content: json["content"]  ,
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
