import 'package:eshop/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    
    // Add null checks before accessing 'quantity' and 'product'
    user.cart.forEach((e) {
      final quantity = e['quantity'] as int?;
      final product = e['product'] as Map<String, dynamic>?;

      if (quantity != null && product != null && product['discountPrice'] != null) {
        sum += quantity * product['discountPrice'] as int;
      }else{
        sum += quantity! * product?['price'] as int;
      }
    });

    return Container(
      margin: const EdgeInsets.all(0),
      child: Row(
        children: [
          const Text(
            "",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            '\₹$sum',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}




class CartTotal extends StatelessWidget {
  const CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 10;
    
    // Add null checks before accessing 'quantity' and 'product'
    user.cart.forEach((e) {
      final quantity = e['quantity'] as int?;
      final product = e['product'] as Map<String, dynamic>?;

      if (quantity != null && product != null && product['discountPrice'] != null) {
        sum += quantity * product['discountPrice'] as int;
      }else{
        sum += quantity! * product?['price'] as int;
      }
    });

    return Container(
      margin: const EdgeInsets.all(0),
      child: Row(
        children: [
          const Text(
            "",
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Regular',
            ),
          ),
          Text(
            '\₹${sum.toInt()}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
             
              

            ),
          ),
        ],
      ),
    );
  }
}


int calculateCartTotal(List<Map<String, dynamic>> cart) {
  int sum = 10;
  cart.forEach((e) {
    final quantity = e['quantity'] as int?;
    final product = e['product'] as Map<String, dynamic>?;

    if (quantity != null && product != null && product['discountPrice'] != null) {
      sum += quantity * product['discountPrice'] as int;
    } else {
      sum += quantity! * product?['price'] as int;
    }
  });
  return sum;
}




class CartTotalSaving extends StatelessWidget {
  const CartTotalSaving({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int totalSavings = 0;
    int delivery =150;

    user.cart.forEach((e) {
      final quantity = e['quantity'] as int?;
      final product = e['product'] as Map<String, dynamic>?;

      if (quantity != null && product != null && product['price'] != null && product['discountPrice'] != null) {
        int price = product['price'] as int;
        int discountPrice = product['discountPrice'] as int;
        int savingsPerItem = quantity * (price - discountPrice);
        totalSavings += savingsPerItem;
      }
    }
    
    );
    totalSavings=totalSavings + delivery;

    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            '\₹$totalSavings',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Medium',
              fontWeight: FontWeight.bold,
              color: GlobalVariables.blueTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
