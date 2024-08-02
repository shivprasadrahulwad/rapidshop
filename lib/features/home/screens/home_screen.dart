// import 'package:shop/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shop/common/widgets/horizontal_line.dart';
// import 'package:shop/common/widgets/profile.dart';
// import 'package:shop/features/home/screens/best_sellers.dart';
// import 'package:shop/features/home/screens/season_offer.dart';
// import 'package:shop/features/home/widgets/carousel_image.dart';
// import 'package:shop/features/home/widgets/top_categories.dart';
// // Import your details screen if not already imported
// import 'package:shop/providers/user_provider.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:timezone/timezone.dart' as tz;

// class HomeScreen extends StatefulWidget {
//   static const String routeName = '/home';
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // void navigateToSearchScreen(String query) {
//   //   Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
//   // }

//   // String userId = '6652bfc64e869c021acf688c';
//   String userId = '667c4e8e2f6dec6e82d1ada9';

//   void showNotification() async {
//     AndroidNotificationDetails androidDetails =
//         const AndroidNotificationDetails(
//       "notifications-youtube",
//       "YouTube Notifications",
//       priority: Priority.max,
//       importance: Importance.max,
//       visibility: NotificationVisibility.public,
//     );

//     DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     NotificationDetails notiDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     await notificationsPlugin.show(0, "Never Tried Mauli's ,Masala Dosa? 🫠",
//         'Life is too short not to be!😜', notiDetails);

//     DateTime scheduleDate = DateTime.now().add(const Duration(seconds: 5));

//     await notificationsPlugin.zonedSchedule(
//         0,
//         "Sample Notification",
//         "This is a notification",
//         tz.TZDateTime.from(scheduleDate, tz.local),
//         notiDetails,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.wallClockTime,
//         androidAllowWhileIdle: true,
//         payload: "notification-payload");
//   }

//   void checkForNotification() async {
//     NotificationAppLaunchDetails? details =
//         await notificationsPlugin.getNotificationAppLaunchDetails();

//     if (details != null) {
//       if (details.didNotificationLaunchApp) {
//         NotificationResponse? response = details.notificationResponse;

//         if (response != null) {
//           String? payload = response.payload;
//           // log("Notification Payload: $payload" as num);
//         }
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     checkForNotification();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context).user;
//     return Scaffold(
//       // drawer: const Profile(),
//       // appBar: AppBar(
//       //   // title: const Text("Sairam"),
//       // ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 370,
//               decoration: BoxDecoration(
//                 //             image: DecorationImage(
//                 //   image: AssetImage("images/canva.png"),
//                 //   fit: BoxFit.cover,
//                 // ),
//                 color:
//                     Colors.grey.withOpacity(0.4), // Set background color here
//                 borderRadius:
//                     BorderRadius.circular(20), // Adjust border radius as needed
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // const AddressBox(),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 20,
//                         right: 20,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             // mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Hello ,${user.name}",
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w500, fontSize: 20),
//                               ),
//                             ],
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pushNamed(context,
//                                   '/account'); // Replace '/account' with your actual route name for the AccountScreen
//                             },
//                             child: const Icon(
//                               Icons.account_circle,
//                               color: Colors.black,
//                               size: 30,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20, right: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               // onFieldSubmitted: navigateToSearchScreen,
//                               decoration: const InputDecoration(
//                                 prefixIcon: Padding(
//                                   padding: EdgeInsets.all(10.0),
//                                   child: Icon(
//                                     Icons.search,
//                                     color: Colors.black,
//                                     size: 23,
//                                   ),
//                                 ),
//                                 filled: true,
//                                 fillColor: Colors.transparent,
//                                 contentPadding: EdgeInsets.only(top: 10),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(7),
//                                   ),
//                                   // borderSide: BorderSide.none,
//                                   borderSide: BorderSide(
//                                     // Adjust this line to specify border color and width
//                                     color: Colors
//                                         .black38, // Change the color to make the border visible
//                                     width: 1, // Adjust the width as needed
//                                   ),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(15),
//                                   ),
//                                   borderSide: BorderSide(
//                                     color: Colors.black38,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 hintText: 'Search For dishes',
//                                 hintStyle: TextStyle(
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: 17,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const CarouselImage(),
//                     SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 20, top: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Bestsellers",
//                     style: TextStyle(
//                       fontSize: 16, // Adjust font size as needed
//                       fontWeight:
//                           FontWeight.bold, // Adjust font weight as needed
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   HorizontalLine(),
//                 ],
//               ),
//             ),

//             const BestSellers(),

//             // const TopCategories(),
//             // const SizedBox(height: 10),
//             // const SizedBox(height: 10),
//             // const RentTopCategories(),
//             //  GrocerySubCategories(subCategories: GlobalVariables.groceryImages),

//             const SizedBox(height: 10),
//             const Padding(
//               padding: EdgeInsets.only(left: 20, top: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Offer Price",
//                     style: TextStyle(
//                       fontSize: 16, // Adjust font size as needed
//                       fontWeight:
//                           FontWeight.bold, // Adjust font weight as needed
//                     ),
//                   ),
//                   SizedBox(width: 10), // Add spacing between text and divider
//                   HorizontalLine(),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const SeasonOffer(),
//             const SizedBox(height: 20),
//             // GrocerySubCategories(),
//             const SizedBox(height: 20),
//             const TopCategories(),
//             const SizedBox(height: 20),
//             const Text("Grocery & Kitchen"),
//             const HorizontalLine(),
//             // const SizedBox(height: 20),
//             // const GroceryCategories(),
//             const SizedBox(height: 20),
//             Grocery(userId: userId),
//             const SizedBox(height: 20),
//             const Text("Beauty & Personal Care"),
//             const HorizontalLine(),
//             const SizedBox(height: 20),
//             const BeautyCategories(),
//             const SizedBox(height: 20),
//             const Text("Snacks"),
//             const SizedBox(height: 20),
//             const SeasonOffer(),
            
           

//             // Orders(),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showNotification,
//         child: const Icon(Icons.notification_add),
//       ),
//     );
//   }
// }
