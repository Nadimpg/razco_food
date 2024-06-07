// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  int? statusCode;
  bool? success;
  String? message;
  int? unreadNotifications;
  Pagination? pagination;
  List<Datum>? data;

  NotificationModel({
    this.statusCode,
    this.success,
    this.message,
    this.unreadNotifications,
    this.pagination,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    unreadNotifications: json["unreadNotifications"],
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "unreadNotifications": unreadNotifications,
    "pagination": pagination?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? recipient;
  String? message;
  bool? read;
  Type? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.recipient,
    this.message,
    this.read,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    recipient: json["recipient"],
    message:json["message"],
    read: json["read"],
    type: typeValues.map[json["type"]]!,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "recipient": recipient,
    "message": message,
    "read": read,
    "type": typeValues.reverse[type],
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}





enum Type {
  ORDER
}

final typeValues = EnumValues({
  "order": Type.ORDER
});

class Pagination {
  int? limit;
  int? page;
  int? totalPage;
  int? total;

  Pagination({
    this.limit,
    this.page,
    this.totalPage,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    limit: json["limit"],
    page: json["page"],
    totalPage: json["totalPage"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "page": page,
    "totalPage": totalPage,
    "total": total,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
