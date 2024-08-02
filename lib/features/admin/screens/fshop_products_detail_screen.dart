import 'dart:convert';
import 'package:eshop/constants/error_handling.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/constants/utils.dart';
import 'package:eshop/features/home/widgets/carousel_image.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class FshopProductDetailsScreen extends StatefulWidget {
  final String productId;

  FshopProductDetailsScreen({Key? key, required this.productId}) : super(key: key);

  final Map<String, dynamic> category = {
    'title': 'Fruits & Vegetables',
    'sub-title': [
      'Apples',
      'Bananas',
      'Carrots',
      'Tomatoes',
      'Potatoes',
      'Grapes',
      'Oranges',
      'Broccoli',
      'Spinach',
      'Peppers'
    ],
  };

  final Map<String, dynamic> schedule = {
    'title': 'Delivery Schedule',
    'sub-title': [
      '6 AM - 9 AM',
      '7 AM - 10 AM',
      '8 AM - 11 AM',
      '9 AM - 12 PM',
    ],
  };

  @override
  _FshopProductDetailsScreenState createState() => _FshopProductDetailsScreenState();
}

class _FshopProductDetailsScreenState extends State<FshopProductDetailsScreen> {
  final TextEditingController houseNameController = TextEditingController(text: '');
  int _selectedCategoryIndex = 0;
  int _selectedScheduleIndex = 0;
  int _currentValue = 0;
  int _currentValue2 = 0;

  Map<String, dynamic>? productDetails;

  @override
  void initState() {
    super.initState();
    fetchProductDetails(widget.productId);
  }

  void fetchProductDetails(String productId) {
    // Replace with actual logic to fetch product details based on productId
    productDetails = {
      'name': 'Organic Fresh Green Cabbage', // Example product name
      'image': 'images/PaniPuri.png', // Example image path
    };
  }

  @override
  void dispose() {
    houseNameController.dispose();
    super.dispose();
  }


void updateCartDetails({
  required int quantity,
  required int price,
  required int scheduleIndex,
  required String productId,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    http.Response res = await http.post(
      Uri.parse('$uri/admin/update-cart-details'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'userId': userProvider.user.id,
        'productId': productId,
        'quantity': quantity,
        'price': price,
        'schedule': widget.schedule['sub-title'][scheduleIndex],
      }),
    );

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        print('Successfully updated cart details');
      },
    );
  } catch (e) {
    showSnackBar(context, e.toString());
    print('Error updating cart details: $e');
  }
}




Future<void> fetchCartProductDetails({
  required String userId,
  required String productId,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    http.Response res = await http.post(
      Uri.parse('$uri/admin/fetch-cart-products'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'userId': userId,
        'productId': productId,
      }),
    );

    if (res.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> data = jsonDecode(res.body);
      String productName = data['product']['name']; // Assuming product name is returned
      int quantity = data['quantity']; // Assuming quantity is returned

      print('Product Name: $productName');
      print('Quantity: $quantity');
    } else {
      print('Error fetching cart product details: ${res.statusCode}');
    }
  } catch (e) {
    showSnackBar(context, e.toString());
    print('Error fetching cart product details: $e');
  }
}




  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<UserProvider>(context).user;
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
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
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
                  'Update Info',
                  style: TextStyle(
                    fontSize: 20,
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
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselImage(),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.category['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Medium',
                          color: Color.fromARGB(255, 53, 125, 56),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.category['sub-title'].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = index;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: _selectedCategoryIndex == index
                                      ? const Color.fromARGB(255, 243, 253, 244)
                                      : const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _selectedCategoryIndex == index
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                                child: Text(
                                  widget.category['sub-title'][index],
                                  style: TextStyle(
                                    color: _selectedCategoryIndex == index
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Medium',
                          color: Color.fromARGB(255, 53, 125, 56),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 15.0,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                alignment: Alignment.center,
                                height: 40,
                              ),
                              
                              Positioned(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 15.0,
                                        spreadRadius: 1.0,
                                        offset: const Offset(0.0, 0.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: NumberPicker(
                                  axis: Axis.horizontal,
                                  itemHeight: 45,
                                  itemWidth: 45.0,
                                  step: 1,
                                  selectedTextStyle: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                  ),
                                  itemCount: 7,
                                  value: _currentValue,
                                  minValue: 0,
                                  maxValue: 100,
                                  onChanged: (value) {
                                    setState(() {
                                      _currentValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Medium',
                          color: Color.fromARGB(255, 53, 125, 56),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 15.0,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                alignment: Alignment.center,
                                height: 40,
                              ),
                              Positioned(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 15.0,
                                        spreadRadius: 1.0,
                                        offset: const Offset(0.0, 0.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: NumberPicker(
                                  axis: Axis.horizontal,
                                  itemHeight: 45,
                                  itemWidth: 45.0,
                                  step: 1,
                                  selectedTextStyle: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                  ),
                                  itemCount: 7,
                                  value: _currentValue2,
                                  minValue: 0,
                                  maxValue: 500,
                                  onChanged: (value) {
                                    setState(() {
                                      _currentValue2 = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Schedule',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Medium',
                          color: Color.fromARGB(255, 53, 125, 56),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.schedule['sub-title'].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedScheduleIndex = index;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: _selectedScheduleIndex == index
                                      ? const Color.fromARGB(255, 243, 253, 244)
                                      : const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _selectedScheduleIndex == index
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                                child: Text(
                                  widget.schedule['sub-title'][index],
                                  style: TextStyle(
                                    color: _selectedScheduleIndex == index
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Medium',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Call updateCartDetails with appropriate parameters
                            updateCartDetails(
                              quantity: _currentValue,
                              price: _currentValue2,
                              scheduleIndex: _selectedScheduleIndex,
                              productId: widget.productId,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Update Info',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SemiBold',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
