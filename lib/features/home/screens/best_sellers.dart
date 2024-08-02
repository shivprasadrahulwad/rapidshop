import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:eshop/common/widgets/add_button.dart';
import 'package:eshop/features/home/service/home_services.dart';
import 'package:eshop/models/product.dart';
import 'package:provider/provider.dart';

// class Products {
//   final String name;
//   final String price;
//   final String imageUrl;

//   Products({required this.name, required this.imageUrl, required this.price});

//   static fromProduct(Products product) {}
// }

class BestSellers extends StatefulWidget {
  const BestSellers({Key? key}) : super(key: key);

  @override
  State<BestSellers> createState() => _BestSellersState();
}

class _BestSellersState extends State<BestSellers> {
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
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return HorizontalProductList(products: products);
              },
            ), // Displaying the horizontal product list
        ],
      ),
    );
  }
}

class HorizontalProductList extends StatelessWidget {
  final List<Product> products;

  HorizontalProductList({
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: Container(
        color: Colors.white,
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];
            return Container(
              margin: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        product.images.isNotEmpty ? product.images[0] : '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SemiBold',
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          product.quantity?.toInt().toString() ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Regular',
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₹${product.discountPrice?.toInt() ?? 0}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Regular',
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '₹${product.price.toInt()}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontFamily: 'Regular',
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 5),
                            AddCartButton(
                              productId: product.id!,
                              sourceUserId: '', // Adjust as per your logic
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
      ),
    );
  }
}
