import 'package:eshop/features/admin/screens/cart_subtotal.dart';
import 'package:eshop/features/home/screens/best_sellers.dart';
import 'package:flutter/material.dart';
import 'package:eshop/common/widgets/custom_buttons.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/screens/bills_details.dart';
import 'package:eshop/features/home/service/home_services.dart';
import 'package:eshop/models/product.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

enum DeliveryOption { door, other }

DeliveryOption selectedDeliveryOption = DeliveryOption.door;

class UserCartProducts extends StatefulWidget {
  static const String routeName = '/user-cart-products';
  final int totalPrice;
  final String totalSave;
  final String shopCode;
  final String address;
  final int index;
  final List<Map<String, String>> instruction;
  final tips;

  UserCartProducts({
    Key? key,
    required this.totalPrice,
    required this.address,
    required this.index,
    required this.instruction,
    required this.tips,
    required this.totalSave,
    required this.shopCode,
  }) : super(key: key);

  final Map<String, dynamic> Schedule = {
    'title': 'Delivary Schedule',
    'tips': [
      ' ',
      '₹20',
      '₹30',
      '₹50',
      'Custom',
    ],
    'emoji': [
      '😊 Clear',
      '😀',
      '🤩',
      '😍',
      '🤗',
    ],
  };

  @override
  State<UserCartProducts> createState() => _UserCartProductsState();
}

class _UserCartProductsState extends State<UserCartProducts> {
  final HomeServices homeServices = HomeServices();

  List<Map<String, String>> instruction = [];

  void increaseQuantity(Product product) {
    homeServices.addToCart(
      context: context,
      product: product,
      quantity: 0,
    );
  }

  void decreaseQuantity(Product product) {
    homeServices.removeFromCart(
      context: context,
      product: product,
      sourceUserId: '',
    );
  }

  String? _selectedScheduleValue = '';
  bool _isFloatingContainerOpen = false;

  void placeOrders() {
    final cart =
        context.read<UserProvider>().user.cart.cast<Map<String, dynamic>>();
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your cart is empty')),
      );
      return;
    }

    int calculateCartTotal(List<Map<String, dynamic>> cart) {
      int sum = 0;
      int devlivery = 150;

      cart.forEach((e) {
        final quantity = e['quantity'] as int?;
        final product = e['product'] as Map<String, dynamic>?;

        if (quantity != null && product != null) {
          final discountPrice = product['discountPrice'] as int?;
          final price = product['price'] as int?;

          if (price != null) {
            // Use discountPrice if available, otherwise fallback to price
            sum += quantity * (discountPrice ?? price);
          }
        }
      });

      return sum;
    }

    int calculateTotalSave(List<Map<String, dynamic>> cart) {
      int save = 0;

      cart.forEach((e) {
        final quantity = e['quantity'] as int?;
        final product = e['product'] as Map<String, dynamic>?;

        if (quantity != null && product != null) {
          final discountPrice = product['discountPrice'] as int?;
          final price = product['price'] as int?;

          if (discountPrice != null && price != null) {
            // Calculate savings for each item
            int originalTotal = quantity * price;
            int discountedTotal = quantity * discountPrice;
            int itemSave = originalTotal - discountedTotal;

            save += itemSave;
          }
        }
      });

      return save;
    }

    final totalPrice = calculateCartTotal(cart);
    // final shopId='667c4e8e2f6dec6e82d1ada9';
    final shopId=GlobalVariables.shopCode;
    print(calculateCartTotal(cart));
    final totalSave = calculateTotalSave(cart);

    homeServices.placeOrder(
      context: context,
      shopId:shopId,
      address: widget.address,
      totalPrice: totalPrice,
      totalSave: totalSave,
      instruction: instruction,
      tips: _selectedScheduleValue,
    );
  }

  bool isMarked1 = false;
  bool isMarked2 = false;
  bool isMarked3 = false;
  bool isMarked4 = false;
  bool isMarked5 = false;

  int _selectedScheduleIndex = 0;

  bool? isChecked1 = false;
  bool? isChecked2 = false;
  bool? isChecked3 = false;
  bool? isChecked4 = false;
  bool? isChecked5 = false;

  void updateInstructions() {
    instruction.clear(); // Clear existing instructions

    if (isMarked1) {
      instruction.add({'type': '1'});
    }
    if (isMarked2) {
      instruction.add({'type': '2'});
    }
    if (isMarked3) {
      instruction.add({'type': '3'});
    }
    if (isMarked4) {
      instruction.add({'type': '4'});
    }
    if (isMarked5) {
      instruction.add({'type': '5'});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<UserProvider>().user.cart;
    updateInstructions();

    final carts = context.watch<UserProvider>().user.cart;

    if (carts.length >= 1 && !_isFloatingContainerOpen) {
      _isFloatingContainerOpen = true;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25
                ,
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                // IconButton(
                //   onPressed: () {
                //     // Handle shopping cart action
                //   },
                //   icon: const Padding(
                //     padding: EdgeInsets.only(top: 20),
                //     child: Icon(
                //       Icons.shopping_cart_outlined,
                //       color: GlobalVariables.greenColor,
                //       size: 15,
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    // Handle share action
                    Share.share('Your message here');
                  },
                  child:  Padding(
                    padding: EdgeInsets.only(top: 25, right: 10),
                    child: Row(
                      children: [
                          IconButton(
                  onPressed: () {
                    // Handle shopping cart action
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: GlobalVariables.greenColor,
                      size: 15,
                    ),
                  ),
                ),
                    
                        Text(
                      'Share',
                      style: TextStyle(
                        fontSize: 16,
                        color: GlobalVariables.greenColor,
                        fontFamily: 'SemiBold',
                      ),
                    ),

                  

                      ],
                    )
                  ),
                ),
              ],
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Checkout',
                
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
      body: Stack(
        children: [
          cart.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : Padding(
                  padding: const EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 234, 241, 246)),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: GlobalVariables.savingColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: const Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Your total savings',
                                            style: TextStyle(
                                                color: GlobalVariables
                                                    .blueTextColor,
                                                fontFamily: 'Medium',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        
                                          Text(
                                            'Includes ₹150 saving through free delivery',
                                            style: TextStyle(
                                              fontSize: 12,
                                              
                                                color: GlobalVariables
                                                    .lightBlueTextColor,
                                                fontFamily: 'Medium'),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      CartTotalSaving(),
                                    ],
                                  )),
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15 ,left: 15,right: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color.fromARGB(
                                                    255, 228, 229, 239)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Icon(Icons.timer,size: 20,),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Free delivery in 10 minutes",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: GlobalVariables
                                                        .cartFontWeight,
                                                    fontFamily: 'SemiBold'),
                                              ),
                                             
                                              Text(
                                                'Shipment of ${cart.length} Items',
                                                style: const TextStyle(
                                                  fontFamily: 'Medium',
                                                  fontSize: 12,
                                                  color:
                                                      GlobalVariables.greyTextColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: GlobalVariables.dividerColor,
                                  ),
                                  ListView.separated(
                                    itemCount: cart.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      thickness: 1,
                                      color: GlobalVariables.dividerColor,
                                    ),
                                    itemBuilder: (context, index) {
                                      final productCart = cart[index];
                                      if (productCart['product'] == null) {
                                        return const SizedBox.shrink();
                                      }
                                      final product = Product.fromMap(
                                          productCart['product']);
                                      if (product == null) {
                                        return const SizedBox.shrink();
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 70,
                                              height: 70,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Image.network(
                                                    product.images.isNotEmpty
                                                        ? product.images[0]
                                                        : '',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        product.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Regular'),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        (product.quantity
                                                                ?.toInt())
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: GlobalVariables
                                                              .greyTextColor,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: GlobalVariables
                                                                            .greenColor,
                                                                        width:
                                                                            1.5,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: GlobalVariables
                                                                          .greenColor),
                                                              child: Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () =>
                                                                        decreaseQuantity(
                                                                            product),
                                                                    child:
                                                                        Container(
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .remove,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  DecoratedBox(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color: GlobalVariables
                                                                              .greenColor,
                                                                          width:
                                                                              1.5),
                                                                      color: GlobalVariables
                                                                          .greenColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: 30,
                                                                      height:
                                                                          28,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        productCart['quantity']
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                255), fontFamily: 'Regular', fontSize: 14 ,fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () =>
                                                                        increaseQuantity(
                                                                            product),
                                                                    child:
                                                                        Container(
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .add,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '₹${(product.price).toInt()}',
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Regular',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                color: GlobalVariables
                                                                    .greyTextColor),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                            '₹${(product.discountPrice)?.toInt()}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Regular',
                                                            ),
                                                          ),
                                                        ],
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
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 0,
                              child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Text(
                                          'Before you checkout',
                                          style: TextStyle(
                                              fontFamily: 'SemiBold',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    BestSellers(),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10), // Set border radius to 20
                                color: GlobalVariables.blueBackground,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                15), // Set border radius to 20
                                            color:
                                                GlobalVariables.blueTextColor),
                                        child: const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.done,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Yay! you got FREE Delivery",
                                          style: TextStyle(
                                              color:
                                                  GlobalVariables.blueTextColor,
                                              fontFamily: 'Regular',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'No coupons needed',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Regular',
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BillDetails(
                              selectedScheduleValue:
                                  _selectedScheduleValue ?? '',
                            ),
                            const SizedBox(height: 5),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Delivery instructions",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'SemiBold',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              // ignore: prefer_const_constructors
                                              color: isMarked1
                                                  ? const Color.fromARGB(
                                                      255, 215, 247, 216)
                                                  : (isChecked1!
                                                      ? const Color.fromARGB(
                                                          255, 211, 240, 212)
                                                      : Colors.white),
                                              border: Border.all(
                                                color: GlobalVariables.greyBackgroundCOlor,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Icon(Icons
                                                        .door_back_door_outlined),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isMarked1 =
                                                              !isMarked1; // Toggle marked state
                                                          isChecked1 =
                                                              isMarked1; // Sync isChecked1 with isMarked1
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 24,
                                                        height: 24,
                                                        child: Center(
                                                          child: Theme(
                                                            data: ThemeData(
                                                              checkboxTheme:
                                                                  CheckboxThemeData(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                              ),
                                                            ),
                                                            child:
                                                                Transform.scale(
                                                              scale: 1.3,
                                                              child: Checkbox(
                                                                value:
                                                                    isChecked1,
                                                                activeColor:
                                                                    Colors
                                                                        .green,
                                                                onChanged:
                                                                    (newBool) {
                                                                  setState(() {
                                                                    isChecked1 =
                                                                        newBool;
                                                                    isMarked1 =
                                                                        newBool!; // Sync isMarked1 with isChecked1
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text('Leave at door',style: TextStyle(fontFamily: 'Regular',fontWeight: FontWeight.bold,fontSize: 14),),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              // ignore: prefer_const_constructors
                                              color: isMarked2
                                                  ? const Color.fromARGB(
                                                      255, 215, 247, 216)
                                                  : (isChecked2!
                                                      ? const Color.fromARGB(
                                                          255, 211, 240, 212)
                                                      : Colors.white),
                                              border: Border.all(
                                                color: GlobalVariables.greyBackgroundCOlor,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Icon(Icons.call),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isMarked2 =
                                                              !isMarked2; // Toggle marked state
                                                          isChecked2 =
                                                              isMarked2; // Sync isChecked1 with isMarked1
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 24,
                                                        height: 24,
                                                        child: Center(
                                                          child: Theme(
                                                            data: ThemeData(
                                                              checkboxTheme:
                                                                  CheckboxThemeData(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                              ),
                                                            ),
                                                            child:
                                                                Transform.scale(
                                                              scale: 1.3,
                                                              child: Checkbox(
                                                                value:
                                                                    isChecked2,
                                                                activeColor:
                                                                    Colors
                                                                        .green,
                                                                onChanged:
                                                                    (newBool) {
                                                                  setState(() {
                                                                    isChecked2 =
                                                                        newBool;
                                                                    isMarked2 =
                                                                        newBool!; // Sync isMarked1 with isChecked1
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text('Avoid calling',style: TextStyle(fontFamily: 'Regular',fontWeight: FontWeight.bold,fontSize: 14),),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              // ignore: prefer_const_constructors
                                              color: isMarked3
                                                  ? const Color.fromARGB(
                                                      255, 215, 247, 216)
                                                  : (isChecked3!
                                                      ? const Color.fromARGB(
                                                          255, 211, 240, 212)
                                                      : Colors.white),
                                              border: Border.all(
                                                color: GlobalVariables.greyBackgroundCOlor,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Icon(Icons
                                                        .doorbell_outlined),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isMarked3 =
                                                              !isMarked3; // Toggle marked state
                                                          isChecked3 =
                                                              isMarked3; // Sync isChecked1 with isMarked1
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 24,
                                                        height: 24,
                                                        child: Center(
                                                          child: Theme(
                                                            data: ThemeData(
                                                              checkboxTheme:
                                                                  CheckboxThemeData(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                              ),
                                                            ),
                                                            child:
                                                                Transform.scale(
                                                              scale: 1.3,
                                                              child: Checkbox(
                                                                value:
                                                                    isChecked3,
                                                                activeColor:
                                                                    Colors
                                                                        .green,
                                                                onChanged:
                                                                    (newBool) {
                                                                  setState(() {
                                                                    isChecked3 =
                                                                        newBool;
                                                                    isMarked3 =
                                                                        newBool!; // Sync isMarked1 with isChecked1
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                    'Dont ring the bell',style: TextStyle(fontFamily: 'Regular',fontWeight: FontWeight.bold,fontSize: 14),),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              // ignore: prefer_const_constructors
                                              color: isMarked4
                                                  ? const Color.fromARGB(
                                                      255, 215, 247, 216)
                                                  : (isChecked4!
                                                      ? const Color.fromARGB(
                                                          255, 211, 240, 212)
                                                      : Colors.white),
                                              border: Border.all(
                                                color: GlobalVariables.greyBackgroundCOlor,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Icon(Icons.man),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isMarked4 =
                                                              !isMarked4; // Toggle marked state
                                                          isChecked4 =
                                                              isMarked4; // Sync isChecked1 with isMarked1
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 24,
                                                        height: 24,
                                                        child: Center(
                                                          child: Theme(
                                                            data: ThemeData(
                                                              checkboxTheme:
                                                                  CheckboxThemeData(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                              ),
                                                            ),
                                                            child:
                                                                Transform.scale(
                                                              scale: 1.3,
                                                              child: Checkbox(
                                                                value:
                                                                    isChecked4,
                                                                activeColor:
                                                                    Colors
                                                                        .green,
                                                                onChanged:
                                                                    (newBool) {
                                                                  setState(() {
                                                                    isChecked4 =
                                                                        newBool;
                                                                    isMarked4 =
                                                                        newBool!; // Sync isMarked1 with isChecked1
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text('Leave at guard',style: TextStyle(fontFamily: 'Regular',fontWeight: FontWeight.bold,fontSize: 14),),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              // ignore: prefer_const_constructors
                                              color: isMarked5
                                                  ? const Color.fromARGB(
                                                      255, 215, 247, 216)
                                                  : (isChecked5!
                                                      ? const Color.fromARGB(
                                                          255, 211, 240, 212)
                                                      : Colors.white),
                                              border: Border.all(
                                                color: GlobalVariables.greyBackgroundCOlor,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Icon(Icons.pets),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isMarked5 =
                                                              !isMarked5; // Toggle marked state
                                                          isChecked5 =
                                                              isMarked5; // Sync isChecked1 with isMarked1
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 24,
                                                        height: 24,
                                                        child: Center(
                                                          child: Theme(
                                                            data: ThemeData(
                                                              checkboxTheme:
                                                                  CheckboxThemeData(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                              ),
                                                            ),
                                                            child:
                                                                Transform.scale(
                                                              scale: 1.3,
                                                              child: Checkbox(
                                                                value:
                                                                    isChecked5,
                                                                activeColor:
                                                                    Colors
                                                                        .green,
                                                                onChanged:
                                                                    (newBool) {
                                                                  setState(() {
                                                                    isChecked5 =
                                                                        newBool;
                                                                    isMarked5 =
                                                                        newBool!; // Sync isMarked1 with isChecked1
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text('Pet at  home',style: TextStyle(fontFamily: 'Regular',fontWeight: FontWeight.bold,fontSize: 14),),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Tip your delivery partner",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'SemiBold',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),SizedBox(width: 30,),
                                                   
                                                    Text(
                                                      ' ${_selectedScheduleValue}',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Medium',
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                    height:
                                                        5), // Add some space between the texts
                                                ConstrainedBox(
                                                  constraints: const BoxConstraints(
                                                      maxWidth:
                                                          270), // Adjust maxWidth as needed
                                                  child: const Text(
                                                    "Your kindness means a lot! 100% of your tip will go directly to your delivery partner.",
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: GlobalVariables
                                                            .greyTextColor), // Adjust font size if necessary
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                widget.Schedule['tips'].length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _selectedScheduleIndex =
                                                        index;
                                                    _selectedScheduleValue =
                                                        widget.Schedule['tips']
                                                            [index];
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        height: 40,
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15),
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              _selectedScheduleIndex ==
                                                                      index
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      207,
                                                                      249,
                                                                      215)
                                                                  : const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            color: _selectedScheduleIndex ==
                                                                    index
                                                                ? GlobalVariables
                                                                    .greenColor
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '${widget.Schedule['emoji'][index]} ${widget.Schedule['tips'][index]}',
                                                              style: TextStyle(
                                                                  color: _selectedScheduleIndex ==
                                                                          index
                                                                      ? const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0)
                                                                      : Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 0,
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cancellation Policy",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'SemiBold',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Orders cannot be cancelled once packed for delivery. In case of unexpected delays, a refund will be provided, if applicable.",
                                          style: TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 12,
                                              color: GlobalVariables.greyTextColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                
                                elevation: 0,
                                child: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(
                                            "Ordering for someone else?",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'SemiBold',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          Text('Add details',style: TextStyle(fontFamily: 'Regular',fontWeight: FontWeight.bold,fontSize: 12 ,color: GlobalVariables.greenColor),)
                                   ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 0,
                              child: const Padding(
                                padding: EdgeInsets.all(7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Orders cannot be cancelled,",
                                          style: TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 16,
                                              color: GlobalVariables.greyTextColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              text: "Proceed to Payment",
                              onTap: placeOrders,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          if (_isFloatingContainerOpen)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0, // Extend the container to the full width
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isFloatingContainerOpen = false;
                  });
                },
                child: Container(
                  height:
                      140, // Increase the height for a drawer-like appearance
                  decoration: BoxDecoration(
                    color: Colors
                        .white, // Change the color to white for a drawer effect
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20), // Only top corners rounded
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(
                            0, -4), // Shadow offset adjusted for bottom drawer
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10), // Add padding around the content
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align to the start
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 10, top: 5, ),
                              child: Icon(
                                Icons.house,
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Delivering to',
                                              style: TextStyle(
                                                fontFamily: 'SemiBold',
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' Home',
                                              style: TextStyle(
                                                fontFamily: 'SemiBold',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Change',
                                        style: TextStyle(
                                            color: GlobalVariables.greenColor,
                                            fontFamily: 'Medium',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,),
                                      )
                                    ],
                                  ),
                                  
                                  Text(
                                    'Shiv, 144 Behind Apurv Hospital, Holkar Chowk, Nanded',
                                    style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 12,
                                      color: GlobalVariables.greyTextColor
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          color: GlobalVariables.dividerColor,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: GlobalVariables.blueBackground,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        bottom: 20,
                                        left: 10,
                                        right: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'UPI Options',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: GlobalVariables
                                                      .lightBlueTextColor,
                                                  fontFamily: 'SemiBold',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Icon(
                                              Icons.arrow_drop_down,
                                              color:
                                                  GlobalVariables.blueTextColor,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    backgroundColor: MaterialStateProperty.all(
                                        GlobalVariables.greenColor),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isFloatingContainerOpen = false;
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: placeOrders,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CartTotal(),
                                         
                                            Text(
                                              'TOTAL',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontFamily: 'Regular'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Place order',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontFamily: 'SemiBold'),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
