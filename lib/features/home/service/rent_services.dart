import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eshop/models/rentProduct.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:eshop/constants/error_handling.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/constants/utils.dart';

class RentServices {
 Future<List<RentProduct>> fetchCategoryRentProducts({
  required BuildContext context,
  required String category, // Add shopId parameter
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  List<RentProduct> productList = [];
  try {
    http.Response res = await http.get(
      Uri.parse('$uri/api/prod?category=$category'), // Use shopId in URI
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
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          productList.add(
            RentProduct.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        print('shop products fetched: $productList'); // Add print statement
      },
    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return productList;
}


//   Future<RentProduct?> copyProductToRentProduct({
//   required BuildContext context,
//   required String productId,
// }) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//   RentProduct? rentProduct;

//   try {
//     final String userId = userProvider.user.id;
//     print('User ID: $userId'); // Debug print
//     print('Product ID: $productId'); // Debug print

//     http.Response res = await http.post(
//       Uri.parse('$uri/admin/copy-product'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-auth-token': userProvider.user.token,
//       },
//       body: jsonEncode({
//         'id': productId,
//         'userId': userId,
//       }),
//     );

//     httpErrorHandle(
//       response: res,
//       context: context,
//       onSuccess: () {
//         rentProduct = RentProduct.fromJson(jsonDecode(res.body));
//       },
//     );
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }
//   return rentProduct;
// }

//  Future<List<RentProduct>> fetchCategoryRentProducts({
//   required BuildContext context,
//   required String category // Add shopId parameter
// }) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//   List<RentProduct> productList = [];
//   try {
//     http.Response res = await http.get(
//       Uri.parse('$uri/api/product?category=$category'), // Use shopId in URI
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
//             RentProduct.fromJson(
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


}
