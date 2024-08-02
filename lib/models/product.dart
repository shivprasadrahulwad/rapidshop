// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class Product {
//   final double? discountPrice;
//   final String? offer;
//   final String subCategory;
//   final String name;
//   final String description;
//   final double? quantity;  
//   final List<String> images;
//   // final List<String> scheduleOptions;
//   final String category;
//   final double price;
//   final String schedule;
//   final String? id;
  
//   Product({
//     required this.discountPrice,
//     required this.offer,
//     required this.subCategory,
//     required this.name,
//     required this.description,
//     required this.quantity,
//     required this.images,
//     // required this.scheduleOptions,
//     required this.category,
//     required this.price,
//     required this.schedule,
//     this.id,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'discountPrice': discountPrice,
//       // 'scheduleOptions': scheduleOptions,
//       'schedule' : schedule,
//       'offer' : offer,
//       'subCategory': subCategory,
//       'name': name,
//       'description': description,
//       'quantity': quantity,
//       'images': images,
//       'category': category,
//       'price': price,
//       'id': id,
//     };
//   }

//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       discountPrice: map['discountPrice']?.toDouble() ?? 0.0,
//       offer: map['offer'] ?? '',
//       subCategory: map['subCategory'] ?? '',
//       name: map['name'] ?? '',
//       description: map['description'] ?? '',
//       quantity: map['quantity']?.toDouble() ?? 0.0,
//       images: List<String>.from(map['images']),
//       // scheduleOptions: List<String>.from(map['scheduleOptions']),
//       category: map['category'] ?? '',
//       price: map['price']?.toDouble() ?? 0.0,
//       schedule: map['schedule'] ?? '',
//       id: map['_id'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
// }



import 'dart:convert';

class Product {
  final int? discountPrice;
  final String? offer;
  final String subCategory;
  final String name;
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final int price;
  final String schedule;
  final String id;

  Product({
    required this.subCategory,
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    required this.schedule,
    required this.id,
    this.discountPrice,
    this.offer,
  });

  Product copyWith({
    int? discountPrice,
    String? offer,
    String? subCategory,
    String? name,
    String? description,
    int? quantity,
    List<String>? images,
    String? category,
    int? price,
    String? schedule,
    String? id,
  }) {
    return Product(
      discountPrice: discountPrice ?? this.discountPrice,
      offer: offer ?? this.offer,
      subCategory: subCategory ?? this.subCategory,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      category: category ?? this.category,
      price: price ?? this.price,
      schedule: schedule ?? this.schedule,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'discountPrice': discountPrice,
      'offer': offer,
      'subCategory': subCategory,
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'schedule': schedule,
      '_id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    print('Mapping product: $map'); // Debugging statement

    return Product(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: (map['quantity'] )?.toInt() ?? 0,
      // schedule: map['schedule'] ?? '',
      schedule: map['schedule'] is List
        ? (map['schedule'] as List).join(', ') // Convert list to a comma-separated string
        : map['schedule']?.toString() ?? '', // Ensure it's a string
      images: List<String>.from(map['images'] ?? []),
      category: map['category'] ?? '',
      subCategory: map['subCategory'] ?? '',
      price: (map['price'] )?.toInt() ?? 0,
      discountPrice: (map['discountPrice'] )?.toInt() ?? 0,
      offer: map['offer'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory Product.fromJson(String source) {
  //   final map = json.decode(source) as Map<String, dynamic>;
  //   print('Parsing JSON source: $map'); // Debugging statement
  //   return Product.fromMap(map);
  // }
  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

void main() {
  String jsonString = '''
  {
    "_id": "669335e32879d9af5fb38381",
    "name": "Groundnut",
    "description": "Most famous Indian vegetable which is loved by most people",
    "price": 90,
    "discountPrice": 80,
    "category": "Atta, Rice & Dal",
    "subCategory": "Dal",
    "offer": "",
    "quantity": 100,
    "images": ["https://res.cloudinary.com/dybzzlqhv/image/upload/v1720927440/shop/lr0"],
    "schedule": "1"
  }
  ''';

  // Convert JSON string to Product object
  Product product = Product.fromJson(jsonString);

  // Print Product object
  print('Product Name: ${product.name}');
  print('Product Description: ${product.description}');
  print('Product Price: ${product.price}');
  print('Product ID: ${product.id}');

  // Convert Product object back to JSON string
  String productJson = product.toJson();
  print('Product JSON: $productJson');
}
