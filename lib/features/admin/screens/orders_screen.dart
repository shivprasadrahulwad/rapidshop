import 'package:eshop/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eshop/common/widgets/loader.dart';
import 'package:eshop/features/admin/service/admin_services.dart';
import 'package:eshop/features/home/screens/order_details_screen.dart';
import 'package:eshop/models/order.dart';

class OrdersScreen extends StatefulWidget {
  final String shopId;

  const OrdersScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();
  int totalStatusZeroOrders = 0;
  int uniqueCustomers =0;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }
  Widget getOrderStatusText(int orderStatus) {
  if (orderStatus == 0) {
    return Text(
      'Pending',
      style: const TextStyle(
        color: Colors.red,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: 'Regular',
      ),
    );
  } else if (orderStatus == 1) {
    return Text(
      'Accepted',
      style: const TextStyle(
        color: Colors.orange,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: 'Regular',
      ),
    );
  } else if (orderStatus == 2) {
    return Text(
      'Ready',
      style: const TextStyle(
        color: GlobalVariables.greenColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: 'Regular',
      ),
    );
  } else {
    return Text(
      'Unknown Status',
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: 'Regular',
      ),
    );
  }
}

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    if (orders != null) {
      // Filter orders by shopId and status < 3
      orders = orders!
          .where((order) => order.shopId == widget.shopId && order.status < 3)
          .toList();
      totalStatusZeroOrders =
          orders!.where((order) => order.status == 0).toList().length;
          

      // First, sort by date and time in ascending order
      orders!.sort((a, b) {
        // Convert milliseconds since epoch to DateTime
        DateTime dateA = DateTime.fromMillisecondsSinceEpoch(a.orderedAt);
        DateTime dateB = DateTime.fromMillisecondsSinceEpoch(b.orderedAt);

        // Compare dates
        int dateComparison = dateA.compareTo(dateB);

        // If dates are the same, compare times
        if (dateComparison != 0) {
          return dateComparison; // Sort by date
        } else {
          return a.orderedAt
              .compareTo(b.orderedAt); // Sort by time if dates are the same
        }
      });

      print('Fetched ${orders!.length} orders'); // Debug print
      for (var order in orders!) {
        print('Order ID: ${order.id}, OrderedAt: ${order.orderedAt}');
      }
    }
    setState(() {});
  }

        

  @override
  Widget build(BuildContext context) {
    int orderStatus = 0;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(68),
          child: AppBar(
            backgroundColor: GlobalVariables.backgroundColor,
            elevation: 0.0,
            actions: const [
              Row(
                children: [],
              ),
            ],
            title: const Padding(
              padding: EdgeInsets.only(
                left: 10,
                top: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.shopping_bag),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      'Orders',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'Regular',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: orders == null
            ? const Loader()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child:Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: GlobalVariables.greyTextColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.done,
                                  size: 20,
                                ),
                              ),
                                ),

                                Column(
                                  children: [
                                    Text(
                                      'Accepted', // Replace with your card's title or content
                                      style: const TextStyle(
                                        fontFamily: 'Regular',
                                        fontWeight: FontWeight.bold,
                                        color: GlobalVariables.greyTextColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${orders!.length - totalStatusZeroOrders}', // Replace with your card's title or content
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Add more widgets inside the card if needed
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 20,
                                  ),
                                  child:Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.pending_actions,
                                  size: 20,
                                ),
                              ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Pending', // Replace with your card's title or content
                                      style: const TextStyle(
                                        fontFamily: 'Regular',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: GlobalVariables.greyTextColor
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${totalStatusZeroOrders} ', // Replace with your card's title or content
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Add more widgets inside the card if needed
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        final orderData = orders![index];
                         orderStatus=orderData.status;
                        final orderDate = DateTime.fromMillisecondsSinceEpoch(
                            orderData.orderedAt);
                        final formattedDate = DateFormat('dd MMM yyyy, hh:mm a')
                            .format(orderDate);

                        return GestureDetector(
                          onTap: () {
                            fetchOrders();
                            Navigator.pushNamed(
                              context,
                              OrderDetailScreen.routeName,
                              arguments: orderData,
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16), // Adjust the radius as needed
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order ID: ${orderData.id}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                    formattedDate,
                                    style: const TextStyle(
                                        color: GlobalVariables.greyTextColor,
                                        fontSize: 12),
                                  ),
                                  getOrderStatusText(orderStatus),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            );
  }
}
