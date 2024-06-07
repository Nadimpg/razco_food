import 'dart:convert';

class MyCardModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  MyCardModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory MyCardModel.fromRawJson(String str) => MyCardModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyCardModel.fromJson(Map<String, dynamic> json) => MyCardModel(
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
  User? user;
  List<CardDatum>? cardData;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.user,
    this.cardData,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    cardData: json["data"] == null ? [] : List<CardDatum>.from(json["data"]!.map((x) => CardDatum.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "cardData": cardData == null ? [] : List<dynamic>.from(cardData!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class CardDatum {
  Product? product;
  int? quantity;
  String? id;

  CardDatum({
    this.product,
    this.quantity,
    this.id,
  });

  factory CardDatum.fromRawJson(String str) => CardDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CardDatum.fromJson(Map<String, dynamic> json) => CardDatum(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    quantity: json["quantity"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "quantity": quantity,
    "_id": id,
  };
}

class Product {
  String? id;
  String? productName;
  List<String>? productImage;
  String? productId;
  String? barcode;
  int? price;
  String? offer;
  String? discount;
  int? discountPrice;
  String? category;
  String? subcategory;
  String? expireDate;
  int? store;
  String? weight;
  String? brand;
  String? description;
  bool? favorite;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Product({
    this.id,
    this.productName,
    this.productImage,
    this.productId,
    this.barcode,
    this.price,
    this.offer,
    this.discount,
    this.discountPrice,
    this.category,
    this.subcategory,
    this.expireDate,
    this.store,
    this.weight,
    this.brand,
    this.description,
    this.favorite,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    productName: json["productName"],
    productImage: json["productImage"] == null ? [] : List<String>.from(json["productImage"]!.map((x) => x)),
    productId: json["productId"],
    barcode: json["barcode"],
    price: json["price"],
    offer: json["offer"],
    discount: json["discount"],
    discountPrice: json["discountPrice"],
    category: json["category"],
    subcategory: json["subcategory"],
    expireDate: json["expireDate"],
    store: json["store"],
    weight: json["weight"],
    brand: json["brand"],
    description: json["description"],
    favorite: json["favorite"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "productImage": productImage == null ? [] : List<dynamic>.from(productImage!.map((x) => x)),
    "productId": productId,
    "barcode": barcode,
    "price": price,
    "offer": offer,
    "discount": discount,
    "discountPrice": discountPrice,
    "category": category,
    "subcategory": subcategory,
    "expireDate": expireDate,
    "store": store,
    "weight": weight,
    "brand": brand,
    "description": description,
    "favorite": favorite,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
