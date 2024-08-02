// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'package:shop/models/product.dart';

// class Order {
//   final String id;
//   final List<Product> products;
//   final List<int> quantity;
//   final String address;
//   final String instruction;
//   final String tips;
//   final String userId;
//   final int orderedAt;
//   final int status;
//   final int totalSave;
//   final int totalPrice;
//   final String shopId;

//   Order({
//     required this.id,
//     required this.products,
//     required this.quantity,
//     required this.address,
//     required this.instruction,
//     required this.tips,
//     required this.userId,
//     required this.orderedAt,
//     required this.status,
//     required this.totalSave,
//     required this.totalPrice,
//     required this .shopId,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'shopId':shopId,
//       'products': products.map((x) => x.toMap()).toList(),
//       'quantity': quantity,
//       'address': address,
//       'userId': userId,
//       'tips': tips,
//       'instruction': instruction,
//       'orderedAt': orderedAt,
//       'status': status,
//       'totalSave': totalSave,
//       'totalPrice': totalPrice,
//     };
//   }

//   factory Order.fromMap(Map<String, dynamic> map) {
//     return Order(
//       id: map['_id'] ?? '',
//       products: List<Product>.from(
//           map['products']?.map((x) => Product.fromMap(x['product']))),
//       quantity: List<int>.from(
//         map['products']?.map(
//           (x) => x['quantity'],
//         ),
//       ),
//       address: map['address'] ?? '',
//       shopId: map['shopId'] ?? '',
//       userId: map['userId'] ?? '',
//       instruction: List<String>.from(map['instruction']).toString(),
//       orderedAt: map['orderedAt']?.toInt() ?? 0,
//       status: map['status']?.toInt() ?? 0,
//       totalSave: map['totalSave']?.toInt() ?? 0,
//       totalPrice: map['totalPrice']?.toInt() ?? 0,
//       tips: map['tips'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
// }



import 'dart:convert';

import 'package:eshop/models/product.dart';

// class Order {
//   final String id;
//   final List<Product> products;
//   final List<int> quantity;
//   final String address;
//   final List<String> instruction; // Adjusted type for instruction
//   final String tips;
//   final String userId;
//   final int orderedAt;
//   int status;
//   final int totalSave;
//   final int totalPrice;
//   final String shopId;

//   Order({
//     required this.id,
//     required this.products,
//     required this.quantity,
//     required this.address,
//     required this.instruction,
//     required this.tips,
//     required this.userId,
//     required this.orderedAt,
//     required this.status,
//     required this.totalSave,
//     required this.totalPrice,
//     required this.shopId,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       '_id': id,
//       'shopId': shopId,
//       'products': products.map((product) => {
//         'product': product.toMap(),
//         'quantity': quantity[products.indexOf(product)]
//       }).toList(),
//       'address': address,
//       'instruction': instruction,
//       'tips': tips,
//       'userId': userId,
//       'orderedAt': orderedAt,
//       'status': status,
//       'totalSave': totalSave,
//       'totalPrice': totalPrice,
//     };
//   }

//  factory Order.fromMap(Map<String, dynamic> map) {
//   return Order(
//     id: map['_id'] ?? '',
//     products: (map['products'] as List<dynamic>? ?? []).map((product) {
//       return Product.fromMap(product['product']);
//     }).toList(),
//     quantity: (map['products'] as List<dynamic>? ?? []).map((product) {
//       return product['quantity'] as int;
//     }).toList(),
//     address: map['address'] ?? '',
//     shopId: map['shopId'].toString(),
//     userId: map['userId'].toString(),
//     instruction: (map['instruction'] as List<dynamic>?)?.map((item) => item.toString()).toList() ?? [],
//     orderedAt: map['orderedAt']?.toInt() ?? 0,
//     status: map['status']?.toInt() ?? 0,
//     totalSave: map['totalSave']?.toInt() ?? 0,
//     totalPrice: map['totalPrice']?.toInt() ?? 0,
//     tips: map['tips'].toString(),
//   );
// }



//   String toJson() => json.encode(toMap());

//   factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

//   Order copyWith({
//     String? id,
//     List<Product>? products,
//     List<int>? quantity,
//     String? address,
//     List<String>? instruction,
//     String? tips,
//     String? userId,
//     int? orderedAt,
//     int? status,
//     int? totalSave,
//     int? totalPrice,
//     String? shopId,
//   }) {
//     return Order(
//       id: id ?? this.id,
//       products: products ?? this.products,
//       quantity: quantity ?? this.quantity,
//       address: address ?? this.address,
//       instruction: instruction ?? this.instruction,
//       tips: tips ?? this.tips,
//       userId: userId ?? this.userId,
//       orderedAt: orderedAt ?? this.orderedAt,
//       status: status ?? this.status,
//       totalSave: totalSave ?? this.totalSave,
//       totalPrice: totalPrice ?? this.totalPrice,
//       shopId: shopId ?? this.shopId,
//     );
//   }
// }


class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final List<Map<String, String>> instruction; // Adjusted type for instruction
  final String tips;
  final String userId;
  final int orderedAt;
  int status;
  final int totalSave;
  final int totalPrice;
  final String shopId;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.instruction,
    required this.tips,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalSave,
    required this.totalPrice,
    required this.shopId,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'shopId': shopId,
      'products': products.map((product) => {
        'product': product.toMap(),
        'quantity': quantity[products.indexOf(product)]
      }).toList(),
      'address': address,
      'instruction': instruction.map((instr) => instr).toList(),
      'tips': tips,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalSave': totalSave,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: (map['products'] as List<dynamic>? ?? []).map((product) {
        return Product.fromMap(product['product']);
      }).toList(),
      quantity: (map['products'] as List<dynamic>? ?? []).map((product) {
        return product['quantity'] as int;
      }).toList(),
      address: map['address'] ?? '',
      shopId: map['shopId'].toString(),
      userId: map['userId'].toString(),
      instruction: (map['instruction'] as List<dynamic>? ?? []).map((item) {
        return (item as Map).cast<String, String>();
      }).toList(),
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalSave: map['totalSave']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      tips: map['tips'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  Order copyWith({
    String? id,
    List<Product>? products,
    List<int>? quantity,
    String? address,
    List<Map<String, String>>? instruction,
    String? tips,
    String? userId,
    int? orderedAt,
    int? status,
    int? totalSave,
    int? totalPrice,
    String? shopId,
  }) {
    return Order(
      id: id ?? this.id,
      products: products ?? this.products,
      quantity: quantity ?? this.quantity,
      address: address ?? this.address,
      instruction: instruction ?? this.instruction,
      tips: tips ?? this.tips,
      userId: userId ?? this.userId,
      orderedAt: orderedAt ?? this.orderedAt,
      status: status ?? this.status,
      totalSave: totalSave ?? this.totalSave,
      totalPrice: totalPrice ?? this.totalPrice,
      shopId: shopId ?? this.shopId,
    );
  }
}