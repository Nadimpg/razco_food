// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) => OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) => json.encode(data.toJson());

class OrderHistoryModel {
  int? statusCode;
  bool? success;
  String? message;
  List<Datum>? data;

  OrderHistoryModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) => OrderHistoryModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? orderId;
  User? user;
  Cart? cart;
  int? totalItem;
  int? price;
  DateTime? deliveryDate;
  int? deliveryFee;
  String? transactionId;
  int? points;
  bool? callForPickup;
  String? paymentMethod;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.orderId,
    this.user,
    this.cart,
    this.totalItem,
    this.price,
    this.deliveryDate,
    this.deliveryFee,
    this.transactionId,
    this.points,
    this.callForPickup,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    orderId: json["orderId"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
    totalItem: json["totalItem"],
    price: json["price"],
    deliveryDate: json["deliveryDate"] == null ? null : DateTime.parse(json["deliveryDate"]),
    deliveryFee: json["deliveryFee"],
    transactionId: json["transactionId"],
    points: json["points"],
    callForPickup: json["callForPickup"],
    paymentMethod: json["paymentMethod"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "orderId": orderId,
    "user": user?.toJson(),
    "cart": cart?.toJson(),
    "totalItem": totalItem,
    "price": price,
    "deliveryDate": deliveryDate?.toIso8601String(),
    "deliveryFee": deliveryFee,
    "transactionId": transactionId,
    "points": points,
    "callForPickup": callForPickup,
    "paymentMethod": paymentMethod,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Cart {
  String? id;
  String? user;
  List<ProductElement>? products;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Cart({
    this.id,
    this.user,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["_id"],
    user: json["user"],
    products: json["products"] == null ? [] : List<ProductElement>.from(json["products"]!.map((x) => ProductElement.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ProductElement {
  ProductProduct? product;
  int? quantity;
  String? id;

  ProductElement({
    this.product,
    this.quantity,
    this.id,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    product: json["product"] == null ? null : ProductProduct.fromJson(json["product"]),
    quantity: json["quantity"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "quantity": quantity,
    "_id": id,
  };
}


class ProductProduct {
  String? id;
  String? productName;
  List<String>? productImage;
  int? price;
  String? weight;

  ProductProduct({
    this.id,
    this.productName,
    this.productImage,
    this.price,
    this.weight,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
    id: json["_id"],
    productName: json["productName"],
    productImage: json["productImage"] == null ? [] : List<String>.from(json["productImage"]!.map((x) => x)),
    price: json["price"],
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "productImage": productImage == null ? [] : List<dynamic>.from(productImage!.map((x) => x)),
    "price": price,
    "weight": weight,
  };
}





class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
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
















/*

// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) => OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) => json.encode(data.toJson());

class OrderHistoryModel {
  int? statusCode;
  bool? success;
  String? message;
  List<Datum>? data;

  OrderHistoryModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) => OrderHistoryModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? orderId;
  User? user;
  Cart? cart;
  int? totalItem;
  int? price;
  DateTime? deliveryDate;
  int? deliveryFee;
  String? transactionId;
  int? points;
  bool? callForPickup;
  String? paymentMethod;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.orderId,
    this.user,
    this.cart,
    this.totalItem,
    this.price,
    this.deliveryDate,
    this.deliveryFee,
    this.transactionId,
    this.points,
    this.callForPickup,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    orderId: json["orderId"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
    totalItem: json["totalItem"],
    price: json["price"],
    deliveryDate: json["deliveryDate"] == null ? null : DateTime.parse(json["deliveryDate"]),
    deliveryFee: json["deliveryFee"],
    transactionId: json["transactionId"],
    points: json["points"],
    callForPickup: json["callForPickup"],
    paymentMethod: json["paymentMethod"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "orderId": orderId,
    "user": user?.toJson(),
    "cart": cart?.toJson(),
    "totalItem": totalItem,
    "price": price,
    "deliveryDate": deliveryDate?.toIso8601String(),
    "deliveryFee": deliveryFee,
    "transactionId": transactionId,
    "points": points,
    "callForPickup": callForPickup,
    "paymentMethod": paymentMethod,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Cart {
  String? id;
  String? user;
  List<ProductElement>? products;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Cart({
    this.id,
    this.user,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["_id"],
    user: json["user"],
    products: json["products"] == null ? [] : List<ProductElement>.from(json["products"]!.map((x) => ProductElement.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ProductElement {
  ProductProduct? product;
  int? quantity;
  String? id;

  ProductElement({
    this.product,
    this.quantity,
    this.id,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    product: json["product"] == null ? null : ProductProduct.fromJson(json["product"]),
    quantity: json["quantity"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "quantity": quantity,
    "_id": id,
  };
}


class ProductProduct {
  String? id;
  String? productName;
  List<String>? productImage;
  int? price;
  String? weight;

  ProductProduct({
    this.id,
    this.productName,
    this.productImage,
    this.price,
    this.weight,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
    id: json["_id"],
    productName: json["productName"],
    productImage: json["productImage"] == null ? [] : List<String>.from(json["productImage"]!.map((x) => x)),
    price: json["price"],
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "productImage": productImage == null ? [] : List<dynamic>.from(productImage!.map((x) => x)),
    "price": price,
    "weight": weight,
  };
}





class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
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
}*/

