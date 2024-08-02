// ignore_for_file: dead_code

import 'dart:async';

import 'package:eshop/common/widgets/bottom_sheet.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/screens/user_cart_products.dart';
import 'package:eshop/features/home/service/home_services.dart';
import 'package:eshop/features/search/screens/search_screen.dart';
import 'package:eshop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:eshop/common/widgets/horizontal_line.dart';
import 'package:eshop/features/home/screens/best_sellers.dart';
import 'package:eshop/features/home/screens/season_offer.dart';
import 'package:eshop/features/home/widgets/top_categories.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class FhomeScreen extends StatefulWidget {
  static const String routeName = '/fshop';
  final String shopCode;
  const FhomeScreen({Key? key, required this.shopCode}) : super(key: key);

  @override
  State<FhomeScreen> createState() => _FhomeScreenState();
}

class _FhomeScreenState extends State<FhomeScreen> {
  String currentHint = 'Search Fruits';
  late Stream<String> _hintStream;
  late StreamSubscription<String> _hintSubscription;
  bool _isItemDetailsOpen = false;
  int _page = 0;
  List<Product>? products;
  bool _isFloatingContainerOpen = false; // Track floating container state
  final HomeServices homeServices = HomeServices();
  void navigateToSearchScreen() {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
    );
  }

  final ProductBottomSheet productBottomSheet = ProductBottomSheet(
    productId: '',
  );

  List<Map<String, dynamic>> carts = [];

  // void showNotification() async {
  //   AndroidNotificationDetails androidDetails =
  //       const AndroidNotificationDetails(
  //     "notifications-youtube",
  //     "YouTube Notifications",
  //     priority: Priority.max,
  //     importance: Importance.max,
  //     visibility: NotificationVisibility.public,
  //   );

  //   DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );

  //   NotificationDetails notiDetails = NotificationDetails(
  //     android: androidDetails,
  //     iOS: iosDetails,
  //   );

  //   await notificationsPlugin.show(0, "Never Tried Mauli's ,Masala Dosa? 🫠",
  //       'Life is too short not to be!😜', notiDetails);

  //   DateTime scheduleDate = DateTime.now().add(const Duration(seconds: 5));

  //   await notificationsPlugin.zonedSchedule(
  //       0,
  //       "Sample Notification",
  //       "This is a notification",
  //       tz.TZDateTime.from(scheduleDate, tz.local),
  //       notiDetails,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.wallClockTime,
  //       androidAllowWhileIdle: true,
  //       payload: "notification-payload");
  // }

  // void checkForNotification() async {
  //   NotificationAppLaunchDetails? details =
  //       await notificationsPlugin.getNotificationAppLaunchDetails();

  //   if (details != null) {
  //     if (details.didNotificationLaunchApp) {
  //       NotificationResponse? response = details.notificationResponse;

  //       if (response != null) {
  //         String? payload = response.payload;
  //         // log("Notification Payload: $payload" as num);
  //       }
  //     }
  //   }
  // }

  @override
  void initState() {
    // checkForNotification();
    _hintStream = hintStream();
    carts = context.read<UserProvider>().user.cart.cast<Map<String, dynamic>>();
    _hintSubscription = _hintStream.listen((hint) {
      setState(() {
        currentHint = hint;
      });
    });
    if (carts.isNotEmpty) {
      _isFloatingContainerOpen = true;
    }

    super.initState();
  }

  @override
  void dispose() {
    _hintSubscription.cancel();
    super.dispose();
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ProductBottomSheet(
          productId: '',
        );
      },
    );
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

  Stream<String> hintStream() async* {
    while (true) {
      yield 'Search "Milk"';
      await Future.delayed(const Duration(seconds: 2));
      yield 'Search "Fruits"';
      await Future.delayed(const Duration(seconds: 2));
      yield 'Search "Vegetables"';
      await Future.delayed(const Duration(seconds: 2));
      yield 'Search "Cereals"';
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  void increaseQuantity(Product product) {
    homeServices
        .addToCart(
      context: context,
      product: product,
      quantity: 1, // Assuming you add one item at a time
    )
        .then((_) {
      setState(() {
        // fetchSubCategoryProducts(); // Fetch updated products if needed
        carts = context
            .read<UserProvider>()
            .user
            .cart
            .cast<Map<String, dynamic>>(); // Update local cart state
        _isFloatingContainerOpen =
            true; // Ensure the floating container is open after adding an item
      });
    });
  }

  void decreaseQuantity(Product product) {
    homeServices
        .removeFromCart(
      context: context,
      product: product,
      sourceUserId: '',
    )
        .then((_) {
      setState(() {
        // fetchSubCategoryProducts(); // Fetch updated products if needed
        carts = context
            .read<UserProvider>()
            .user
            .cart
            .cast<Map<String, dynamic>>(); // Update local cart state
        if (carts.isEmpty) {
          _isFloatingContainerOpen =
              false; // Close the floating container if the cart is empty
        }
      });
    });
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final carts =
        context.read<UserProvider>().user.cart.cast<Map<String, dynamic>>();
    final percent = calculateCartTotal(carts);
    final rem = addMore(carts);

    if (carts.isNotEmpty && !_isFloatingContainerOpen) {
      setState(() {
        _isFloatingContainerOpen = true;
      });
    }

    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color:
                        // Colors.grey.withOpacity(0.4), // Set background color here
                        Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Ready in",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "8 minutes",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              fontFamily: 'SemiBold',
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: ' HOME - ',
                                                  style: TextStyle(
                                                    fontFamily: 'SemiBold',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      'Shiv, Behind Apurv Hospital, Nanded',
                                                  style: TextStyle(
                                                    fontFamily: 'Medium',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/account');
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Icon(
                                                Icons.account_circle,
                                                color: Colors.black,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: GestureDetector(
                          onTap: () => navigateToSearchScreen(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black38, width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          currentHint,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            'https://res.cloudinary.com/dybzzlqhv/image/upload/v1720875098/vegetables/swya6iwpohlynuq1r9td.gif',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // // const SeasonOffer(),
                    // const SizedBox(height: 10),

                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bestsellers",
                            style: TextStyle(
                              fontSize: 16, // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                              fontFamily: 'SemiBold',
                            ),
                          ),
                          SizedBox(width: 10),
                          HorizontalLine(),
                        ],
                      ),
                    ),

                    const BestSellers(),

                    SizedBox(
                      height: 10,
                    ),
                    // fshopProducts(),
                    const Text(
                      "Grocery & Kitchen",
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const HorizontalLine(),

                    const SizedBox(height: 20),
                    GroceryCategories(shopCode: widget.shopCode),

                    SizedBox(
                      height: 30,
                    ),
                    // fshopProducts(),
                    const Text(
                      "Beauty & Personal Care",
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const HorizontalLine(),

                    const SizedBox(height: 20),
                    // const GroceryCategories(userId: '667c4e8e2f6dec6e82d1ada9'),
                    BeautyCategories(userId: '6652bfc64e869c021acf688c'),

                    SizedBox(height: 20,),
                    // Text("Fruits"),
                    // HorizontalLine(),

                    // SizedBox(height: 20),
                    // Vegetables(userId: '667c4e8e2f6dec6e82d1ada9'),

                    Container(
                      height: 400,
                      color: GlobalVariables.blueBackground,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "India's  shoper connector app",
                              style: TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: GlobalVariables.lightBlueTextColor),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Text(
                                'farcon',
                                style: TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: GlobalVariables.lightBlueTextColor),
                              ),
                            ),
                            Center(
                              child: Text(
                                'V14.127.3',
                                style: TextStyle(
                                  fontFamily: 'Regular',
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 50,
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                height: 50,
                color: GlobalVariables.blueBackground,
              )

              // Orders(),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: showNotification,
        //   child: const Icon(Icons.notification_add),

        if (_isFloatingContainerOpen)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isFloatingContainerOpen = false;
                });
              },
              child: Container(
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20), // Rounded upper corners
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: Column(children: [
                    Container(
                        decoration: const BoxDecoration(
                            color: GlobalVariables.blueBackground,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10,
                                              left: 10,
                                              right: 10,
                                              top: 10),
                                          child: rem == 0
                                              ? const Icon(
                                                  Icons.motorcycle,
                                                  color: GlobalVariables
                                                      .blueTextColor,
                                                  size: 18,
                                                )
                                              : const Icon(
                                                  Icons.shopping_cart,
                                                  color: GlobalVariables
                                                      .blueTextColor,
                                                  size: 18,
                                                ),
                                        ),
                                      ),
                                    ),
                                    rem == 0
                                        ? const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Yay! you got FREE Delivery",
                                                style: TextStyle(
                                                  color: GlobalVariables
                                                      .blueTextColor,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Get FREE delivery ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: GlobalVariables
                                                      .blueTextColor,
                                                  fontFamily: 'Medium',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              // const SizedBox(
                                              //   height: 5,
                                              // ),
                                              Text(
                                                'Add products worth ${addMore(carts)} more',
                                                style: const TextStyle(
                                                  fontFamily: 'Medium',
                                                  fontSize: 12,
                                                  color: GlobalVariables
                                                      .greyTextColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),

                                              Center(
                                                child: LinearPercentIndicator(
                                                  lineHeight: 3,
                                                  barRadius:
                                                      const Radius.circular(10),
                                                  width: 280,
                                                  animation: true,
                                                  animationDuration:
                                                      1000, // The duration is in milliseconds
                                                  percent: percent.toDouble(),
                                                  progressColor: GlobalVariables
                                                      .yelloColor,
                                                  backgroundColor:
                                                      Colors.amber[50],
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),

                              // const SizedBox(
                              //   height: 10,
                              // )
                            ])),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 228, 229, 239),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.list,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isItemDetailsOpen = true;
                                _openBottomSheet(context);
                              });
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${carts.length}  ITEMS ',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Regular',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_up,
                                  color: GlobalVariables.greenColor,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  backgroundColor: MaterialStateProperty.all(
                                      GlobalVariables.greenColor),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  // Navigator.pushNamed(context, '/user-cart-products');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserCartProducts(
                                              totalPrice: 0,
                                              address: '',
                                              index: 0,
                                              tips: 0,
                                              instruction: const [],
                                              totalSave: '',
                                              shopCode: '',
                                            )),
                                  );
                                  setState(() {
                                    _isFloatingContainerOpen = false;
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Place order',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'SemiBold',
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
      ]),
    );
  }
}
