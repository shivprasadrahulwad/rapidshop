// import 'package:flutter/material.dart';
// import 'package:shop/models/user.dart';

// class UserProvider extends ChangeNotifier {
//   User _user = User(
//     id: '',
//     name: '',
//     email: '',
//     password: '',
//     address: '',
//     type: '',
//     token: '',
//     cart: [],
//   );

//   User get user => _user;

//   void setUser(String user) {
//     _user = User.fromJson(user);
//     notifyListeners();
//   }

//   void getUserData() {}

//   void setUserFromModel(User user) {
//     _user = user;
//     notifyListeners();
//   }
// }

import 'package:eshop/models/order.dart';
import 'package:eshop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:eshop/models/user.dart';




class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  void addItemToCart(Map<String, dynamic> product) {
    final existingItemIndex =
        _user.cart.indexWhere((item) => item['id'] == product['id']);
    if (existingItemIndex >= 0) {
      _user.cart[existingItemIndex]['quantity'] += product['quantity'];
    } else {
      _user.cart.add(product);
    }
    notifyListeners();
  }

  void removeItemFromCart(String productId) {
    _user.cart.removeWhere((item) => item['id'] == productId);
    notifyListeners();
  }

  void decrementQuantity(String productId) {
    final index = user.cart.indexWhere((item) => item['id'] == productId);
    if (index != -1 && user.cart[index]['quantity'] > 0) {
      user.cart[index]['quantity']--;
      if (user.cart[index]['quantity'] == 0) {
        removeItemFromCart(productId);
      } else {
        notifyListeners();
      }
    }
  }

  void incrementQuantity(String productId) {
    final index = user.cart.indexWhere((item) => item['id'] == productId);
    if (index != -1) {
      user.cart[index]['quantity']++;
      notifyListeners();
    }
  }

  bool isInCart(String productId) {
    return _user.cart.any((item) => item['id'] == productId);
  }

  int? getCartQuantity(String productId) {
    final existingItem = _user.cart.firstWhere(
      (item) => item['id'] == productId,
      orElse: () => {'quantity': null},
    );
    return existingItem['quantity'];
  }

  void updateCartQuantity(String productId, int quantity) {
    final existingItemIndex = _user.cart.indexWhere((item) => item['id'] == productId);
    if (existingItemIndex >= 0) {
      _user.cart[existingItemIndex]['quantity'] = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _user = _user.copyWith(cart: []);
    notifyListeners();
  }
}





// class OrderProvider extends ChangeNotifier {
//   Order _order = Order(
//       id: '',
//       quantity: [],
//       instruction: [],
//       userId: '',
//       totalPrice: 0,
//       tips: '',
//       address: '',
//       products: [],
//       orderedAt: 0,
//       status: 0, totalSave: 0, shopId: '') as Order;

//   Order get order => _order;

//   void setUser(String order) {
//     _order = User.fromJson(order.toString()) as Order;
//     notifyListeners();
//   }

//   void getUserData() {}

//   void setUserFromModel(User order) {
//     _order = order as Order;
//     notifyListeners();
//   }

//   // void clearCart() {
//   //   _order = _order.copyWith(products: []);
//   //   notifyListeners();
//   // }
// }


// class OrderProvider extends ChangeNotifier {
//   Order _order = Order(
//     id: '',
//     quantity: [],
//     instruction: [],
//     userId: '',
//     totalPrice: 0,
//     tips: '',
//     address: '',
//     products: [],
//     orderedAt: 0,
//     status: 0, 
//     totalSave: 0, 
//     shopId: '',
//   );

//   Order get order => _order;

//   void setOrder(Order order) {
//     _order = order;
//     notifyListeners();
//   }

//   void updateOrderStatus(int newStatus) {
//     _order = _order.copyWith(status: newStatus);
//     notifyListeners();
//   }

//   void getUserData() {
//     // Implement the logic to fetch user data if needed
//   }

//   void setOrderFromModel(Order order) {
//     _order = order;
//     notifyListeners();
//   }

//   // Optional method to clear the order
//   void clearOrder() {
//     _order = Order(
//       id: '',
//       quantity: [],
//       instruction: [],
//       userId: '',
//       totalPrice: 0,
//       tips: '',
//       address: '',
//       products: [],
//       orderedAt: 0,
//       status: 0, 
//       totalSave: 0, 
//       shopId: '',
//     );
//     notifyListeners();
//   }
// }


class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, int newStatus) {
    int index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      _orders[index] = _orders[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }

Order? getOrderById(String orderId) {
  try {
    return _orders.firstWhere((order) => order.id == orderId);
  } catch (e) {
    return null;
  }
}

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}