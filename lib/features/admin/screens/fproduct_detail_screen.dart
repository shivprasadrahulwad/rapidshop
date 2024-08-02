import 'package:flutter/material.dart';
import 'package:eshop/common/widgets/add_button.dart';
import 'package:numberpicker/numberpicker.dart';

class FProductDetailsScreen extends StatefulWidget {
  FProductDetailsScreen({super.key});

  final Map<String, dynamic> category = {
    'title': 'Green Cabbage',
    'sub-title': [
      '250 g',
      '500 g',
      '1 kg',
    ],
    'price': [
      '₹20',
      '₹40',
      '₹80',
    ],
    'offer-price': [
      '₹19',
      '₹37',
      '₹70',
    ],
  };

  final Map<String, dynamic> Schedule = {
    'title': 'Delivary Schedule',
    'sub-title': [
      '6 AM - 9 AM',
      '7 AM - 10 AM',
      '8 AM - 11 AM',
      '9 AM - 12 PM',
    ],
  };

  int _currentValue = 0;
  int _currentValue2 = 0;

  @override
  State<FProductDetailsScreen> createState() => _FProductDetailsScreenState();
}

class _FProductDetailsScreenState extends State<FProductDetailsScreen> {
  final TextEditingController houseNameController =
      TextEditingController(text: '');

  @override
  void dispose() {
    houseNameController.dispose();
    super.dispose();
  }

  int _selectedCategoryIndex = 0;
  int _selectedScheduleIndex = 0;
  int _currentValue = 0;
  int _currentValue2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                // gradient: GlobalVariables.appBarGradient,
                ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Icon(
                Icons.arrow_back_ios,
                color: Color.fromARGB(255, 0, 0, 0),
                size: 30,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Handle search action
              },
              icon: const Padding(
                padding: EdgeInsets.only(top: 20, right: 10),
                child: Icon(
                  Icons.search_rounded,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "images/PaniPuri.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                widget.category['title'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 53, 125, 56),
                ),
              ),
              const Text(
                "Organic Fresh ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                 Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width *
                      0.85, // Adjust the width as needed
                  child: SizedBox(
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
                              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              child: Column(
                                children: [
                                  Text(
                                    widget.category['sub-title'][index],
                                    style: TextStyle(
                                      color: _selectedCategoryIndex == index
                                          ? const Color.fromARGB(255, 0, 0, 0)
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.category['offer-price'][index],
                                        style: TextStyle(
                                          color: _selectedCategoryIndex == index
                                              ? const Color.fromARGB(255, 0, 0, 0)
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget.category['price'][index],
                                        style: TextStyle(
                                          color: _selectedCategoryIndex == index
                                              ? const Color.fromARGB(255, 0, 0, 0)
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                ),
                ]
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Light grey background color
                  borderRadius: BorderRadius.circular(
                      10), // Border radius for the grey container
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors
                                  .white, // Background color for the image
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'images/meal.png', // Replace with your image path
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Vegetarian',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors
                                  .white, // Background color for the image
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'images/meal.png', // Replace with your image path
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Fresh & Organic',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors
                                  .white, // Background color for the image
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'images/meal.png', // Replace with your image path
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Gluten Free', // Corrected text from "Gulton Free" to "Gluten Free"
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

                  Text(
                "Product Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5,),
              Text(
                "Cauliflower is a cruciferous vegetable that belongs to the Brassicaceae family, which also includes broccoli, kale, and cabbage. It is known for its edible white head, commonly called the 'curd,' which is composed of undeveloped flower buds. The plant features large, green leaves that surround and protect the curd.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
                
              const SizedBox(height: 20),
              const AddProduct(productId: ''),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
