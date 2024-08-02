import 'package:eshop/common/widgets/loader.dart';
import 'package:eshop/common/widgets/search_bar.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/service/admin_services.dart';
import 'package:eshop/features/home/screens/order_details_screen.dart';
import 'package:eshop/features/search/screens/search_screen.dart';
import 'package:eshop/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PastOrdersScreen extends StatefulWidget {
  static const String routeName = '/pastOrders';
  final String shopId;

  const PastOrdersScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  State<PastOrdersScreen> createState() => _PastOrdersScreenState();
}

class _PastOrdersScreenState extends State<PastOrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();
  int uniqueCustomers=0;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    if (orders != null) {
      // Filter orders by shopId and status < 3
      orders = orders!.where((order) => order.shopId == widget.shopId && order.status == 3).toList();
      final uniqueCustomerIds = orders!.map((order) => order.userId).toSet();
      uniqueCustomers = uniqueCustomerIds.length;


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
          return a.orderedAt.compareTo(b.orderedAt); // Sort by time if dates are the same
        }
      });

      print('Fetched ${orders!.length} orders'); // Debug print
      for (var order in orders!) {
        print('Order ID: ${order.id}, OrderedAt: ${order.orderedAt}');
      }
    }
    setState(() {});
  }

    void navigateToSearchScreen() {
    Navigator.pushNamed(
      context,
      OrderSearchScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: GlobalVariables.backgroundColor,
          elevation: 0.0,
          actions: const [
            Row(
              children: [],
            ),
          ],
          title: const Padding(
            padding: EdgeInsets.only(left: 10, top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon(Icons.shopping_bag),
                // SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    'Past Orders',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Regular',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
      body: orders == null
          ? const Loader()
          :  Column(
            children: [
              // AnimatedSearchTextFeild(),
              Row(
                children: [
                  Container(
                        width: MediaQuery.of(context).size.width /2,
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10,left: 5),
                                  child: Container(
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
                                ),
                                Column(
                                  children: [
                                    Text(
                                  'Total orders', // Replace with your card's title or content
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Regular',
                                    color: GlobalVariables.greyTextColor,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                    Text(
                                  '${orders!.length}', // Replace with your card's title or content
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
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
                        width: MediaQuery.of(context).size.width /2,
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10,left: 5),
                                  child: Container(
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
                                ),
                                Column(
                                  children: [
                                    Text(
                                  'Customer', // Replace with your card's title or content
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Regular',
                                    color: GlobalVariables.greyTextColor,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                    Text(
                                  '${uniqueCustomers}', // Replace with your card's title or content
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
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
              Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: GestureDetector(
                          onTap: () => navigateToSearchScreen(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(
                                        255, 245, 245, 245),
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
                                   
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              Expanded(
                child: ListView.builder(
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    final orderData = orders![index];
                    final orderDate =
                        DateTime.fromMillisecondsSinceEpoch(orderData.orderedAt);
                    final formattedDate =
                        DateFormat('dd MMM yyyy, hh:mm a').format(orderDate);
                          
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailScreen.routeName,
                          arguments: orderData,
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
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
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  color: GlobalVariables.greyTextColor,
                                  fontSize: 12,
                                ),
                              ),
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
