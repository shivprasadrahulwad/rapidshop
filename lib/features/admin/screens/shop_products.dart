// import 'package:flutter/material.dart';
// import 'package:shop/common/widgets/add_button.dart';
// import 'package:shop/constants/global_variables.dart';
// import 'package:shop/features/admin/service/admin_services.dart';
// import 'package:shop/models/product.dart';

// class shopProducts extends StatefulWidget {
//   static const String routeName = '/shop-products';
//   final Map<String, dynamic> category;

//   const shopProducts({Key? key, required this.category}) : super(key: key);

//   @override
//   State<shopProducts> createState() => _shopProductsState();
// }

// class _shopProductsState extends State<shopProducts> {
//   int _page = 0;
//   List<Product>? products;
//   final AdminServices adminServices = AdminServices();

//   @override
//   void initState() {
//     super.initState();
//     fetchSubCategoryProducts();
//   }

//   fetchSubCategoryProducts() async {
//     products = await adminServices.fetchSubCategoryProducts(
//       context: context,
//       subCategory: widget.category['sub-title'][_page],
//     );
//     setState(() {});
//   }

//   Widget _buildProductList() {
//     if (products != null) {
//       return GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Two products in each row
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 0.55, // Adjust the aspect ratio as needed
//         ),
//         padding: const EdgeInsets.all(10),
//         itemCount: products!.length,
//         itemBuilder: (context, index) {
//           return _buildProductCard(products![index]);
//         },
//       );
//     } else {
//       return Center(child: CircularProgressIndicator());
//     }
//   }

//   Widget _buildProductCard(Product product) {
//   return Card(
//     elevation: 2,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: SizedBox(
//       width: MediaQuery.of(context).size.width / 2 - 10, // Set width of each item
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             height: 130, // Set a specific height for the image
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//               child: InkWell(
//                 onTap: () {},
//                 child: Image.asset(
//                   "images/PaniPuri.png",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.name,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   product.quantity,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.black,
//                     fontWeight: FontWeight.normal
//                   ),
//                    maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   product.description,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.black,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                       '₹${product.discountPrice}',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     Stack(
//   children: [
//     Text(
//       '₹${product.price}',
//       style: const TextStyle(
//         fontSize: 13,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     Positioned(
//       left: 0,
//       right: 0,
//       bottom: 0,
//       child: Divider(
//         color: Colors.black, // Choose your desired color
//         thickness: 1, // Adjust thickness as needed
//       ),
//     ),
//   ],
// )

//                       ],
//                     ),
//                     AddProduct(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

//   void updatePage(int page) {
//     setState(() {
//       _page = page;
//       fetchSubCategoryProducts();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Padding(
//               padding: EdgeInsets.only(top: 20, left: 10),
//               child: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//           ),
//           title: Padding(
//             padding: EdgeInsets.only(top: 30),
//             child: Text(
//               '${widget.category['title']}',
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Poppins',
//               ),
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
//                   color: Colors.white,
//                   size: 35,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 60,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: widget.category['sub-title'].length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () => updatePage(index),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Chip(
//                       label: Text(
//                         widget.category['sub-title'][index],
//                         style: TextStyle(
//                           color: _page == index
//                               ? GlobalVariables.selectedNavBarColor
//                               : GlobalVariables.unselectedNavBarColor,
//                         ),
//                       ),
//                       backgroundColor: _page == index
//                           ? const Color.fromARGB(255, 160, 160, 160)
//                           : const Color.fromARGB(0, 170, 23, 23),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: _buildProductList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:eshop/common/widgets/add_button.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/service/admin_services.dart';
import 'package:eshop/models/product.dart';

class shopProducts extends StatefulWidget {
  static const String routeName = '/shop-products';
  final Map<String, dynamic> category;

  const shopProducts({Key? key, required this.category}) : super(key: key);

  @override
  State<shopProducts> createState() => _shopProductsState();
}

class _shopProductsState extends State<shopProducts> {
  int _page = 0;
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchSubCategoryProducts();
  }

  fetchSubCategoryProducts() async {
    products = await adminServices.fetchSubCategoryProducts(
      context: context,
      subCategory: widget.category['sub-title'][_page],
    );
    setState(() {});
  }

  Widget _buildProductList() {
    if (products != null) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two products in each row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.55,
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
      width: MediaQuery.of(context).size.width / 2 - 10, // Set width of each item
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 130, // Set a specific height for the image
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  "images/PaniPuri.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.quantity.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '₹${product.discountPrice}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Stack(
                          children: [
                            Text(
                              '₹${product.price}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Divider(
                                color: Colors.black, // Choose your desired color
                                thickness: 1, // Adjust thickness as needed
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    AddProduct(productId: product.id!), // Pass productId here
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              '${widget.category['title']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
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
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.category['sub-title'].length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => updatePage(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Chip(
                      label: Text(
                        widget.category['sub-title'][index],
                        style: TextStyle(
                          color: _page == index
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.unselectedNavBarColor,
                        ),
                      ),
                      backgroundColor: _page == index
                          ? const Color.fromARGB(255, 160, 160, 160)
                          : const Color.fromARGB(0, 170, 23, 23),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _buildProductList(),
          ),
        ],
      ),
    );
  }
}

