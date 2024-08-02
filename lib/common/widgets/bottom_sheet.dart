// import 'package:eshop/constants/global_variables.dart';
// import 'package:eshop/features/home/service/home_services.dart';
// import 'package:eshop/models/product.dart';
// import 'package:eshop/providers/user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';

// import 'package:provider/provider.dart';

// class BottomPage extends StatefulWidget {
//   const BottomPage({Key? key,}) : super(key: key);

//   @override
//   State<BottomPage> createState() => _BottomPageState();
// }

// class _BottomPageState extends State<BottomPage> {

// // int _page = 0;
//   List<Product>? products;
//   bool _isFloatingContainerOpen = false; // Track floating container state
//   final HomeServices homeServices = HomeServices();

//   bool _isItemDetailsOpen = false;
//   List<Map<String, dynamic>> carts = [];

//   @override
//   void initState() {
//     super.initState();
//     // fetchSubCategoryProducts();
//     carts = context.read<UserProvider>().user.cart.cast<Map<String, dynamic>>();
//     _isItemDetailsOpen = false;
//   }

//   void increaseQuantity(Product product) {
//   homeServices.addToCart(
//     context: context,
//     product: product,
//     quantity: 1, // Assuming you add one item at a time
//   ).then((_) {
//     setState(() {
//       _isFloatingContainerOpen = true; // Ensure the floating container is open after adding an item
//     });
//   }).catchError((error) {
//     // Handle error gracefully
//     print('Error adding to cart: $error');
//   });
// }

// void decreaseQuantity(Product product) {
//   homeServices.removeFromCart(
//     context: context,
//     product: product,
//     sourceUserId: '',
//   ).then((_) {
//     setState(() {
//       if (context.read<UserProvider>().user.cart.isEmpty) {
//         _isFloatingContainerOpen = false; // Close the floating container if the cart is empty
//       }
//     });
//   }).catchError((error) {
//     // Handle error gracefully
//     print('Error removing from cart: $error');
//   });
// }

// double calculateCartTotal(List<Map<String, dynamic>> cart) {
//     int sum = 0;
//     double require = 0;
//     double deliveryPrice = 150;
//     cart.forEach((e) {
//       final quantity = e['quantity'] as int?;
//       final product = e['product'] as Map<String, dynamic>?;

//       if (quantity != null && product != null) {
//         final discountPrice = product['discountPrice'] as int?;
//         final price = product['price'] as int;
//         sum += quantity * (discountPrice ?? price);
//         require = deliveryPrice - sum;
//         require = (sum / deliveryPrice).toDouble();

//         if (require > 1) {
//           require = 1;
//         }
//       }
//     });
//     return require;
//   }

//   int addMore(List<Map<String, dynamic>> cart) {
//     int sum = 0;
//     int rem = 0;
//     int require = 0;
//     int deliveryPrice = 150;
//     cart.forEach((e) {
//       final quantity = e['quantity'] as int?;
//       final product = e['product'] as Map<String, dynamic>?;

//       if (quantity != null && product != null) {
//         final discountPrice = product['discountPrice'] as int?;
//         final price = product['price'] as int;
//         // sum += quantity * (discountPrice ?? price);
//         sum += quantity * (discountPrice!);
//         if (sum > deliveryPrice) {
//           rem = 0;
//         } else {
//           rem = deliveryPrice - sum;
//         }
//       }
//     });
//     return rem;
//   }

//   @override
//   Widget build(BuildContext context) {

//       final cart = context.watch<UserProvider>().user.cart;
//         final carts =
//         context.read<UserProvider>().user.cart.cast<Map<String, dynamic>>();
//     final percent = calculateCartTotal(carts);
//     final rem = addMore(carts);

//     // Toggle floating container state based on cart length
//     if (carts.length >= 1 && !_isFloatingContainerOpen) {
//       _isFloatingContainerOpen = true;
//     }

//     return  Column(
//       children: [
//          if (_isItemDetailsOpen && carts.length > 1)
//         Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: GestureDetector(

//                     onTap: () {
//                       setState(() {
//                          context
//             .read<UserProvider>()
//             .user
//             .cart
//             .cast<Map<String, dynamic>>(); // Update local cart state
//                         _isItemDetailsOpen = false;
//                       });
//                     },
//                     child: Container(
//                       // height: 400,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(20), // Rounded upper corners
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 6,
//                             offset: const Offset(0, -4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Container(
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(0),
//                                     child: Container(
//                                       decoration: const BoxDecoration(
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(20),
//                                             topRight: Radius.circular(20)),
//                                         color: GlobalVariables.blueBackground,
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 0),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(10),
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         color: Colors.white),
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               bottom: 10,
//                                                               left: 10,
//                                                               right: 10,
//                                                               top: 10),
//                                                       child: rem == 0
//                                                           ? const Icon(
//                                                               Icons.motorcycle,
//                                                               color: GlobalVariables
//                                                                   .blueTextColor,
//                                                               size: 18,
//                                                             )
//                                                           : const Icon(
//                                                               Icons
//                                                                   .shopping_cart,
//                                                               color: GlobalVariables
//                                                                   .blueTextColor,
//                                                               size: 18,
//                                                             ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 rem == 0
//                                                     ? const Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                             "Yay! you got FREE Delivery",
//                                                             style: TextStyle(
//                                                               color: GlobalVariables
//                                                                   .blueTextColor,
//                                                               fontFamily:
//                                                                   'Regular',
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                             ),
//                                                           ),
//                                                           Text(
//                                                             'No coupons needed',
//                                                             style: TextStyle(
//                                                               color:
//                                                                   Colors.black,
//                                                               fontFamily:
//                                                                   'Regular',
//                                                               fontSize: 12,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       )
//                                                     : Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           const Text(
//                                                             "Get FREE delivery ",
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               color: GlobalVariables
//                                                                   .blueTextColor,
//                                                               fontFamily:
//                                                                   'Medium',
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                             ),
//                                                           ),
//                                                           // const SizedBox(
//                                                           //   height: 5,
//                                                           // ),
//                                                           Text(
//                                                             'Add products worth ${addMore(carts)} more',
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontFamily:
//                                                                   'Medium',
//                                                               fontSize: 12,
//                                                               color: GlobalVariables
//                                                                   .greyTextColor,
//                                                             ),
//                                                           ),
//                                                           const SizedBox(
//                                                             height: 5,
//                                                           ),

//                                                           Center(
//                                                             child:
//                                                                 LinearPercentIndicator(
//                                                               lineHeight: 3,
//                                                               barRadius:
//                                                                   const Radius
//                                                                       .circular(
//                                                                       10),
//                                                               width: 280,
//                                                               animation: true,
//                                                               animationDuration:
//                                                                   1000, // The duration is in milliseconds
//                                                               percent: percent
//                                                                   .toDouble(),
//                                                               progressColor:
//                                                                   GlobalVariables
//                                                                       .yelloColor,
//                                                               backgroundColor:
//                                                                   Colors.amber[
//                                                                       50],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Divider(
//                                     thickness: 1,
//                                     color: GlobalVariables.dividerColor,
//                                   ),

//                                   Consumer<UserProvider>(
//   builder: (context, userProvider, _) {
//     final carts = userProvider.user.cart;

//     return ListView.separated(
//       itemCount: carts.length,
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       separatorBuilder: (context, index) => Divider(
//         thickness: 1,
//         color: GlobalVariables.dividerColor,
//       ),
//       itemBuilder: (context, index) {
//         final productCart = carts[index];
//         final product = Product.fromMap(productCart['product']);

//         if (product == null) {
//            _isItemDetailsOpen = false;
//           return SizedBox.shrink();
//         }

//         return Padding(
//           padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
//           child: Row(
//             children: [
//               Container(
//                 width: 80,
//                 height: 80,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: InkWell(
//                     onTap: () {},
//                     child: Image.network(
//                       product.images.isNotEmpty ? product.images[0] : '',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product.name,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Regular',
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           (product.quantity?.toInt()).toString(),
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: GlobalVariables.greyTextColor,
//                             fontWeight: FontWeight.normal,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                     Spacer(),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.all(10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: GlobalVariables.greenColor,
//                                     width: 1.5,
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: GlobalVariables.greenColor,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     InkWell(
//                                       onTap: () => decreaseQuantity(product),
//                                       child: Container(
//                                         width: 25,
//                                         height: 25,
//                                         alignment: Alignment.center,
//                                         child: Icon(
//                                           Icons.remove,
//                                           size: 15,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                     DecoratedBox(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: GlobalVariables.greenColor,
//                                           width: 1.5,
//                                         ),
//                                         color: GlobalVariables.greenColor,
//                                         borderRadius: BorderRadius.circular(0),
//                                       ),
//                                       child: Container(
//                                         width: 25,
//                                         height: 28,
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           productCart['quantity'].toString(),
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: 'Medium',
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     InkWell(
//                                       onTap: () => increaseQuantity(product),
//                                       child: Container(
//                                         width: 20,
//                                         height: 20,
//                                         alignment: Alignment.center,
//                                         child: Icon(
//                                           Icons.add,
//                                           size: 15,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '₹${(product.price).toInt()}',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontFamily: 'Regular',
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.lineThrough,
//                                 color: GlobalVariables.greyTextColor,
//                               ),
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               '₹${(product.discountPrice)?.toInt()}',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Regular',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   },
// ),
//                                 ],
//                               ),
//                             ),
//                           ])
//                     ),
//                     ),
//         )
//       ],
//     );

//   }
// }

import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/home/service/home_services.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/providers/user_provider.dart';

class ProductBottomSheet extends StatefulWidget {
  final String productId;

  ProductBottomSheet({required this.productId});

  @override
  _ProductBottomSheetState createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  bool _isFloatingContainerOpen = false;

  @override
  void initState() {
    super.initState();
    // Check if the product is in the cart and set the state accordingly
    Future.microtask(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      _isFloatingContainerOpen = userProvider.isInCart(widget.productId);
      setState(() {});

      print("Product in Cart: $_isFloatingContainerOpen");
      print("User Cart: ${userProvider.user.cart}");
    });
  }

  int addMore(List<Map<String, dynamic>> cart) {
    int sum = 0;
    int rem = 0;
    int require = 0;
    int deliveryPrice = 150;
    cart.forEach((e) {
      final quantity = e['quantity'] as int?;
      final product = e['product'] as Map<String, dynamic>?;

      if (quantity != null && product != null) {
        final discountPrice = product['discountPrice'] as int?;
        final price = product['price'] as int;
        // sum += quantity * (discountPrice ?? price);
        sum += quantity * (discountPrice!);
        if (sum > deliveryPrice) {
          rem = 0;
        } else {
          rem = deliveryPrice - sum;
        }
      }
    });
    return rem;
  }

  double calculateCartTotal(List<Map<String, dynamic>> cart) {
    int sum = 0;
    double require = 0;
    double deliveryPrice = 150;
    cart.forEach((e) {
      final quantity = e['quantity'] as int?;
      final product = e['product'] as Map<String, dynamic>?;

      if (quantity != null && product != null) {
        final discountPrice = product['discountPrice'] as int?;
        final price = product['price'] as int;
        sum += quantity * (discountPrice ?? price);
        require = deliveryPrice - sum;
        require = (sum / deliveryPrice).toDouble();

        if (require > 1) {
          require = 1;
        }
      }
    });
    return require;
  }

  void increaseQuantity(Product product) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.incrementQuantity(product.id);
    print("Increased Quantity: ${product.id}");
  }

  void decreaseQuantity(Product product) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.decrementQuantity(product.id);
    print("Decreased Quantity: ${product.id}");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final carts =
        context.read<UserProvider>().user.cart.cast<Map<String, dynamic>>();
    final percent = calculateCartTotal(carts);
    final rem = addMore(carts);
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final carts = userProvider.user.cart;
        print("Building ProductBottomSheet: $carts");

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: GlobalVariables.blueBackground,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10, top: 10),
                              child: rem == 0
                                  ? const Icon(
                                      Icons.motorcycle,
                                      color: GlobalVariables.blueTextColor,
                                      size: 18,
                                    )
                                  : const Icon(
                                      Icons.shopping_cart,
                                      color: GlobalVariables.blueTextColor,
                                      size: 18,
                                    ),
                            ),
                          ),
                        ),
                        rem == 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Yay! you got FREE Delivery',
                                    style: TextStyle(
                                      color: GlobalVariables.blueTextColor,
                                      fontFamily: 'Regular',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'No coupons needed',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Regular',
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 Text(
                                    "Get FREE delivery  ${rem}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: GlobalVariables.blueTextColor,
                                      fontFamily: 'Medium',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   height: 5,
                                  // ),
                                  Text(
                                    'Add products worth  more',
                                    style: const TextStyle(
                                      fontFamily: 'Medium',
                                      fontSize: 12,
                                      color: GlobalVariables.greyTextColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Center(
                                    child: LinearPercentIndicator(
                                      lineHeight: 3,
                                      barRadius: const Radius.circular(10),
                                      width: 280,
                                      animation: true,
                                      animationDuration:
                                          1000, // The duration is in milliseconds
                                      percent: percent.toDouble(),
                                      progressColor: GlobalVariables.yelloColor,
                                      backgroundColor: Colors.amber[50],
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                // Add your custom UI elements here
                // Divider(
                //   thickness: 1,
                //   color: Colors.grey[400],
                // ),
                SizedBox(height: 70,),
                ListView.separated(
                  itemCount: carts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                    color: GlobalVariables.dividerColor,
                  ),
                  itemBuilder: (context, index) {
                    final productCart = carts[index];
                    print("Cart Item: $productCart");

                    final productData = productCart['product'];
                    print("Mapping product: $productData");

                    if (productData == null) {
                      print(
                          "Error: Product data is null for cart item: $productCart");
                      return Container(); // Return an empty container for this item
                    }

                    final requiredFields = [
                      'discountPrice',
                      'name',
                      'quantity',
                      'images',
                      'price',
                      '_id'
                    ];

                    for (var field in requiredFields) {
                      if (!productData.containsKey(field)) {
                        print(
                            "Error: Missing field '$field' in product data: $productData");
                        return Container(); // Return an empty container for this item
                      }
                    }

                    final product = Product.fromMap(productData);

                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                product.images.isNotEmpty
                                    ? product.images[0]
                                    : 'https://via.placeholder.com/150',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Regular'),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      (product.quantity).toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: GlobalVariables.greyTextColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: GlobalVariables
                                                      .greenColor,
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    GlobalVariables.greenColor),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    decreaseQuantity(product);
                                                    setState(() {});
                                                  },
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
                                                        color: GlobalVariables
                                                            .greenColor,
                                                        width: 1.5),
                                                    color: GlobalVariables
                                                        .greenColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                  child: Container(
                                                    width: 25,
                                                    height: 28,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      productCart['quantity']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Medium',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () =>
                                                      increaseQuantity(product),
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
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
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // '₹${(product.price).toInt()}',
                                          '₹${(product.price)?.toInt()}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Regular',
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: GlobalVariables
                                                  .greyTextColor),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '₹${(product.discountPrice)?.toInt()}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
