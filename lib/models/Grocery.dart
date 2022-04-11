// To parse this JSON data, do
//
//     final grocery = groceryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Grocery> groceryFromJson(String str) => List<Grocery>.from(json.decode(str).map((x) => Grocery.fromJson(x)));

String groceryToJson(List<Grocery> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Grocery {
  Grocery({
    required this.id,
    required this.name,
    required this.favorited,
    required this.quantityOrdered,
    required this.image,
    required this.price,
    required this.description,
    required this.quantityInStock,
  });

  int id;
  String name;
  int favorited;
  int quantityOrdered;
  String image;
  int price;
  String description;
  int quantityInStock;


  factory Grocery.fromJson(Map<String, dynamic> json) => Grocery(
    id: json["id"],
    name: json["name"],
    favorited: json["favorited"],
    quantityOrdered: json["quantity_ordered"],
    image: json["image"],
    price: json["price"],
    description: json["description"],
    quantityInStock: json["quantity_in_stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "favorited": favorited,
    "quantity_ordered": quantityOrdered,
    "image": image,
    "price": price,
    "description": description,
    "quantity_in_stock": quantityInStock,
  };
}
