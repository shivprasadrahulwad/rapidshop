// import 'package:flutter/material.dart';
// import 'package:shop/constants/global_variables.dart';
// import 'package:shop/models/product.dart';

// class MessDetailScreen extends StatelessWidget {
//   static const String routeName = '/mess-details';
//   final Product product;

//   const MessDetailScreen({Key? key, required this.product}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               height: 400, // Height of the main container
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
//                         margin: const EdgeInsets.only(bottom: 20),
//                         padding: const EdgeInsets.all(10),
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
//                                 padding: const EdgeInsets.only(top: 20, left: 10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Product name
//                                     Text(
//                                       product.shopName,
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Poppins',
//                                       ),
//                                     ),
//                                     // Product description
//                                     Text(
//                                       product.shopDescription,
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                         fontFamily: 'Poppins',
//                                       ),
//                                     ),
//                                     // Product price
//                                     Text(
//                                       '\₹${product.price}',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Poppins',
//                                       ),
//                                     ),
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
//                     "Todays Menu",
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

//             const Padding(
//               padding: EdgeInsets.only(left: 10,right: 10),
//               child: Row(
//                 children: [
//                   Text("Daal Khichdi With Gulab Jamun . Yumiiiii..............",style: TextStyle(
//                     fontStyle: FontStyle.italic
//                   ),),
                  
//                 ],
//               ),
//             ),


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
//                     "Timing",
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

//             const Padding(
//               padding: EdgeInsets.only(left: 10,right: 10),
//               child: Row(
//                 children: [
//                   Text("Lunch : 12:00 PM To 2:00 PM",style: TextStyle(
//                     fontStyle: FontStyle.italic
//                   ),),
                  
//                 ],
//               ),
//             ),

//              const Padding(
//               padding: EdgeInsets.only(left: 10,right: 10),
//               child: Row(
//                 children: [
//                   Text("Lunch : 8:00 PM To 10:00 PM",style: TextStyle(
//                     fontStyle: FontStyle.italic
//                   ),),
                  
//                 ],
//               ),
//             ),


//             // Container provided below the "Menu" text
          
//           ],
//         ),
//       ),
//     );
//   }
// }
