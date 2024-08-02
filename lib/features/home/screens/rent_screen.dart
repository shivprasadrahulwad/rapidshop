// import 'package:flutter/material.dart';
// import 'package:shop/features/home/widgets/address_box.dart';
// import 'package:shop/features/home/widgets/carousel_image.dart';
// import 'dart:async';

// import 'package:shop/features/home/widgets/top_categories.dart';
// import 'package:shop/features/search/screens/search_screen.dart';

// class RentScreen extends StatefulWidget {
//   static const String routeName = '/rent';
//   const RentScreen({Key? key}) : super(key: key);

//   @override
//   State<RentScreen> createState() => _RentScreenState();
// }

// class _RentScreenState extends State<RentScreen> {
//   late Stream<String> _hintStream;
//   late StreamSubscription<String> _hintSubscription;
//   String currentHint = "Search For Home"; // Default hint text

//   void navigateToSearchScreen(String query) {
//     Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _hintStream = hintStream();
//     _hintSubscription = _hintStream.listen((hint) {
//       setState(() {
//         currentHint = hint;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _hintSubscription.cancel();
//     super.dispose();
//   }

// Stream<String> hintStream() async* {
//   while (true) {
//     yield "Search for 'Hostel'";
//     await Future.delayed(Duration(seconds: 2));
//     yield "Search for '1BHK'";
//     await Future.delayed(Duration(seconds: 2));
//     yield "Search for '2BHK'";
//     await Future.delayed(Duration(seconds: 2));
//     yield "Search for '1RK'";
//     await Future.delayed(Duration(seconds: 2));
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 250,
//               decoration: BoxDecoration(
//                 color: Colors.grey.withOpacity(0.4),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AddressBox() ,
//                     const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             // mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                           Text("Hello, Shivam",style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 20
//                           ),),
//                             ],
//                           ),
//                           Icon(
//                               Icons.account_balance_outlined,
//                               color: Colors.black,
//                               size: 30,
//                             ),
//                         ],
//                       ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
                          
//                           child: TextFormField(
//                              onFieldSubmitted: navigateToSearchScreen,
//                             decoration: InputDecoration(
//                               prefixIcon: Padding(
//                                 padding: EdgeInsets.all(10.0),
//                                 child: Icon(
//                                   Icons.search,
//                                   color: Colors.black,
//                                   size: 23,
//                                 ),
//                               ),
//                               filled: true,
//                               fillColor: Colors.transparent,
//                               contentPadding: EdgeInsets.only(top: 10),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(7),
//                                 ),
//                                 borderSide: BorderSide(
//                                   color: Colors.black38,
//                                   width: 1,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(15),
//                                 ),
//                                 borderSide: BorderSide(
//                                   color: Colors.black38,
//                                   width: 1,
//                                 ),
//                               ),
//                               hintText: currentHint,
//                               hintStyle: TextStyle(
//                                 fontWeight: FontWeight.normal,
//                                 fontSize: 17,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     // RentTopCategories() widget here
//                     RentTopCategories(),
//                   ],
//                 ),
//               ),
//             ),
//             // CarouselImage() widget here
//             CarouselImage(),
//             const SizedBox(height: 10),
//             // What's On Your Mind? widget here
//             Padding(
//               padding: EdgeInsets.only(left: 20, top: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     "What's On Your Mind?",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Opacity(
//                     opacity: 0.9,
//                     child: Container(
//                       height: 2,
//                       width: 150,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                           colors: [
//                             Colors.black.withOpacity(0.8),
//                             Colors.black.withOpacity(0.5),
//                             Colors.black.withOpacity(0.3),
//                             Colors.black.withOpacity(0.2),
//                             Colors.black.withOpacity(0.09),
//                             Colors.black.withOpacity(0.05),
//                             Colors.black.withOpacity(0.02),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             RentTopCategories(),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.all(4),
//                       child: Material(
//                         elevation: 5.0,
//                         borderRadius: BorderRadius.circular(20),
//                         child: Container(
//                           padding: const EdgeInsets.all(14),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset(
//                                 "images/canva.png",
//                                 height: 230,
//                                 width: 290,
//                                 fit: BoxFit.cover,
//                               ),
//                               Text("Veggie Taco Hash"),
//                               const SizedBox(height: 5.0),
//                               Text("Fresh and Healthy"),
//                               const SizedBox(height: 5.0),
//                               Text("\$25"),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.all(4),
//                       child: Material(
//                         elevation: 5.0,
//                         borderRadius: BorderRadius.circular(20),
//                         child: Container(
//                           padding: const EdgeInsets.all(14),
//                           child: Column(  
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset(
//                                 "images/canva.png",
//                                 height: 230,
//                                 width: 290,
//                                 fit: BoxFit.cover,
//                               ),
//                               Text("Another Item"),
//                               const SizedBox(height: 5.0),
//                               Text("Description"),
//                               const SizedBox(height: 5.0),
//                               Text("\$30"),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Add more containers similarly
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }