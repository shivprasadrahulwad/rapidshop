import 'package:flutter/material.dart';
import 'package:eshop/features/home/widgets/address_box.dart';
import 'package:eshop/features/home/widgets/carousel_image.dart';
import 'dart:async';

import 'package:eshop/features/home/widgets/top_categories.dart';
import 'package:eshop/features/search/screens/search_screen.dart';

class FoodScreen extends StatefulWidget {
  static const String routeName = '/food';
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  late Stream<String> _hintStream;
  late StreamSubscription<String> _hintSubscription;
  String currentHint = "Search For Home"; // Default hint text

  // void navigateToSearchScreen(String query) {
  //   Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  // }

  @override
  void initState() {
    super.initState();
    _hintStream = hintStream();
    _hintSubscription = _hintStream.listen((hint) {
      setState(() {
        currentHint = hint;
      });
    });
  }

  @override
  void dispose() {
    _hintSubscription.cancel();
    super.dispose();
  }

Stream<String> hintStream() async* {
  while (true) {
    yield "Search for 'Cake'";
    await Future.delayed(const Duration(seconds: 2));
    yield "Search for 'Biryani'";
    await Future.delayed(const Duration(seconds: 2));
    yield "Search for 'IceCream'";
    await Future.delayed(const Duration(seconds: 2));
    yield "Search for 'Sweets'";
    await Future.delayed(const Duration(seconds: 2));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AddressBox() ,
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text("Hello, Shivam",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20
                          ),),
                            ],
                          ),
                          Icon(
                              Icons.account_balance_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          
                          child: TextFormField(
                            //  onFieldSubmitted: navigateToSearchScreen,
                            decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: const EdgeInsets.only(top: 10),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 1,
                                ),
                              ),
                              hintText: currentHint,
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // RentTopCategories() widget here
                    const TopCategories(),
                  ],
                ),
              ),
            ),
            // CarouselImage() widget here
            const CarouselImage(),
            const SizedBox(height: 10),
            // What's On Your Mind? widget here
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "What's On Your Mind?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Opacity(
                    opacity: 0.9,
                    child: Container(
                      height: 2,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.09),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const TopCategories(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Popular Locations!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Opacity(
                    opacity: 0.9,
                    child: Container(
                      height: 2,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.09),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),

            SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Row(
      children: [
        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),

        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),

  
        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),

  
        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),
  
        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),

  
        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),

        // Add more containers here with different colors
      ],
    ),
  ),
),

 SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Row(
      children: [
        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),

        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),

  
        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),

  
        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),
  
        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),

  
        Container(
  width: 80,
  height: 80,
  margin: const EdgeInsets.only(right: 10), // spacing between containers
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // circular corners
    image: const DecorationImage(
      image: AssetImage('images/PaniPuri.png'), // Replace 'background_image.png' with your image asset path
      fit: BoxFit.cover, // Adjust the fit as per your requirement
    ),
  ),
  child: const Center(
    // child: Text('Sweets', style: TextStyle(color: Colors.white)),
  ),
),

        // Add more containers here with different colors
      ],
    ),
  ),
),

            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Dine Out!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Opacity(
                    opacity: 0.9,
                    child: Container(
                      height: 2,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.09),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/canva.png",
                                height: 230,
                                width: 290,
                                fit: BoxFit.cover,
                              ),
                              const Text("Veggie Taco Hash"),
                              const SizedBox(height: 5.0),
                              const Text("Fresh and Healthy"),
                              const SizedBox(height: 5.0),
                              const Text("\$25"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: Column(  
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/canva.png",
                                height: 230,
                                width: 290,
                                fit: BoxFit.cover,
                              ),
                              const Text("Another Item"),
                              const SizedBox(height: 5.0),
                              const Text("Description"),
                              const SizedBox(height: 5.0),
                              const Text("\$30"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Add more containers similarly
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}