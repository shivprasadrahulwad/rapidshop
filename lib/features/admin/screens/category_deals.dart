import 'package:eshop/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:eshop/common/widgets/horizontal_line.dart';
import 'package:eshop/features/admin/service/admin_services.dart';
import 'package:eshop/features/home/widgets/carousel_image.dart';
import 'package:eshop/features/home/widgets/top_categories.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CategoryDeals extends StatefulWidget {
  const CategoryDeals({Key? key}) : super(key: key);

  @override
  State<CategoryDeals> createState() => _CategoryDealsState();
}

class _CategoryDealsState extends State<CategoryDeals> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    //   final userProvider = Provider.of<UserProvider>(context);
    // final String userId = userProvider.user.id;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: GlobalVariables.backgroundColor,
          elevation: 0.0,
          title: const Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.category,
                color: Colors.black,
                size: 25,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 15),
                child: Text(
                  'Categories',
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
      body: Container(
        color: GlobalVariables.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 260,
                decoration: const BoxDecoration(
                  //             image: DecorationImage(
                  //   image: AssetImage("images/canva.png"),
                  //   fit: BoxFit.cover,
                  // ),
                  // color:
                  //     Colors.grey.withOpacity(0.4), // Set background color here
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(
                          20)), // Adjust border radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const AddressBox(),
                      // const SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                // onFieldSubmitted: navigateToSearchScreen,
                                decoration: const InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: EdgeInsets.only(top: 5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    // borderSide: BorderSide.none,
                                    borderSide: BorderSide(
                                      // Adjust this line to specify border color and width
                                      color: Colors
                                          .black38, // Change the color to make the border visible
                                      width: 1, // Adjust the width as needed
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black38,
                                      width: 1,
                                    ),
                                  ),
                                  hintText: "Search 'Vegetables'",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CarouselImage(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Category",
                style: TextStyle(
                    fontFamily: 'SemiBold',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const HorizontalLine(),
              const SizedBox(height: 20),
              // const GroceryCategories(shopCode: '',),
              Grocery(userId: user.id),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Beauty(userId: user.id),
              const SizedBox(height: 20),
              Container(
                height: 300,
                color: GlobalVariables.backgroundColor,
                child: const Padding(
                  padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "India's  shoper connector app",
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: GlobalVariables.lightBlueTextColor),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      HorizontalLine1(),
                      SizedBox(
                        height: 25,
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
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
