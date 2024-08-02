// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:eshop/models/product.dart';

class Fshop {
  final String id;
  final List<Product> products;
  final String quantity;
  final int price;
  final String time;
  final int discountPrice;
  Fshop({
    required this.id,
    required this.products,
    required this.quantity,
    required this.price,
    required this.time,
    required this.discountPrice,
  });

  Fshop copyWith({
    String? id,
    List<Product>? products,
    String? quantity,
    int? price,
    String? time,
    int? discountPrice,
  }) {
    return Fshop(
      id: id ?? this.id,
      products: products ?? this.products,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      time: time ?? this.time,
      discountPrice: discountPrice ?? this.discountPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'price': price,
      'time': time,
      'discountPrice': discountPrice,
    };
  }

  factory Fshop.fromMap(Map<String, dynamic> map) {
    return Fshop(
      id: map['_id'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      quantity: map['quantity'] ?? '',
      price: map['price']?.toInt() ?? 0,
      time: map['time'] ?? '',
      discountPrice: map['discountPrice']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fshop.fromJson(String source) => Fshop.fromMap(json.decode(source));
}
