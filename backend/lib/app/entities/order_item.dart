// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'product.dart';

class OrderItem {
  final int id;
  final int quantity;
  final Product product;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'product': product.toMap(),
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      product: Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));
}
