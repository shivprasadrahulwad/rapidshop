import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:eshop/constants/utils.dart';
import 'package:eshop/features/admin/screens/fshop_products_detail_screen.dart';
import 'package:eshop/features/admin/service/admin_services.dart';
import 'package:eshop/features/home/service/home_services.dart';
import 'package:eshop/models/product.dart';
import 'package:provider/provider.dart';

class AddButton extends StatefulWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 79, // Set width to match the parent's width
      height: 35,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                count++;
              });
            },
            child: Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                // border: Border.all(color: Colors.green),
              ),
              child: const Icon(Icons.add, color: Colors.green , size: 12,),
            ),
          ),
          // Display "ADD" text or count based on the count value
          count == 0
              ? GestureDetector(
                onTap: () {
              setState(() {
                count++;
              });
            },
                child: const Text(
                    "ADD",
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
              )
              : Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (count > 0) {
                  count--;
                }
              });
            },
            child: Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                // border: Border.all(color: Colors.green),
              ),
              child: const Icon(Icons.remove, color: Colors.green  , size: 12,),
            ),
          ),
        ],
      ),
    );
  }
}



class AddProduct extends StatelessWidget {
  final String productId;

  const AddProduct({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AdminServices().checkIfInCart(context, productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          bool isInCart = snapshot.data ?? false;

          return isInCart
              ? SizedBox.shrink() // No button if product is already in cart
              : GestureDetector(
                  onTap: () => _addToCart(context, productId),
                  child: Container(
                    width: 60,
                    height: 30,
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.green),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'ADD',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SemiBold',
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
        }
      },
    );
  }

  void _addToCart(BuildContext context, String productId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final homeServices = HomeServices();
      final adminServices = AdminServices();
      final product = await homeServices.fetchProductById(context, productId);

      if (product != null) {
        userProvider.addItemToCart({
          'id': productId,
          'quantity': 1,
          'product': product.toMap(),
        });

        // Add to backend cart
        final result = await adminServices.copyProductToAdminCart(
          context: context,
          productId: productId,
        );

        if (result != null) {
          showSnackBar(context, 'Product added to cart successfully');
        } else {
          showSnackBar(context, 'Failed to add product to backend cart');
        }
      } else {
        showSnackBar(context, 'Product not found');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}



// class AddProduct extends StatelessWidget {
//   final String productId;

//   const AddProduct({
//     Key? key,
//     required this.productId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProvider>(
//       builder: (context, userProvider, child) {
//         bool isInCart = userProvider.isInCart(productId);

//         return GestureDetector(
//           onTap: () => isInCart
//               ? _removeFromCart(context, userProvider, productId)
//               : _addToCart(context, userProvider, productId),
//           child: Container(
//             width: 60,
//             height: 30,
//             padding: const EdgeInsets.all(4.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               border: Border.all(color: Colors.green),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               isInCart ? 'REM' : 'ADD',
//               style: const TextStyle(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'SemiBold',
//                 color: Colors.green,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _addToCart(BuildContext context, UserProvider userProvider, String productId) async {
//     try {
//       final homeServices = HomeServices();
//       final product = await homeServices.fetchProductById(context, productId);
//       if (product != null) {
//         // Check if the product is already in the cart
//         if (!userProvider.isInCart(productId)) {
//           userProvider.addItemToCart({
//             'id': productId,
//             'quantity': 1,
//             'product': product.toMap(),
//           });
//         } else {
//           showSnackBar(context, 'Product is already in the cart');
//         }
//       } else {
//         showSnackBar(context, 'Product not found');
//       }
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   void _removeFromCart(BuildContext context, UserProvider userProvider, String productId) {
//     userProvider.removeItemFromCart(productId);
//   }

//   void showSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
// }

// class AddProduct extends StatefulWidget {
//   final String productId;

//   const AddProduct({Key? key, required this.productId}) : super(key: key);

//   @override
//   _AddProductState createState() => _AddProductState();
// }

// class _AddProductState extends State<AddProduct> {
//   Future<Product?>? _futureProduct;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _futureProduct = AdminServices().copyProductToAdminCart(
//             context: context,
//             productId: widget.productId,
//           );
//         });
//       },
//       child: Container(
//         width: 60, // Set width to match the parent's width
//         height: 30,
//         padding: const EdgeInsets.all(4.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.0),
//           border: Border.all(color: GlobalVariables.greenColor),
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               "ADD",
//               style: TextStyle(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalVariables.greenColor,
//                 fontFamily: 'SemiBold'
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




class AddCartButton extends StatelessWidget {
  final String productId;
  final String sourceUserId;

  const AddCartButton({
    Key? key,
    required this.productId,
    required this.sourceUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        bool isInCart = userProvider.isInCart(productId);
        int quantity = isInCart ? userProvider.getCartQuantity(productId) ?? 0 : 0;

        return isInCart
            ? Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => decreaseQuantity(context, userProvider),
                            child: Container(
                              width: 25,
                              height: 25,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.remove,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 1.5,
                              ),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Container(
                              width: 25,
                              height: 28,
                              alignment: Alignment.center,
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Medium',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => increaseQuantity(context, userProvider),
                            child: Container(
                              width: 25,
                              height: 25,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.add,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () => _addToCart(context, userProvider, productId, sourceUserId, 1),
                child: Container(
                  width: 60,
                  height: 30,
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SemiBold',
                      color: Colors.green,
                    ),
                  ),
                ),
              );
      },
    );
  }

  void increaseQuantity(BuildContext context, UserProvider userProvider) {
    if (userProvider.isInCart(productId)) {
      userProvider.incrementQuantity(productId);
    } else {
      _addToCart(context, userProvider, productId, sourceUserId, 1);
    }
  }

  void decreaseQuantity(BuildContext context, UserProvider userProvider) {
    if (userProvider.isInCart(productId) && userProvider.getCartQuantity(productId)! > 0) {
      userProvider.decrementQuantity(productId);
    }
  }

  void _addToCart(BuildContext context, UserProvider userProvider, String productId, String sourceUserId, int quantity) async {
    try {
      final homeServices = HomeServices();
      final product = await homeServices.fetchProductById(context, productId);
      if (product != null) {
        userProvider.addItemToCart({
          'id': productId,
          'quantity': quantity,
          'product': product.toMap(),
        });
      } else {
        showSnackBar(context, 'Product not found');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class ViewButton extends StatefulWidget {
  final String productId;

  const ViewButton({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _ViewButtonState createState() => _ViewButtonState();
}

class _ViewButtonState extends State<ViewButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FshopProductDetailsScreen(productId: widget.productId),
          ),
        );
      },
      child: Container(
        width: 79,
        height: 35,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.green),
        ),
        alignment: Alignment.center,
        child: Text(
          'View',
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}



class EditButton extends StatefulWidget {
  final String productId;

  const EditButton({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _EditButtonState createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FshopProductDetailsScreen(productId: widget.productId),
          ),
        );
      },
      child: Container(
        width: 60,
        height: 30,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: GlobalVariables.greenColor),
        ),
        alignment: Alignment.center,
        child: Text(
          'Edit',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'SemiBold',
            color: GlobalVariables.greenColor,
          ),
        ),
      ),
    );
  }
}








class DeleteProduct extends StatelessWidget {
  final String productId;
  final Function(String) onDelete;

  const DeleteProduct({
    Key? key,
    required this.productId,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onDelete(productId),
      child: Container(
        width: 60,
        height: 30,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Color.fromARGB(255, 255, 0, 0)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Delete",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'SemiBold',
                color: Color.fromARGB(255, 255, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// class EditProduct extends StatefulWidget {
//   final String productId;

//   const EditProduct({Key? key, required this.productId}) : super(key: key);

//   @override
//   _EditProductState createState() => _EditProductState();
// }

// class _EditProductState extends State<EditProduct> {
//   Future<RentProduct?>? _futureRentProduct;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _futureRentProduct = RentServices().copyProductToRentProduct(
//             context: context,
//             productId: widget.productId,
//           );
//         });
//       },
//       child: Container(
//         width: 79, // Set width to match the parent's width
//         height: 35,
//         padding: const EdgeInsets.all(4.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.0),
//           border: Border.all(color: Color.fromARGB(255, 255, 0, 0)),
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               "Edit",
//               style: TextStyle(
//                 fontSize: 11.0,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 255, 0, 0),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






class AddshopProduct extends StatefulWidget {
  final String productId;

  const AddshopProduct({Key? key, required this.productId}) : super(key: key);

  @override
  _AddshopProductState createState() => _AddshopProductState();
}

class _AddshopProductState extends State<AddshopProduct> {
  Future<Product?>? _futureProduct;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FshopProductDetailsScreen(productId: '',)),
            );
      },
      child: Container(
        width: 79, // Set width to match the parent's width
        height: 35,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.green),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "ADD",
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
