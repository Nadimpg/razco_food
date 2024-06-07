import 'dart:convert';

class TotalPointsModel {
  int? statusCode;
  bool? success;
  String? message;
  TotalData? totalData;

  TotalPointsModel({
    this.statusCode,
    this.success,
    this.message,
    this.totalData,
  });

  factory TotalPointsModel.fromRawJson(String str) => TotalPointsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TotalPointsModel.fromJson(Map<String, dynamic> json) => TotalPointsModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    totalData: json["data"] == null ? null : TotalData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "totalData": totalData?.toJson(),
  };
}

class TotalData {
  int? available;
  int? used;

  TotalData({
    this.available,
    this.used,
  });

  factory TotalData.fromRawJson(String str) => TotalData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TotalData.fromJson(Map<String, dynamic> json) => TotalData(
    available: json["available"],
    used: json["used"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "used": used,
  };
}
