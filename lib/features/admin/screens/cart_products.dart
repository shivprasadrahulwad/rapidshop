import 'package:flutter/material.dart';
import 'package:eshop/common/widgets/add_button.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/service/admin_services.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatefulWidget {
  static const String routeName = '/cart-products';
  const CartProducts({Key? key}) : super(key: key);

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<UserProvider>().user.cart;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: GlobalVariables.backgroundColor,
          elevation: 0.0,

          title: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.list),
              const Padding(
                padding: EdgeInsets.only(top: 4,left: 10),
                child: Text(
                  'Listed products',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'Regular',
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => (),
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Container(
              color: GlobalVariables.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                          left: 10, right: 10),
                    child: Text(
                      'Total ${cart.length.toString()} products listed for sale',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Regular'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: cart.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.58,
                        ),
                        itemBuilder: (context, index) {
                          final productCart = cart[index];
                          final product =
                              Product.fromMap(productCart['product']);
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 160,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Image.network(
                                          product.images[0],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Regular'),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Rem. quantity: ${(product.quantity?.toInt())}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Regular'),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '₹${product.discountPrice?.toInt()}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Stack(
                                                  children: [
                                                    Text(
                                                      '₹${product.price?.toInt()}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Regular',
                                                        color: GlobalVariables.greyTextColor
                                                      ),
                                                    ),
                                                    const Positioned(
                                                      left: 0,
                                                      right: 0,
                                                      bottom: 0,
                                                      child: Divider(
                                                        color: GlobalVariables.greyTextColor,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                DeleteProduct(
                                                  productId: product.id!,
                                                  onDelete: (productId) {
                                                    AdminServices()
                                                        .deleteProductFromCart(
                                                      context: context,
                                                      productId: productId,
                                                      onSuccess: () {
                                                        setState(() {
                                                          // Update UI after deletion
                                                          cart.removeAt(index);
                                                        });
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        EditButton(
                                          productId: product.id!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
