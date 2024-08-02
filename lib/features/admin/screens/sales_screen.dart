import 'package:eshop/common/widgets/search_bar.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/screens/home_bar_graph.dart';
import 'package:eshop/features/admin/screens/line_graph.dart';
import 'package:eshop/features/auth/widgets/past_orders.dart';
import 'package:eshop/features/home/service/home_services.dart';
import 'package:eshop/models/order.dart';
import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  final String shopCode;
  const SalesScreen({Key? key, required this.shopCode}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  List<Order>? orders;
  double todayCostumerGrowth = 0;
  double totayRevenueGrowth = 0;
  double todayOrderGrowth = 0;
  double totalRevenueToday = 0;
  double weeklyGrowth = 0;
  int totalOrdersToday = 0;
  int uniqueCustomersToday = 0;
  int totalOrdersYesterday = 0;
  double totalRevenueYesterday = 0;
  int uniqueCustomersYesterday = 0;
  List<int> weeklyOrders = List<int>.filled(7, 0); // Initialize with zeros
  int totalWeeklyOrders = 0;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchOrdersForToday(
        widget.shopCode); // Replace '1234' with your actual shopId
  }

  fetchOrdersForToday(String shopId) async {
    orders = await homeServices.fetchOrdersForToday(context, shopId);
    calculateRevenueAndOrders();
    calculateWeeklyOrders();
    setState(() {});
  }

  void calculateRevenueAndOrders() {
    if (orders != null) {
      // Get today's date
      DateTime today = DateTime.now();
      DateTime startOfDay;
      DateTime endOfDay;

      // For today's date
      startOfDay = DateTime(today.year, today.month, today.day);
      endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

      // Filter orders by shopId '1234' and today's date
      List<Order> filteredOrdersToday = orders!.where((order) {
        DateTime orderDate =
            DateTime.fromMillisecondsSinceEpoch(order.orderedAt);
        return order.shopId == widget.shopCode &&
            orderDate.isAfter(startOfDay) &&
            orderDate.isBefore(endOfDay);
      }).toList();

      totalOrdersToday = filteredOrdersToday.length;
      totalRevenueToday =
          filteredOrdersToday.fold(0, (sum, order) => sum + order.totalPrice);

      Set<String> uniqueUserIdsToday =
          filteredOrdersToday.map((order) => order.userId).toSet();
      uniqueCustomersToday = uniqueUserIdsToday.length;

      // For yesterday's date
      DateTime yesterday = today.subtract(Duration(days: 1));
      startOfDay = DateTime(yesterday.year, yesterday.month, yesterday.day);
      endOfDay =
          DateTime(yesterday.year, yesterday.month, yesterday.day, 23, 59, 59);

      // Filter orders by shopId '1234' and yesterday's date
      List<Order> filteredOrdersYesterday = orders!.where((order) {
        DateTime orderDate =
            DateTime.fromMillisecondsSinceEpoch(order.orderedAt);
        return order.shopId == widget.shopCode &&
            orderDate.isAfter(startOfDay) &&
            orderDate.isBefore(endOfDay);
      }).toList();

      totalOrdersYesterday = filteredOrdersYesterday.length;
      totalRevenueYesterday = filteredOrdersYesterday.fold(
          0, (sum, order) => sum + order.totalPrice);

      Set<String> uniqueUserIdsYesterday =
          filteredOrdersYesterday.map((order) => order.userId).toSet();
      uniqueCustomersYesterday = uniqueUserIdsYesterday.length;
      todayOrderGrowth =
          ((totalOrdersToday - totalOrdersYesterday) / totalOrdersYesterday) *
              100;
      totayRevenueGrowth = ((totalRevenueToday - totalRevenueYesterday) /
              totalRevenueYesterday) *
          100;
      todayCostumerGrowth = ((uniqueCustomersToday - uniqueCustomersYesterday) /
              uniqueCustomersYesterday) *
          100;
    } else {
      print("No orders found.");
    }
  }

  // void calculateRevenueAndOrders() {
  //   totalRevenue = 0;
  //   totalOrders = 0;
  //   uniqueCustomers = 0;

  //   if (orders != null) {
  //     // Get today's date
  //     DateTime today = DateTime.now();
  //     DateTime startOfDay = DateTime(today.year, today.month, today.day);
  //     DateTime endOfDay =
  //         DateTime(today.year, today.month, today.day, 23, 59, 59);

  //     // Filter orders by shopId '1234' and today's date
  //     List<Order> filteredOrders = orders!.where((order) {
  //       DateTime orderDate =
  //           DateTime.fromMillisecondsSinceEpoch(order.orderedAt);
  //       return order.shopId == widget.shopCode &&
  //           orderDate.isAfter(startOfDay) &&
  //           orderDate.isBefore(endOfDay);
  //     }).toList();
  //     print("Filtered Orders: $filteredOrders");

  //     totalOrders = filteredOrders.length;

  //     totalRevenue = filteredOrders.fold(0, (sum, order) {
  //       return sum + order.totalPrice;
  //     });

  //     Set<String> uniqueUserIds =
  //         filteredOrders.map((order) => order.userId).toSet();
  //     uniqueCustomers = uniqueUserIds.length;
  //     print("Total Orders: $totalOrders");
  //     print("Total Revenue: $totalRevenue");
  //     print("Unique Customers: $uniqueCustomers");
  //   } else {
  //     print("No orders found.");
  //   }
  // }

//   void calculateWeeklyOrders() {
//   if (orders != null) {
//     // Initialize a list to hold the count of orders for each day of the week
//     List<int> ordersPerDay = List<int>.filled(7, 0);
//     int totalOrders = 0; // Initialize total orders counter

//     // Get today's date and start of the current week
//     DateTime today = DateTime.now();
//     DateTime startOfWeek = today.subtract(Duration(days: today.weekday % 7));

//     // Filter orders by shopCode and current week
//     List<Order> filteredOrders = orders!.where((order) {
//       DateTime orderDate = DateTime.fromMillisecondsSinceEpoch(order.orderedAt);
//       return order.shopId == widget.shopCode &&
//              orderDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
//              orderDate.isBefore(today.add(Duration(days: 1)));
//     }).toList();

//     // Iterate through filtered orders and count orders for each day in the current week
//     for (var order in filteredOrders) {
//       DateTime orderDate = DateTime.fromMillisecondsSinceEpoch(order.orderedAt);

//       // Calculate the day index (0 = Sunday, 6 = Saturday)
//       int dayIndex = (orderDate.weekday - 1) % 7;
//       ordersPerDay[dayIndex]++;
//       totalOrders++;
//     }

//     // Update state with the calculated weekly orders and total sum
//     setState(() {
//       weeklyOrders = ordersPerDay;
//       totalWeeklyOrders = totalOrders;
//       totalOrdersLastWeek = totalOrdersLastWeek;
//     });
//   }
// }

  void calculateWeeklyOrders() {
    if (orders != null) {
      // Initialize lists to hold the count of orders for each day of the current and last week
      List<int> ordersPerDayCurrentWeek = List<int>.filled(7, 0);
      List<int> ordersPerDayLastWeek = List<int>.filled(7, 0);
      int totalOrdersCurrentWeek = 0;
      int totalOrdersLastWeek = 0;

      // Get today's date
      DateTime today = DateTime.now();

      // Calculate the start of the current week (Monday)
      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
      // Calculate the start of the last week (Monday)
      DateTime startOfLastWeek = startOfWeek.subtract(Duration(days: 7));

      // Filter orders by shopCode for the current week
      List<Order> filteredOrdersCurrentWeek = orders!.where((order) {
        DateTime orderDate =
            DateTime.fromMillisecondsSinceEpoch(order.orderedAt);
        return order.shopId == widget.shopCode &&
            orderDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
            orderDate.isBefore(today.add(Duration(days: 1)));
      }).toList();

      // Filter orders by shopCode for the last week
      List<Order> filteredOrdersLastWeek = orders!.where((order) {
        DateTime orderDate =
            DateTime.fromMillisecondsSinceEpoch(order.orderedAt);
        return order.shopId == widget.shopCode &&
            orderDate.isAfter(startOfLastWeek.subtract(Duration(days: 1))) &&
            orderDate.isBefore(startOfWeek);
      }).toList();

      // Count orders for each day in the current week
      for (var order in filteredOrdersCurrentWeek) {
        DateTime orderDate =
            DateTime.fromMillisecondsSinceEpoch(order.orderedAt);
        int dayIndex = (orderDate.weekday - 1) % 7;
        ordersPerDayCurrentWeek[dayIndex]++;
        totalOrdersCurrentWeek++;
      }

      // Count orders for each day in the last week
      for (var order in filteredOrdersLastWeek) {
        DateTime orderDate =
            DateTime.fromMillisecondsSinceEpoch(order.orderedAt);
        int dayIndex = (orderDate.weekday - 1) % 7;
        ordersPerDayLastWeek[dayIndex]++;
        totalOrdersLastWeek++;
      }

      setState(() {
        weeklyOrders = ordersPerDayCurrentWeek;
        ;
        totalWeeklyOrders = totalOrdersCurrentWeek;
        totalOrdersLastWeek = totalOrdersLastWeek;
        weeklyGrowth = (totalOrdersCurrentWeek -
                totalOrdersLastWeek / totalOrdersLastWeek) *
            100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: GlobalVariables.backgroundColor,
          elevation: 0.0,
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 15),
                  child: Row(
                    children: [
                      Icon(Icons.dashboard, size: 25),
                      SizedBox(width: 10),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  )),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context,
                      '/account'); // Replace '/account' with your actual route name for the AccountScreen
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(
                    Icons.account_circle,
                    color: Color.fromARGB(255, 54, 47, 47),
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: GlobalVariables.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 80,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Row(children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.currency_rupee,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Today Revenue",
                                    style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: GlobalVariables.greyTextColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      // Text(
                                      //   '₹',
                                      //   style: TextStyle(
                                      //     fontSize: 27,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      Text(
                                        '${(totalRevenueToday).toInt()}',
                                        style: const TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Container(
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFF82D2BA),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(
                                            Icons.arrow_outward,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${totayRevenueGrowth}%',
                                        style: TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Adds some space between the cards
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 80,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Row(children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.shopping_bag_rounded,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Total order",
                                    style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: GlobalVariables.greyTextColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        totalOrdersToday.toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Container(
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFF82D2BA),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(
                                            Icons.arrow_outward,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${todayOrderGrowth}%',
                                        style: TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Adds some space between the cards
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 80,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Row(children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.people,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Customers",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: GlobalVariables.greyTextColor),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        uniqueCustomersToday.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Regular',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 30),
                                      Container(
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFF82D2BA),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(
                                            Icons.arrow_outward,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${todayCostumerGrowth}%',
                                        style: TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Adds some space between the cards
                  ],
                ),
                Container(
                  height:
                      320, // Set a fixed height for the SalesChart container
                  child: const LineGraph(),
                ),
                Container(
                  height:
                      300, // Set a fixed height for the SalesChart container
                  child: HomeBarGraph(
                    weeklyOrders: weeklyOrders,
                    totalWeeklyOrders: totalWeeklyOrders,
                    weeklyGrowth: weeklyGrowth,
                  ),
                ),


               
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 10, bottom: 10, right: 20),
                    child: Row(children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: GlobalVariables.greyTextColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Past Orders",
                            style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: GlobalVariables.greyTextColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PastOrdersScreen.routeName,
                            arguments: {'shopId': widget.shopCode},
                          );
                        },
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ]),
                  ),
                ),

               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
