// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  int? statusCode;
  bool? success;
  String? message;
  List<FaqDatum>? faqData;

  FaqModel({
    this.statusCode,
    this.success,
    this.message,
    this.faqData,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    faqData: json["data"] == null ? [] : List<FaqDatum>.from(json["data"]!.map((x) => FaqDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "faqData": faqData == null ? [] : List<dynamic>.from(faqData!.map((x) => x.toJson())),
  };
}

class FaqDatum {
  String? id;
  String? question;
  String? answer;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  FaqDatum({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory FaqDatum.fromJson(Map<String, dynamic> json) => FaqDatum(
    id: json["_id"],
    question: json["question"] ?? "",
    answer: json["answer"] ?? "",
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "answer": answer,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
