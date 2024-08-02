import 'package:flutter/material.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/account/screens/account_services.dart';
import 'package:eshop/features/home/screens/order_details_screen.dart';
import 'package:eshop/features/home/service/home_services.dart';
import 'package:eshop/models/order.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = '/account';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Order>? orders;
  final HomeServices accountServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Padding(
                padding: EdgeInsets.only(top: 20, ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
           
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'SemiBold',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Consumer<UserProvider>(
                        builder: (context, userProvider, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, ${userProvider.user.name}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Medium'),
                              ),
                              Text(
                                '${userProvider.user.email}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Regular'),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "YOUR INFORMATION",
                      style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (orders != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailScreen(
                                  order: orders![
                                      0]), // Assuming orders is a List<Order> and you want to pass the first order
                            ),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: GlobalVariables.blueBackground),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("Your orders",style: TextStyle(fontFamily: 'Medium' ,fontSize: 16 ),),
                          const Spacer(), // This pushes the text to the leftmost side
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: GlobalVariables.blueBackground),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.notes_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Address book",style: TextStyle(fontFamily: 'Medium' ,fontSize: 16 ,),),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text("OTHER INFORMATION",
                        style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => Share.share("mess"),
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: GlobalVariables.blueBackground),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.share_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Share the app",style: TextStyle(fontFamily: 'Medium' ,fontSize: 16 ,),),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/aboutUs');
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: GlobalVariables.blueBackground),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.info_outline_rounded,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("About Us",style: TextStyle(fontFamily: 'Medium' ,fontSize: 16 ,),),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: GlobalVariables.blueBackground),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.star_border_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Rate us on the Play Store",style: TextStyle(fontFamily: 'Medium' ,fontSize: 16 ,),),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/accountPrivacy');
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: GlobalVariables.blueBackground),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.privacy_tip_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Account privacy",style: TextStyle(fontFamily: 'Medium' ,fontSize: 16 ,),),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => AccountServices().logOut(context),
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: GlobalVariables.blueBackground),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.logout_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Logout",style: TextStyle(fontFamily: 'Medium' ,fontSize: 15 ,),),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'farcon',
                            style: TextStyle(
                              fontFamily: 'SemiBold',
                              color: Colors.grey,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'V14.127.3',
                            style: TextStyle(
                              fontFamily: 'Regular',
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ]),
            ),
          ),
        ));
  }
}
