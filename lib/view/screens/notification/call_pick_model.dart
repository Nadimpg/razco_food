import 'dart:convert';

class CallPickModel {
  int? statusCode;
  bool? success;
  String? message;
  int? unreadNotifications;

  CallPickModel({
    this.statusCode,
    this.success,
    this.message,
    this.unreadNotifications,
  });

  factory CallPickModel.fromRawJson(String str) => CallPickModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CallPickModel.fromJson(Map<String, dynamic> json) => CallPickModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    unreadNotifications: json["unreadNotifications"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "unreadNotifications": unreadNotifications,
  };
}
