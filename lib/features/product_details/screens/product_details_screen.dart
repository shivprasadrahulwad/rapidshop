// import 'package:flutter/material.dart';
// import 'package:shop/common/widgets/loader.dart';
// import 'package:shop/constants/global_variables.dart';
// import 'package:shop/features/home/service/home_services.dart';
// import 'package:shop/features/home/widgets/carousel_image.dart';
// import 'package:shop/features/search/screens/search_screen.dart';
// import 'package:shop/models/product.dart';

// class ProductDetailScreen extends StatefulWidget {
//   static const String routeName = '/product-details';
//   final Product product;
//   final String shopId;

//   const ProductDetailScreen({Key? key, required this.product, required this.shopId}) : super(key: key);

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   List<Product>? productList;
//   final HomeServices homeServices = HomeServices();
//   void navigateToSearchScreen(String  query){
//     Navigator.pushNamed(context, SearchScreen.routeName , arguments: query);
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchshopProducts();
//   }

//   fetchshopProducts() async {
//     productList = await homeServices.fetchshopProducts(
//       context: context,
//       shopId: widget.shopId,
//     );
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               height: 300, // Height of the main container
//               decoration: const BoxDecoration(
//                 gradient: GlobalVariables.appBarGradient,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         alignment: Alignment.center,
//                         child: const Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 5),
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             // Product details column
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.only( ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Product name
//                                     Row(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Expanded(
//                                           child:Text(
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       widget.product.shopName,
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Poppins',
//                                       ),
//                                     ), 
//                                         ),

//                                         SizedBox(width: 5), // Adjust spacing between shop name and rating icon
//             Column(
//               children: [
//                 Container(
//                   height: 30,
//                   width: 60,
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 6, 108, 10), // Background color
//                     borderRadius: BorderRadius.circular(8), 
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(5),
//                     child: Row(
//                       children: [
//                         Icon(
//                       Icons.star,
//                       color: const Color.fromARGB(255, 255, 255, 255),
//                       size: 20,
//                     ),
//                     SizedBox(width: 5,),
//                     Text(
//                       '4.4', // Assuming rating is a double value
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.white,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 5,), // Adjust spacing between rating icon and text
//                 Text(
//                   '100+ ratings',
//                   style: const TextStyle(
//                     fontSize: 10,
//                     color: Colors.grey,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               ],
//             ),
//                                       ],
//                                     ),
//                                     // Product description
//                                     SizedBox(height: 10,),
//                                     Text(
//                                       widget.product.shopDescription,
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                         fontFamily: 'Poppins',
//                                         fontStyle: FontStyle.normal,
//                                       ),
//                                     ),
//                                     // Product price
//                                     // Text(
//                                     //   '\₹${product.price}',
//                                     //   style: const TextStyle(
//                                     //     fontSize: 16,
//                                     //     fontWeight: FontWeight.bold,
//                                     //     fontFamily: 'Poppins',
//                                     //   ),
//                                     // ),
//                                     Row(
//           children: [
//             Icon(
//               Icons.star,
//               color: Colors.amber,
//               size: 20,
//             ),
//             Text(
//               '4.4(100+).', // Assuming rating is a double value
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.black,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//              Text(
//                                       // widget.product.quantity,
//                                       '10-15 mins',
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.black,
//                                         fontFamily: 'Poppins',
//                                         fontStyle: FontStyle.normal,
//                                         fontWeight: FontWeight.bold
//                                       ),
//                                     ),
//           ],
//         ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Text "Menu" with images
//             SizedBox(height: 10,),
//             CarouselImageshort(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'images/pizza.png',
//                   height: 20,
//                   width: 20,
//                   // Adjust height and width as needed
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Text(
//                     "Menu",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Image.asset(
//                   'images/pizza.png',
//                   height: 20,
//                   width: 20,
//                   // Adjust height and width as needed
//                 ),
//               ],
//             ),
//             // Container provided below the "Menu" text
//             Container(
//               height: 42,
//               margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
//               decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.4), // Set background color here
//               borderRadius: BorderRadius.circular(15), // Adjust border radius as needed
//             ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       onFieldSubmitted: navigateToSearchScreen,
//                       decoration: const InputDecoration(
//                         prefixIcon: Padding(
//                           padding: EdgeInsets.all(10.0),
//                           child: Icon(
//                             Icons.search,
//                             color: Colors.black,
//                             size: 23,
//                           ),
//                         ),
//                         suffixIcon: Padding(
//                           padding: EdgeInsets.all(10.0),
//                           child: Icon(
//                             Icons.mic,
//                             color: Colors.black,
//                             size: 23,
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: Colors.transparent,
//                         contentPadding: EdgeInsets.only(top: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(7),
//                           ),
//                           borderSide: BorderSide.none,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(15),
                            
//                           ),
//                           borderSide: BorderSide(
//                             color: Colors.black38,
//                             width: 1,
//                           ),
//                         ),
//                         hintText: 'Search For dishes',
//                         hintStyle: TextStyle(
//                           fontWeight: FontWeight.normal,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Adding body below search widget
//             Visibility(
//               visible: productList == null,
//               replacement: Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Container(
//                       //   padding: const EdgeInsets.only(top: 30),
//                       //   alignment: Alignment.topLeft,
//                       //   child: Text(
//                       //     '${widget.shopId}'.toUpperCase(),
//                       //     style: const TextStyle(
//                       //       fontSize: 20,
//                       //       fontWeight: FontWeight.bold,
//                       //       fontFamily: 'Poppins',
//                       //     ),
//                       //   ),
//                       // ),
//                       Container(
//                         padding: const EdgeInsets.only(top: 15),
//                         alignment: Alignment.topLeft,
//                         child: const Text(
//                           'Cheesilicious pizzas to make every day extraordinary.',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.normal,
//                             fontFamily: 'Poppins',
//                           ),
//                         ),
//                       ),
  
//                       // Product list view
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: productList!.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           Product product = productList![index];
//                           return GestureDetector(
//                             onTap: () {
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product,shopId: product.shopId,)),
//                               // );
//                             },
//                             child: Container(
//                               height: 200,
//                               margin: const EdgeInsets.only(bottom: 20 ,),
//                               padding: const EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 2,
//                                     blurRadius: 5,
//                                     offset: const Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Product image
//                                   Padding(
//                                     padding: EdgeInsets.only(),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(20),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.5),
//         spreadRadius: 2,
//         blurRadius: 5,
//         offset: const Offset(0, 3),
//       ),
//     ],
//   ),
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(20),
//                                         child: Image.network(
//                                           product.images[0],
//                                           height: 200,
//                                           width: 150,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   // Product details column
//                                   Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(top: 20, left: 10),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           // Product name
//                                           Text(
//                                             product.productName,
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily: 'Poppins',
//                                             ),
//                                           ),
//                                           // Product description
//                                           Text(
//                                             product.productDescription,
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                               fontFamily: 'Poppins',
//                                             ),
//                                           ),

//                                           Row(
//                                           children: [
//                                             Container(
//                                               decoration: BoxDecoration(
//     color: const Color.fromARGB(255, 14, 148, 19), // Background color
//     borderRadius: BorderRadius.circular(10), // Rounded corners
//   ),
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(2),
//                                                 child: Icon(
//                                                             Icons.star,
//                                                             color: const Color.fromARGB(255, 255, 255, 255),
//                                                             size: 15,
//                                                           ),
//                                               ),
//                                             ),
//             SizedBox(width: 5,),
//             Text(
//               '4.4 (100+)', // Assuming rating is a double value
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.black,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//                                           ],
//                                         ),
//                                           // Product price
//                                           Text(
//                                             '\₹${product.quantity}',
//                                             style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily: 'Poppins',
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               child: const Loader(), // Show loader if productList is null
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
