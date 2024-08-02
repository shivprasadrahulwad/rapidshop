import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eshop/constants/error_handling.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/constants/utils.dart';
import 'package:eshop/features/admin/models/sales.dart';
import 'package:eshop/models/order.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminServices {
  //   // get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
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
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  // // Fetch sub-category Products
  //   Future<List<Product>> fetchSubCategoryProducts({
  //     required BuildContext context,
  //     required String subCategory,
  //   }) async {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //     List<Product> productList = [];
  //     try {
  //       print('Fetching products for sub-category: $subCategory');
  //       http.Response res = await http.get(
  //         Uri.parse('$uri/admin/products?subCategory=$subCategory'),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': userProvider.user.token,
  //         },
  //       );
  //       print('Response status code: ${res.statusCode}');
  //       print('Response body: ${res.body}');

  //       httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onSuccess: () {
  //           print('Processing response...');
  //           for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //             print('Adding product $i to productList');
  //             productList.add(
  //               Product.fromJson(
  //                 jsonEncode(
  //                   jsonDecode(res.body)[i],
  //                 ),
  //               ),
  //             );
  //           }
  //         },
  //       );
  //     } catch (e) {
  //       print('Error occurred: $e');
  //       showSnackBar(context, e.toString());
  //     }
  //     print('Returning productList: $productList');
  //     return productList;
  //   }

// Fetch sub-category Products
Future<List<Product>> fetchSubCategoryProducts({
  required BuildContext context,
  required String subCategory,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  List<Product> productList = [];
  try {
    final response = await http.get(
      Uri.parse('$uri/admin/products?subCategory=$subCategory'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      productList = data.map((item) {
        if (item is Map<String, dynamic>) {
          return Product.fromMap(item);
        } else {
          throw Exception('Invalid data format');
        }
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return productList;
}




Future<Product?> copyProductToAdminCart({
  required BuildContext context,
  required String productId,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  Product? product;
  // const String userId = '667b8f9e05d30a6094c86d47';

  try {
    final String userId = userProvider.user.id;
    print('User ID: $userId'); // Debug print
    print('Product ID: $productId'); // Debug print

    http.Response res = await http.post(
      Uri.parse('$uri/admin/copy-product'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'id': productId,
        'userId': userId,
      }),
    );

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        product = Product.fromJson(jsonDecode(res.body));
      },
    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return product;
}



// delete product from cart
void deleteProductFromCart({
  required BuildContext context,
  required String productId,
  required VoidCallback onSuccess,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    final res = await http.post(
      Uri.parse('$uri/admin/delete-cart-product'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'userId': userProvider.user.id,
        'productId': productId,
      }),
    );

    if (res.statusCode == 200) {
      // Product successfully deleted from the cart
      onSuccess();
    } else {
      // Handle any other status code, e.g., 404, 500, etc.
      throw Exception('Failed to delete product from cart');
    }
  } catch (e) {
    // Handle any errors that occur during the HTTP request
    print('Error deleting product from cart: $e');
    // You can show a snackbar or other UI notification to inform the user about the error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to delete product from cart. Please try again.'),
      ),
    );
  }
}



//checking product present in the admin cart
Future<bool> checkIfInCart(BuildContext context, String productId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final res = await http.post(
        Uri.parse('$uri/admin/check-cart-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'userId': userProvider.user.id,
          'productId': productId,
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['isInCart'] ?? false;
      } else {
        throw Exception('Failed to check product in cart');
      }
    } catch (e) {
      print('Error checking product in cart: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to check product in cart. Please try again.'),
        ),
      );
      return false;
    }
  }


//admin fetch alll orders
 Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
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


  //admin change order status
  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  Future<List<Order>> fetchPendingOrders(BuildContext context) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    http.Response res = await http.get(
      Uri.parse('$uri/admin/pending-orders'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
    );

    List<Order> orders = [];

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        for (var orderJson in jsonDecode(res.body)) {
          orders.add(Order.fromJson(orderJson));
        }
      },
    );

    return orders;
  } catch (e) {
    showSnackBar(context, e.toString());
    return [];
  }
}


//update product details
  void updateProductDetails({
  required BuildContext context,
  required int quantity,
  required int price,
  required int scheduleIndex,
  required String productId,
  required Map<String, dynamic> scheduleOptions,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    http.Response res = await http.post(
      Uri.parse('$uri/admin/update-product-details'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'id': productId,
        'quantity': quantity,
        'price': price,
        'schedule': scheduleOptions['sub-title'][scheduleIndex],
      }),
    );

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        // Handle success, e.g., show a success message
      },
    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}

///present in the shopproductsdetailsscreen
// void updateCartDetails({
//   required int quantity,
//   required int price,
//   required int scheduleIndex,
//   required String productId,
// }) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);

//   try {
//     // Print statements for debugging
//     print('User ID: ${userProvider.user.id}');
//     print('Product ID: $productId');
//     print('Quantity: $quantity');
//     print('Price: $price');
//     print('Schedule Index: $scheduleIndex');
//     print('Schedule: ${widget.schedule['sub-title'][scheduleIndex]}');

//     http.Response res = await http.post(
//       Uri.parse('$uri/admin/update-cart-details'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-auth-token': userProvider.user.token,
//       },
//       body: jsonEncode({
//         'userId': userProvider.user.id,
//         'productId': productId,
//         'quantity': quantity,
//         'price': price,
//         'schedule': widget.schedule['sub-title'][scheduleIndex],
//       }),
//     );

//     httpErrorHandle(
//       response: res,
//       context: context,
//       onSuccess: () {
//         print('Successfully updated cart details');
//         // Handle success, e.g., show a success message
//       },
//     );
//   } catch (e) {
//     showSnackBar(context, e.toString());
//     print('Error updating cart details: $e');
//   }
// }


  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }

//fetching products details based on product id
Future<Map<String, dynamic>> fetchProductDetails(BuildContext context, String productId) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  Map<String, dynamic> productDetails = {};

  try {
    final res = await http.get(
      Uri.parse('http://yourapiurl.com/admin/get-product/$productId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
    );

    if (res.statusCode == 200) {
      productDetails = jsonDecode(res.body);
    } else {
      throw Exception('Failed to load product');
    }
  } catch (e) {
    showSnackBar(context, e.toString());
    // Return empty map or handle error as needed
    return {}; // Empty map or null, depending on your error handling strategy
  }

  return productDetails;
}




  
}


  

