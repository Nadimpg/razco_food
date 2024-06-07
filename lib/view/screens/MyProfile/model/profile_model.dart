import 'dart:convert';

class ProfileModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  ProfileModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory ProfileModel.fromRawJson(String str) => ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  String? name;
  String? role;
  String? email;
  String? phone;
  String? gender;
  String? address;
  String? status;
  String? profileImage;

  Data({
    this.id,
    this.name,
    this.role,
    this.email,
    this.phone,
    this.gender,
    this.address,
    this.status,
    this.profileImage,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    role: json["role"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    gender: json["gender"] ?? "",
    address: json["address"] ?? "",
    status: json["status"] ?? "",
    profileImage: json["profileImage"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "role": role,
    "email": email,
    "phone": phone,
    "gender": gender,
    "address": address,
    "status": status,
    "profileImage": profileImage,
  };
}
