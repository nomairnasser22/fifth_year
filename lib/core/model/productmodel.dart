// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final int id;
  final int totalPrice;
  final String user;
  final String expenseName;
  final String itemName;
  final int quantity;
  final int price;
  final DateTime timePurchased;

  ProductModel({
    required this.id,
    required this.totalPrice,
    required this.user,
    required this.expenseName,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.timePurchased,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        totalPrice: json["total_price"],
        user: json["user"],
        expenseName: json["expense_name"],
        itemName: json["item_name"],
        quantity: json["quantity"],
        price: json["price"],
        timePurchased: DateTime.parse(json["time_purchased"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total_price": totalPrice,
        "user": user,
        "expense_name": expenseName,
        "item_name": itemName,
        "quantity": quantity,
        "price": price,
        "time_purchased": timePurchased.toIso8601String(),
      };
}
