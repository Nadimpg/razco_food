import 'dart:convert';

class TermsModel {
  int? statusCode;
  bool? success;
  String? message;
  TermData? termData;

  TermsModel({
    this.statusCode,
    this.success,
    this.message,
    this.termData,
  });

  factory TermsModel.fromRawJson(String str) => TermsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    termData: json["data"] == null ? null : TermData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "termData": termData?.toJson(),
  };
}

class TermData {
  String? id;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TermData({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TermData.fromRawJson(String str) => TermData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermData.fromJson(Map<String, dynamic> json) => TermData(
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
