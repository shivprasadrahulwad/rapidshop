import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eshop/models/order.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/models/user.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:eshop/constants/error_handling.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/constants/utils.dart';
import 'package:eshop/models/product.dart' as ModelsProduct;
class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      print('Fetching products for category: $category');
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print('Response status code: ${res.statusCode}');
      print('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print('Processing response...');
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            print('Adding product $i to productList');
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      print('Error occurred: $e');
      showSnackBar(context, e.toString());
    }
    print('Returning productList: $productList');
    return productList;
  }

//  Future<List<Product>> fetchshopProducts({
//   required BuildContext context,
//   required String shopId, // Add shopId parameter
// }) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//   List<Product> productList = [];
//   try {
//     http.Response res = await http.get(
//       Uri.parse('$uri/api/product?shopId=$shopId'), // Use shopId in URI
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-auth-token': userProvider.user.token,
//       },
//     );
//     print('Response status code: ${res.statusCode}');
//     print('Response body: ${res.body}');

//     httpErrorHandle(
//       response: res,
//       context: context,
//       onSuccess: () {
//         for (int i = 0; i < jsonDecode(res.body).length; i++) {
//           productList.add(
//             Product.fromJson(
//               jsonEncode(
//                 jsonDecode(res.body)[i],
//               ),
//             ),
//           );
//         }
//         print('shop products fetched: $productList'); // Add print statement
//       },
//     );
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }
//   return productList;
// }

//fetch cart products with provided users id
  Future<List<Product>> fetchCartProducts({
    required BuildContext context,
    required String userId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      print('Fetching cart products for user: $userId');
      final Uri url = Uri.parse('$uri/api/user/$userId/cart/products');
      http.Response res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print('Response status code: ${res.statusCode}');
      print('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print('Processing response...');
          final List<dynamic> responseData = jsonDecode(res.body);
          for (var item in responseData) {
            String jsonString = jsonEncode(item); // Convert map to JSON string
            print('Adding product to productList: $jsonString');
            productList.add(Product.fromJson(jsonString));
          }
        },
      );
    } catch (e) {
      print('Error occurred: $e');
      showSnackBar(context, e.toString());
    }
    print('Returning productList: $productList');
    return productList;
  }



// //fetch cart products with provided users id  and subcategory
//   Future<List<Product>> fetchCartProductsBySubCategory({
//   required BuildContext context,
//   required String userId,
//   required String subCategory,
// }) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//   List<Product> productList = [];
//   try {
//     print('Fetching cart products for user: $userId and sub-category: $subCategory');
//     final Uri url = Uri.parse('$uri/api/user/$userId/cart/products');
//     http.Response res = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-auth-token': userProvider.user.token,
//       },
//     );
//     print('Response status code: ${res.statusCode}');
//     print('Response body: ${res.body}');

//     httpErrorHandle(
//       response: res,
//       context: context,
//       onSuccess: () {
//         print('Processing response...');
//         final List<dynamic> responseData = jsonDecode(res.body);
//         for (var item in responseData) {
//           String jsonString = jsonEncode(item); // Convert map to JSON string
//           Product product = Product.fromJson(jsonString);
//           if (product.subCategory == subCategory) {
//             print('Adding product to productList: $jsonString');
//             productList.add(product);
//           }
//         }
//       },
//     );
//   } catch (e) {
//     print('Error occurred: $e');
//     showSnackBar(context, e.toString());
//   }
//   print('Returning productList: $productList');
//   return productList;
// }


///for showing users
Future<List<Product>> fetchCartProductsBySubCategory({
  required BuildContext context,
  required String shopCode,
  required String subCategory,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  List<Product> productList = [];
  
  try {
    print('Fetching cart products for shop: $shopCode and sub-category: $subCategory');
    
    final Uri url = Uri.parse('$uri/api/shop/$shopCode/cart/products?subCategory=$subCategory');
    
    http.Response res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
    );
    
    print('Response status code: ${res.statusCode}');
    print('Response body: ${res.body}');
    
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        print('Processing response...');
        final List<dynamic> responseData = jsonDecode(res.body);
        
        for (var item in responseData) {
          String jsonString = jsonEncode(item); // Convert map to JSON string
          Product product = Product.fromJson(jsonString);
          print('Adding product to productList: $jsonString');
          productList.add(product);
        }
      },
    );
    
  } catch (e) {
    print('Error occurred: $e');
    showSnackBar(context, e.toString());
  }
  
  print('Returning productList: $productList');
  return productList;
}




//add/ copy product to user cart
Future<Product?> copyProductToUserCart({
  required BuildContext context,
  required String productId,
  required String sourceUserId,
  required int quantity,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  Product? product;

  try {
    final String targetUserId = userProvider.user.id;
    print('Source User ID: $sourceUserId');
    print('Target User ID: $targetUserId');
    print('Product ID: $productId');
    print('Quantity: $quantity');

    final Uri apiUri = Uri.parse('$uri/api/copy-product');
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': userProvider.user.token,
    };
    final body = jsonEncode({
      'productId': productId,
      'sourceUserId': sourceUserId,
      'targetUserId': targetUserId,
      'quantity': quantity,
    });

    print('Request URI: $apiUri');
    print('Request Headers: $headers');
    print('Request Body: $body');

    http.Response res = await http.post(apiUri, headers: headers, body: body);

    print('Response status code: ${res.statusCode}');
    print('Response body: ${res.body}');

    if (res.statusCode == 200) {
      final responseData = jsonDecode(res.body);
      print('Response Data: $responseData');
      
      if (responseData.containsKey('cartItem') && responseData['cartItem'].containsKey('product')) {
        product = Product.fromJson(jsonEncode(responseData['cartItem']['product']));
        print('Parsed Product: ${product.toJson()}');
      } else {
        print('Unexpected response structure: ${res.body}');
        showSnackBar(context, 'Unexpected response structure.');
      }
    } else {
      final error = jsonDecode(res.body)['error'];
      print('Error: $error');
      showSnackBar(context, error);
    }
  } catch (e) {
    print('Error: $e');
    showSnackBar(context, e.toString());
  }
  return product;
}

// user placing order
// void placeOrder({
//     required BuildContext context,
//     required String address,
//     required double totalSum,
//     required  instruction,
//     required String? tips,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);

//     try {
//       // Check for null or invalid products
//       for (var item in userProvider.user.cart) {
//         if (item == null || item['product'] == null || item['product']['_id'] == null) {
//           throw Exception('Invalid product in cart');
//         }
//       }

//       final response = await http.post(
//         Uri.parse('$uri/api/order'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': userProvider.user.token,
//         },
//         body: jsonEncode({
//           'cart': userProvider.user.cart,
//           'totalPrice': totalSum,
//           'address': address,
//           'instruction' : instruction,
//           'tips':tips,
//         }),
//       );

//       httpErrorHandle(
//         response: response,
//         context: context,
//         onSuccess: () {
//           userProvider.clearCart();
//           Navigator.popUntil(context, (route) => route.isFirst);
//           showSnackBar(context, 'Your order has been placed!');
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }


void placeOrder({
  required BuildContext context,
  required String address,
  required int totalPrice,
  required String shopId,
  required List<Map<String, String>> instruction,
  required String? tips,
  required int? totalSave,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    // Check for null or invalid products
    for (var item in userProvider.user.cart) {
      if (item == null || item['product'] == null || item['product']['_id'] == null) {
        throw Exception('Invalid product in cart');
      }
    }

    // Add debug prints to check the request body
    print('Request body:');
    print({
      'cart': userProvider.user.cart,
      'totalPrice': totalPrice,
      'shopId':shopId,
      'totalSave' : totalSave,
      'address': address,
      'instruction': instruction,
      'tips': tips,
    });

    final response = await http.post(
      Uri.parse('$uri/api/order'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'cart': userProvider.user.cart,
        'totalPrice': totalPrice,
        'shopId':shopId,
        'totalSave':totalSave,
        'address': address,
        'instruction': instruction,
        'tips': tips,
      }),
    );

    print({
      'cart': userProvider.user.cart,
      'totalPrice': totalPrice,
      'totalSave': totalSave,
      'address': address,
      'shopCode':shopId,
      'instruction': instruction,
      'tips': tips,
    });

    httpErrorHandle(
      response: response,
      context: context,
      onSuccess: () {
        userProvider.clearCart();
        Navigator.popUntil(context, (route) => route.isFirst);
        showSnackBar(context, 'Your order has been placed!');
      },
    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}


// fetch all users oredrs 
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }



  Future<List<ModelsProduct.Product>> fetchCartProductsWithNullDiscountPrice({
    required BuildContext context,
    required String userId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ModelsProduct.Product> productList = [];
    try {
      print('Fetching cart products with null discount price for user: $userId');
      final Uri url = Uri.parse('$uri/api/user/$userId/cart/products/nullDiscountPrice');
      http.Response res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print('Response status code: ${res.statusCode}');
      print('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print('Processing response...');
          final List<dynamic> responseData = jsonDecode(res.body);
          for (var item in responseData) {
            String jsonString = jsonEncode(item); // Convert map to JSON string
            ModelsProduct.Product product = ModelsProduct.Product.fromJson(jsonString);
            print('Product found with null or zero discount price: $jsonString');
            productList.add(product);
          }
        },
      );
    } catch (e) {
      print('Error occurred: $e');
      showSnackBar(context, e.toString());
    }
    print('Returning productList: $productList');
    return productList;
  }

//// remove from cart decrese quqntity
  Future<void> removeFromCart({
    required BuildContext context,
    required Product product, required String sourceUserId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//// incresse the quqnity
  Future<void> addToCart({
    required BuildContext context,
    required Product product, required int quantity,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


Future<List<Product>> fetchOfferCartProducts({
  required BuildContext context,
  required String userId,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  List<Product> productList = [];
  try {
    print('Fetching offer products for user: $userId');
    final Uri url = Uri.parse('$uri/api/user/$userId/cart/products/offer');
    http.Response res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
    );
    print('Response status code: ${res.statusCode}');
    print('Response body: ${res.body}');

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        print('Processing response...');
        final List<dynamic> responseData = jsonDecode(res.body);
        for (var item in responseData) {
          print('Raw item: $item');
          Map<String, dynamic> productMap = item as Map<String, dynamic>;
          print('Adding product to productList: $productMap');
          productList.add(Product.fromMap(productMap));
        }
      },
    );
  } catch (e) {
    print('Error occurred: $e');
    showSnackBar(context, e.toString());
  }
  print('Returning productList: $productList');
  return productList;
}

Future<Product?> fetchProductById(BuildContext context, String productId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product? product;

    try {
      print("Fetching product for ID: $productId");

      http.Response res = await http.get(
        Uri.parse('$uri/api/get-product-by-id?id=$productId'), // Updated URL to match the server endpoint
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      print("Response Status Code: ${res.statusCode}");
      print("Response Body: ${res.body}");

      if (res.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(res.body);
        product = Product.fromMap(responseJson);
        print("Fetched Product: $product");
      } else {
        throw Exception('Failed to fetch product');
      }
    } catch (e) {
      print("Error fetching product: $e");
      showSnackBar(context, 'Error fetching product: $e');
    }

    return product;
  }


  
//fetch all orders based on shopId
//  Future<List<Order>> fetchOrdersForToday(BuildContext context, String shopId) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//   List<Order> orderList = [];
  
//   try {
//     final String todayDate = DateTime.now().toIso8601String().split('T')[0];

//     print("Fetching orders for Date: $todayDate and shop ID: $shopId");

//     http.Response res = await http.get(
//       Uri.parse('$uri/admin/get-orders?date=$todayDate&shopId=$shopId'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-auth-token': userProvider.user.token,
//       },
//     );

//     print("Response Status Code: ${res.statusCode}");
//     print("Response Body: ${res.body}");

//     if (res.statusCode == 200) {
//       List<dynamic> responseJson = jsonDecode(res.body);
//       orderList = responseJson.map((json) => Order.fromMap(json)).toList();
//       print("Fetched Orders: $orderList");
//     } else {
//       throw Exception('Failed to fetch orders');
//     }
//   } catch (e) {
//     print("Error fetching orders: $e");
//     showSnackBar(context, 'Error fetching orders: $e');
//   }
  
//   return orderList;
// }


Future<List<Order>> fetchOrdersForToday(BuildContext context, String shopId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    
    try {
      final String todayDate = DateTime.now().toIso8601String().split('T')[0];

      print("Fetching orders for Date: $todayDate and shop ID: $shopId");

      final url = Uri.parse('$uri/admin/get-orders?date=$todayDate&shopId=$shopId');
      print("Request URL: $url");

      http.Response res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      print("Response Status Code: ${res.statusCode}");
      print("Response Body: ${res.body}");

      if (res.statusCode == 200) {
        List<dynamic> responseJson = jsonDecode(res.body);
        orderList = responseJson.map((json) => Order.fromMap(json)).toList();
        print("Fetched Orders: $orderList");
      } else {
        print("Failed to fetch orders. Status Code: ${res.statusCode}"); // Debug statement
        throw Exception('Failed to fetch orders');
      }
    } catch (e) {
      print("Error fetching orders: $e");
      showSnackBar(context, 'Error fetching orders: $e');
    }
    
    return orderList;
  }

// Future<List<Order>> fetchOrdersForToday(BuildContext context, String shopCode) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//   List<Order> orderList = [];

//   try {
//     final String todayDate = DateTime.now().toIso8601String().split('T')[0];

//     print("Fetching orders for Date: $todayDate and shop Code: $shopCode");

//     http.Response res = await http.get(
//       Uri.parse('$uri/admin/get-orders?date=$todayDate&shopCode=$shopCode'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-auth-token': userProvider.user.token,
//       },
//     );

//     print("Response Status Code: ${res.statusCode}");
//     print("Response Body: ${res.body}");

//     if (res.statusCode == 200) {
//       List<dynamic> responseJson = jsonDecode(res.body);
//       orderList = responseJson.map((json) => Order.fromMap(json)).toList();
//       print("Fetched Orders: $orderList");
//     } else {
//       throw Exception('Failed to fetch orders');
//     }
//   } catch (e) {
//     print("Error fetching orders: $e");
//     showSnackBar(context, 'Error fetching orders: $e');
//   }

//   return orderList;
// }

}



  



