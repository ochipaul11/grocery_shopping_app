// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    required this.id,
    required this.grocery,
    required this.quantity,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  List<Grocery> grocery;
  int quantity;
  int totalPrice;
  DateTime createdAt;
  DateTime updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    grocery: List<Grocery>.from(json["grocery"].map((x) => Grocery.fromJson(x))),
    quantity: json["quantity"],
    totalPrice: json["total_price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grocery": List<dynamic>.from(grocery.map((x) => x.toJson())),
    "quantity": quantity,
    "total_price": totalPrice,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class Grocery {
  Grocery({
    required this.id,
    required this.name,
    required this.favorited,
    required this.quantityOrdered,
    required this.price,
    required this.description,
    required this.quantityInStock,
    required this.image,
  });

  int id;
  String name;
  int favorited;
  int quantityOrdered;
  int price;
  String description;
  int quantityInStock;
  String image;

  factory Grocery.fromJson(Map<String, dynamic> json) => Grocery(
    id: json["id"],
    name: json["name"],
    favorited: json["favorited"],
    quantityOrdered: json["quantity_ordered"],
    price: json["price"],
    description: json["description"],
    quantityInStock: json["quantity_in_stock"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "favorited": favorited,
    "quantity_ordered": quantityOrdered,
    "price": price,
    "description": description,
    "quantity_in_stock": quantityInStock,
    "image": image,
  };
}
