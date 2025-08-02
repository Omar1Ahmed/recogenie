// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:recogenie/Features/cart/data/entities/cart_entity.dart';

class CartItemsModel {
  final List<CartModel> cartItems;

  CartItemsModel({
    required this.cartItems,
  });

  factory CartItemsModel.fromJson(List<Map<String, dynamic>> json) => CartItemsModel(
    cartItems: List<CartModel>.from(json.map((x) => CartModel.fromJson(x))),
  );

  List<CartEntity> toEntities() => cartItems.map((e) => e.toEntity()).toList();
}

List<CartModel> cartModelFromJson(String str) => List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  final String id;
  final String itemId;
  int quantity;
  final String userId;

  CartModel({
    this.id= '',
    required this.itemId,
    required this.quantity,
    this.userId = '',
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    itemId: json["item_id"],
    quantity: json["quantity"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "quantity": quantity,
    "user_id": userId,
  };

  CartEntity toEntity() => CartEntity(id: id,  itemId: itemId, quantity: quantity, userId: userId);
}
