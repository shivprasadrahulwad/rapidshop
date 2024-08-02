import 'package:flutter/material.dart';
import 'package:eshop/common/widgets/loader.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/home/service/home_services.dart';
import 'package:eshop/features/home/service/rent_services.dart';
import 'package:eshop/features/product_details/screens/product_details_screen.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/models/rentProduct.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;

  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              '${widget.category}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Handle search action
              },
              icon: const Padding(
                padding: EdgeInsets.only(top: 20 , right: 10),
                child: Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
      body: productList == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.only(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   padding:
                    //       const EdgeInsets.only(left: 15, right: 15, top: 10),
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     '${widget.category}'.toUpperCase(),
                    //     style: const TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: 'Poppins',
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.only(
                    //       top: 10, left: 15, right: 15, bottom: 10),
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     'Cheesilicious ${widget.category} to make every day extraordinary.',
                    //     style: const TextStyle(
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.normal,
                    //       fontFamily: 'Poppins',
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                        height: 5), // Added space between description and line

                    // Product list view
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Product product = productList![index];
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ProductDetailScreen(
                            //           product: product,
                            //           shopId: product.shopId)),
                            // );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 20, left: 15, right: 15),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product image
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      product.images[0],
                                      height: 180,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Product details column
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Product name
                                        // Text(
                                        //   product.shopName,
                                        //   maxLines: 2,
                                        //   overflow: TextOverflow.ellipsis,
                                        //   style: const TextStyle(
                                        //     fontSize: 17,
                                        //     fontWeight: FontWeight.bold,
                                        //     fontFamily: 'Poppins',
                                        //   ),
                                        // ),
                                        // // Product description
                                        // Text(
                                        //   product.shopDescription,
                                        //   maxLines: 2,
                                        //   overflow: TextOverflow.ellipsis,
                                        //   style: const TextStyle(
                                        //     fontSize: 14,
                                        //     color: Colors.grey,
                                        //     fontFamily: 'Poppins',
                                        //   ),
                                        // ),

                                        Text(
                                          product.quantity.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255,
                                                    23,
                                                    122,
                                                    27), // Background color
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10), // Rounded corners
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              '4.4 (100+)', // Assuming rating is a double value
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )

                                        // Product price
                                        // Text(
                                        //   '\₹${product.price}',
                                        //   style: const TextStyle(
                                        //     fontSize: 16,
                                        //     fontWeight: FontWeight.bold,
                                        //     fontFamily: 'Poppins',
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class RentCategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/rent-category-deals';
  final String category;

  const RentCategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<RentCategoryDealsScreen> createState() =>
      _RentCategoryDealsScreenState();
}

class _RentCategoryDealsScreenState extends State<RentCategoryDealsScreen> {
  List<RentProduct>? productList;
  final RentServices rentServices = RentServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryRentProducts();
  }

  fetchCategoryRentProducts() async {
    productList = await rentServices.fetchCategoryRentProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5, top: 20),
              child: Stack(
                children: [
                  Container(
                    width: 60, // Increased circle size
                    height: 60, // Increased circle size
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black87, // Adjust color as needed
                    ),
                  ),
                  const Positioned(
                    top: 5, // Adjusted position of icon within circle
                    left: 13, // Adjusted position of icon within circle
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20, // Increased icon size
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.only(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${widget.category}'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 15, right: 15, bottom: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Cheesilicious ${widget.category} to make every day extraordinary.',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 5), // Added space between description and line

                    // Product list view
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        RentProduct rentProduct = productList![index];
                        return GestureDetector(
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => ProductDetailScreen(rentProduct: rentProduct, shopId:product.shopId)),
                          //   );
                          // },
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 20, left: 15, right: 15),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product image
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      rentProduct.images[0],
                                      height: 180,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Product details column
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Product name
                                        Text(
                                          rentProduct.category,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        // Product description
                                        Text(
                                          rentProduct.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),

                                        Text(
                                          rentProduct.description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255,
                                                    23,
                                                    122,
                                                    27), // Background color
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10), // Rounded corners
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              '4.4 (100+)', // Assuming rating is a double value
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )

                                        // Product price
                                        // Text(
                                        //   '\₹${product.price}',
                                        //   style: const TextStyle(
                                        //     fontSize: 16,
                                        //     fontWeight: FontWeight.bold,
                                        //     fontFamily: 'Poppins',
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
