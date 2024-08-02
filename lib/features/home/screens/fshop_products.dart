import 'package:flutter/material.dart';
import 'package:eshop/common/widgets/add_button.dart';
import 'package:eshop/features/home/service/home_services.dart';
import 'package:eshop/models/product.dart';

class Products {
  final String name;
  final String price;
  final String imageUrl;

  Products({required this.name, required this.imageUrl , required this.price});

  static fromProduct(Products product) {}
}


class fshopProducts extends StatefulWidget {
    static const String routeName = '/shop-products';
  const fshopProducts({Key? key}) : super(key: key);

  @override
  State<fshopProducts> createState() => _fshopProductsState();
}

class _fshopProductsState extends State<fshopProducts> {
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
      final fetchedProducts = await HomeServices().fetchCartProductsWithNullDiscountPrice(
        context: context,
        userId: '6652bfc64e869c021acf688c',
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
            const Center(child: Text('No best sellers found.'))
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
      color: const Color.fromRGBO(255, 255, 255, 1), // Background color
      height: 270, // Height of the container
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
                  height: 130, // Height of the image
                  width: 130, // Width of the image
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    color: Colors.white, // Background color of the image container
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5), // Shadow color
                    //     spreadRadius: 1, // Spread radius
                    //     blurRadius: 3, // Blur radius
                    //     offset: const Offset(0, 2), // Shadow offset
                    //   ),
                    // ],
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
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const Text("250 ml"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      
                           Text(
                        '₹${products[index].price.toString()}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                          const SizedBox(width: 5),
                          const AddshopProduct(productId: '',),
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