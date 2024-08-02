import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/home/service/home_services.dart';
import 'package:eshop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:eshop/common/widgets/add_button.dart';

class Products {
  final String name;
  final String price;
  final String imageUrl;

  Products({required this.name, required this.imageUrl , required this.price});

  static fromProduct(Products product) {}
}

class SeasonOffer extends StatefulWidget {
  const SeasonOffer({Key? key}) : super(key: key);

  @override
  State<SeasonOffer> createState() => _SeasonOfferState();
}

class _SeasonOfferState extends State<SeasonOffer> {
  List<Product> products = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final fetchedProducts = await HomeServices().fetchOfferCartProducts(
        context: context,
        userId: '667c4e8e2f6dec6e82d1ada9',
      );
      setState(() {
        products = fetchedProducts.cast<Product>();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10), // Space between title and product list
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (errorMessage != null)
            Center(child: Text('Error: $errorMessage'))
          else if (products.isEmpty)
            const Center(child: Text('No Season Offer found.'))
          else
            HorizontalProductList(products: products), // Displaying the horizontal product list
        ],
      ),
    );
  }
}




class HorizontalProductList extends StatelessWidget {
  final List<Product> products;

  HorizontalProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,      height: 270, // Height of the container
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(10), // Margin around each product
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120, // Height of the image
                  width: 120, // Width of the image
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    color: Colors.white, // Background color of the image container
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    child: Image.network(
                      products[index].images.isNotEmpty ? products[index].images[0] : '', // Display the first image if available
                      fit: BoxFit.cover, // Image fit
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Space between image and text
                Container(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[index].name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SemiBold',
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: 5,),

                      Text(
                        (products[index].quantity?.toInt()).toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Regular',
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: 5,),
                   
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                            '₹${products[index].discountPrice?.toInt()}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Regular',
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),

                          Text(
                            '₹${products[index].price.toInt()}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Regular',
                              decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                            ],
                          ),
                          SizedBox(width: 5),
                          AddCartButton(
                            productId: products[index].id!, // Correctly pass productId
                            sourceUserId: "667c4e8e2f6dec6e82d1ada9", 
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}