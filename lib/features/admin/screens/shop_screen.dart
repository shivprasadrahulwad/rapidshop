// import 'package:eshop/common/widgets/add_button.dart';
// import 'package:eshop/constants/global_variables.dart';
// import 'package:eshop/features/admin/service/admin_services.dart';
// import 'package:eshop/models/product.dart';
// import 'package:eshop/providers/user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class shopScreen extends StatefulWidget {
//   static const String routeName = '/shopScreen';
//   final Map<String, dynamic>? category;

//   const shopScreen({Key? key, required this.category}) : super(key: key);

//   @override
//   _shopScreenState createState() => _shopScreenState();
// }

// class _shopScreenState extends State<shopScreen> {
//   int _page = 0;
//   List<Product>? products;
//   bool _isFloatingContainerOpen = false;
//   final AdminServices adminServices = AdminServices(); // Use AdminServices

//   @override
//   void initState() {
//     super.initState();
//     fetchSubCategoryProducts();
//   }

//   fetchSubCategoryProducts() async {
//     if (widget.category == null) {
//       return;
//     }

//     products = await adminServices.fetchSubCategoryProducts(
//       context: context,
//       subCategory: widget.category!['sub-title'][_page],
//     );
//     setState(() {});
//   }

//   Widget _buildProductList() {
//     if (products != null) {
//       return GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 0.68,
//         ),
//         padding: const EdgeInsets.all(10),
//         itemCount: products!.length,
//         itemBuilder: (context, index) {
//           return _buildProductCard(products![index]);
//         },
//       );
//     } else {
//       return const Center(child: CircularProgressIndicator());
//     }
//   }

//   Widget _buildProductCard(Product product) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width / 2 - 10,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               height: 130,
//               width: 130,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                 ),
//                 child: InkWell(
//                     onTap: () {},
//                     child: Image.network(
//                       product.images.isNotEmpty ? product.images[0] : '',
//                       fit: BoxFit.cover,
//                     )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontFamily: 'SemiBold',
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           Text(
//                             '₹${(product.discountPrice?.toInt())}',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Stack(
//                             children: [
//                               Text(
//                                 '₹${product.price.toInt()}',
//                                 style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                     color: Color.fromARGB(255, 125, 125, 125)),
//                               ),
//                               const Positioned(
//                                 left: 0,
//                                 right: 0,
//                                 bottom: 0,
//                                 child: Divider(
//                                   color: GlobalVariables
//                                       .greyTextColor, // Choose your desired color
//                                   thickness: 1, // Adjust thickness as needed
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       AddProduct(productId: product.id.toString())
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void updatePage(int page) {
//     setState(() {
//       _page = page;
//       fetchSubCategoryProducts();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final carts = context.watch<UserProvider>().user.cart;

//     if (carts.length >= 1 && !_isFloatingContainerOpen) {
//       _isFloatingContainerOpen = true;
//     }

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(),
//           ),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Padding(
//               padding: EdgeInsets.only(
//                 top: 20,
//               ),
//               child: Icon(
//                 Icons.arrow_back,
//                 color: Color.fromARGB(255, 0, 0, 0),
//                 size: 25,
//               ),
//             ),
//           ),
//           title: Padding(
//             padding: const EdgeInsets.only(
//               top: 30,
//             ),
//             child: Text(
//               widget.category?['title'] ?? 'No Title',
//               style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Regular',
//                   color: Colors.black),
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 // Handle search action
//               },
//               icon: const Padding(
//                 padding: EdgeInsets.only(top: 20, right: 10),
//                 child: Icon(
//                   Icons.search_rounded,
//                   color: Color.fromARGB(255, 0, 0, 0),
//                   size: 25,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 10, right: 10),
//                 child: SizedBox(
//                   height: 50,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: widget.category?['sub-title'].length ?? 0,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () => updatePage(index),
//                         child: Container(
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 5, vertical: 10),
//                           decoration: BoxDecoration(
//                             color: _page == index
//                                 ? Color.fromARGB(255, 243, 253, 244)
//                                 : const Color.fromARGB(255, 255, 255, 255),
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                               color:
//                                   _page == index ? Colors.green : Colors.grey,
//                             ),
//                           ),
//                           child: Text(
//                             widget.category?['sub-title'][index] ??
//                                 'No Sub-Title',
//                             style: TextStyle(
//                                 color: _page == index
//                                     ? Color.fromARGB(255, 0, 0, 0)
//                                     : Colors.black,
//                                 fontWeight: FontWeight.normal,
//                                 fontSize: 12),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: _buildProductList(),
//               ),
//             ],
//           ),
//           // if (_isFloatingContainerOpen)
//           //   Positioned(
//           //     bottom: 16,
//           //     left: 16,
//           //     right: 16,
//           //     child: GestureDetector(
//           //       onTap: () {
//           //         setState(() {
//           //           _isFloatingContainerOpen = false;
//           //         });
//           //       },
//           //       child: Container(
//           //         height: 60,
//           //         decoration: BoxDecoration(
//           //           color: Colors.green,
//           //           borderRadius: BorderRadius.circular(10),
//           //           boxShadow: [
//           //             BoxShadow(
//           //               color: Colors.black.withOpacity(0.2),
//           //               blurRadius: 6,
//           //               offset: const Offset(0, 4),
//           //             ),
//           //           ],
//           //         ),
//           //         child: Padding(
//           //           padding: const EdgeInsets.all(16.0),
//           //           child: Row(
//           //             crossAxisAlignment: CrossAxisAlignment.start,
//           //             children: [
//           //               Text(
//           //                 '${carts.length} Items added',
//           //                 style: const TextStyle(
//           //                     color: Colors.white, fontSize: 16),
//           //               ),
//           //               const Spacer(),
//           //               ElevatedButton(
//           //                 style: ButtonStyle(
//           //                   elevation: MaterialStateProperty.all(0),
//           //                   shadowColor: MaterialStateProperty.all(Colors.transparent),
//           //                   backgroundColor: MaterialStateProperty.all(Colors.green),
//           //                 ),
//           //                 onPressed: () {
//           //                   setState(() {
//           //                     _isFloatingContainerOpen = false;
//           //                   });
//           //                 },
//           //                 child: GestureDetector(
//           //                   onTap: () {
//           //                     Navigator.push(
//           //                       context,
//           //                       MaterialPageRoute(
//           //                           builder: (context) => UserCartProducts(
//           //                               totalPrice: 0, address: '', index: 0,  tips: 0, instruction: [], totalSave: '',)),
//           //                     );
//           //                   },
//           //                   child: const Row(
//           //                     mainAxisAlignment: MainAxisAlignment.center,
//           //                     children: [
//           //                       Text(
//           //                         'View cart',
//           //                         style: TextStyle(
//           //                             fontSize: 16, color: Colors.white),
//           //                       ),
//           //                       SizedBox(width: 8),
//           //                       Icon(
//           //                         Icons.arrow_forward_ios,
//           //                         color: Colors.white,
//           //                         size: 18,
//           //                       ),
//           //                     ],
//           //                   ),
//           //                 ),
//           //               ),
//           //             ],
//           //           ),
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//         ],
//       ),
//     );
//   }
// }



import 'package:eshop/common/widgets/add_button.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/service/admin_services.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  static const String routeName = '/shopScreen';
  final Map<String, dynamic>? category;

  const ShopScreen({Key? key, required this.category}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _page = 0;
  List<Product>? products;
  bool _isFloatingContainerOpen = false;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchSubCategoryProducts();
  }

  Future<void> fetchSubCategoryProducts() async {
    if (widget.category == null) {
      return;
    }

    products = await adminServices.fetchSubCategoryProducts(
      context: context,
      subCategory: widget.category!['sub-title'][_page],
    );
    setState(() {});
  }

  Widget _buildProductList() {
    if (products != null) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: products!.length,
        itemBuilder: (context, index) {
          return _buildProductCard(products![index]);
        },
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 - 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150,
              width: 130,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: InkWell(
                    onTap: () {},
                    child: Image.network(
                      product.images.isNotEmpty ? product.images[0] : '',
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'SemiBold',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '₹${(product.discountPrice?.toInt())}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Stack(
                            children: [
                              Text(
                                '₹${product.price.toInt()}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 125, 125, 125)),
                              ),
                              const Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Divider(
                                  color: GlobalVariables
                                      .greyTextColor, // Choose your desired color
                                  thickness: 1, // Adjust thickness as needed
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      AddProduct(productId: product.id.toString())
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updatePage(int page) {
    setState(() {
      _page = page;
      fetchSubCategoryProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final carts = context.watch<UserProvider>().user.cart;

    if (carts.length >= 1 && !_isFloatingContainerOpen) {
      _isFloatingContainerOpen = true;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Padding(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 0, 0, 0),
                size: 25,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: Text(
              widget.category?['title'] ?? 'No Title',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Regular',
                  color: Colors.black),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Handle search action
              },
              icon: const Padding(
                padding: EdgeInsets.only(top: 20, right: 10),
                child: Icon(
                  Icons.search_rounded,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.category?['sub-title'].length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => updatePage(index),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                            color: _page == index
                                ? Color.fromARGB(255, 243, 253, 244)
                                : const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:
                                  _page == index ? Colors.green : Colors.grey,
                            ),
                          ),
                          child: Text(
                            widget.category?['sub-title'][index] ??
                                'No Sub-Title',
                            style: TextStyle(
                                color: _page == index
                                    ? Color.fromARGB(255, 0, 0, 0)
                                    : Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: _buildProductList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
