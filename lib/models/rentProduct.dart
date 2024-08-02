import 'dart:convert';

class RentProduct {
  final double discountPrice;
  final String subCategory;
  final String name;
  final String description;
  final String quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;

  RentProduct({
    required this.discountPrice,
    required this.subCategory,
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'discountPrice': discountPrice,
      'subCategory': subCategory,
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
    };
  }

  factory RentProduct.fromMap(Map<String, dynamic> map) {
    return RentProduct(
      discountPrice: map['discountPrice']?.toDouble() ?? 0.0,
      subCategory: map['subCategory'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RentProduct.fromJson(String source) => RentProduct.fromMap(json.decode(source) as Map<String, dynamic>);
}
