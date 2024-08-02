// import 'dart:io';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:shop/common/widgets/custom_buttons.dart';
// import 'package:shop/common/widgets/custum_textFields.dart';
// import 'package:shop/constants/global_variables.dart';
// import 'package:shop/constants/utils.dart';
// import 'package:shop/features/admin/service/admin_services.dart';

// class AddProductScreenAdmin extends StatefulWidget {
//   static const String routeName = '/add-product';
//   const AddProductScreenAdmin({Key? key}) : super(key: key);

//   @override
//   State<AddProductScreenAdmin> createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreenAdmin> {
//   final TextEditingController productNameController = TextEditingController(text: '');
//   final TextEditingController productDescriptionController = TextEditingController(text: '');
//   final TextEditingController shopNameController = TextEditingController(text:  '');
//   final TextEditingController shopIdController = TextEditingController(text: '');
//   final TextEditingController shopDescriptionController = TextEditingController(text: '');
//   final TextEditingController priceController = TextEditingController(text: '0');
//   final TextEditingController quantityController = TextEditingController(text: '');

//   final AdminServices adminServices = AdminServices();

//   List<File> images = [];
//   final _addProductFormKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     super.dispose();
//     productNameController.dispose();
//     productDescriptionController.dispose();
//     shopDescriptionController.dispose();
//     shopNameController.dispose();
//     shopIdController.dispose();
//     priceController.dispose();
//     quantityController.dispose();
//   }

//   List<String> productCategories = [
//     'AddItems',
//     'Meal',
//     'Snacks',
//     'Drinks',
//     'BreakFast',
//   ];

//   String selectedCategory = 'AddItems'; // Default selected category

//   void sellProduct() {
//   if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {

    
//     adminServices.sellProduct(
//       context: context,
//       productName: productNameController.text,
//       productDescription: productDescriptionController.text,
//       shopName:shopNameController.text,
//       shopDescription:shopDescriptionController.text,
//       shopId:shopIdController.text,
//       price: double.parse(priceController.text),
//       quantity: quantityController.text,
//       category: selectedCategory,
//       images: images,
//     );
//   }
// }


//   void selectImages() async {
//     var res = await pickImages();
//     setState(() {
//       images = res;
//     });
//   }

//   Widget buildCategoryScreen(String category) {
//   switch (category) {
//     case 'AddItems':
//       return AddItemsScreen(
//         addProductFormKey: _addProductFormKey, // Pass the GlobalKey
//         images: images,
//         selectImages: selectImages,
//         productNameController: productNameController,
//         productDescriptionController: productDescriptionController,
//         shopNameController:shopNameController,
//         shopDescriptionController:shopDescriptionController,
//         shopIdController:shopIdController,
//         priceController: priceController ?? TextEditingController(),
//         quantityController: quantityController,
//         sellProduct: sellProduct, // Pass the sellProduct function
//       );
//     case 'Meal':
//       return MealScreen(
//         addProductFormKey: _addProductFormKey, // Pass the GlobalKey
//         images: images,
//         selectImages: selectImages,
//         productNameController: productNameController ,
//         productDescriptionController: productDescriptionController ,
//         shopNameController:shopNameController,
//         shopDescriptionController:shopDescriptionController,
//         shopIdController: shopIdController,
//         priceController: priceController,
//         quantityController: quantityController ?? TextEditingController(),
//         sellProduct: sellProduct,
//       );
//     case 'Drinks':
//       return DrinksScreen(
//         addProductFormKey: _addProductFormKey, // Pass the GlobalKey
//         images: images,
//         selectImages: selectImages,
//         productNameController: productNameController ,
//       productDescriptionController: productDescriptionController ,
//       shopNameController:shopNameController,
//       shopDescriptionController:shopDescriptionController,
//       shopIdController: shopIdController,
//         priceController: priceController,
//         quantityController: quantityController,
//         sellProduct: sellProduct,
//       );
//     case 'BreakFast':
//       return BreakFastScreen(
//         addProductFormKey: _addProductFormKey, // Pass the GlobalKey
//         images: images,
//         selectImages: selectImages,
//         productNameController: productNameController,
//       productDescriptionController: productDescriptionController,
//       shopNameController:shopNameController,
//       shopDescriptionController:shopDescriptionController,
//       shopIdController: shopIdController,
//         priceController: priceController,
//         quantityController: quantityController,
//         sellProduct: sellProduct,
//       );
//     case 'Fashion':
//       return SnacksScreen(
//         addProductFormKey: _addProductFormKey, // Pass the GlobalKey
//         images: images,
//         selectImages: selectImages,
//         productNameController: productNameController,
//         productDescriptionController: productDescriptionController,
//         shopNameController:shopNameController,
//         shopDescriptionController:shopDescriptionController,
//         shopIdController: shopIdController,
//         priceController: priceController,
//         quantityController: quantityController,
//         sellProduct: sellProduct,
//       );
//     default:
//       return Container(); // Default screen
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(50),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//           title: const Text(
//             'Add shop Info',
//             style: TextStyle(
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: DropdownButtonFormField<String>(
//               value: selectedCategory,
//               items: productCategories.map((String category) {
//                 return DropdownMenuItem<String>(
//                   value: category,
//                   child: Text(category),
//                 );
//               }).toList(),
//               onChanged: (String? newVal) {
//                 setState(() {
//                   selectedCategory = newVal!;
//                 });
//               },
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: buildCategoryScreen(selectedCategory),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class AddItemsScreen extends StatelessWidget {
//   final GlobalKey<FormState> addProductFormKey;
//   final List<File> images;
//   final VoidCallback selectImages; 
//   final TextEditingController productNameController;
//   final TextEditingController productDescriptionController;
//   final TextEditingController shopDescriptionController;
//   final TextEditingController shopNameController;
//   final TextEditingController shopIdController;
//   final TextEditingController priceController;
//   final TextEditingController quantityController;
//   final VoidCallback sellProduct; 

//   AddItemsScreen({
//     required this.addProductFormKey,
//     required this.images,
//     required this.selectImages,
//     required this.productNameController,
//     required this.productDescriptionController,
//     required this.shopDescriptionController,
//     required this.shopNameController,
//     required this.shopIdController,
//     required this.priceController,
//     required this.quantityController,
//     required this.sellProduct,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: addProductFormKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: selectImages,
//                 child: images.isNotEmpty
//                     ? CarouselSlider(
//                         items: images.map(
//                           (i) {
//                             return Builder(
//                               builder: (BuildContext context) => Image.file(
//                                 i,
//                                 fit: BoxFit.cover,
//                                 height: 200,
//                               ),
//                             );
//                           },
//                         ).toList(),
//                         options: CarouselOptions(
//                           viewportFraction: 1,
//                           height: 200,
//                         ),
//                       )
//                     : DottedBorder(
//                         borderType: BorderType.RRect,
//                         radius: const Radius.circular(10),
//                         dashPattern: const [10, 4],
//                         strokeCap: StrokeCap.round,
//                         child: Container(
//                           width: double.infinity,
//                           height: 150,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Icon(
//                                 Icons.folder_open,
//                                 size: 40,
//                               ),
//                               const SizedBox(height: 15),
//                               Text(
//                                 'Select Product Image',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.grey.shade400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 30),
//               CustomTextField(
//                 controller: shopIdController,
//                 hintText: 'shop Id',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: productNameController,
//                 hintText: 'Product Name',
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a product name';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: productDescriptionController,
//                 hintText: 'Product Description',
//                 maxLines: 7,
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a product description';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: quantityController,
//                 hintText: 'Price',
//               ),

//               const SizedBox(height: 10),
//               CustomButton(
//                 text: 'ADD',
//                 onTap: sellProduct,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// class MealScreen extends StatelessWidget {
//   final GlobalKey<FormState> addProductFormKey;
//   final List<File> images;
//   final VoidCallback selectImages; // Changed the type to VoidCallback
//   final TextEditingController productNameController;
//   final TextEditingController productDescriptionController;
//   final TextEditingController shopDescriptionController;
//   final TextEditingController shopNameController;
//   final TextEditingController shopIdController;
//   final TextEditingController priceController;
//   final TextEditingController quantityController;
//   final VoidCallback sellProduct; // Changed the type to VoidCallback

//   MealScreen({
//     required this.addProductFormKey,
//     required this.images,
//     required this.selectImages,
//     required this.productNameController,
//     required this.productDescriptionController,
//     required this.shopDescriptionController,
//     required this.shopNameController,
//     required this.shopIdController,
//     required this.priceController,
//     required this.quantityController,
//     required this.sellProduct,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: addProductFormKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: selectImages,
//                 child: images.isNotEmpty
//                     ? CarouselSlider(
//                         items: images.map(
//                           (i) {
//                             return Builder(
//                               builder: (BuildContext context) => Image.file(
//                                 i,
//                                 fit: BoxFit.cover,
//                                 height: 200,
//                               ),
//                             );
//                           },
//                         ).toList(),
//                         options: CarouselOptions(
//                           viewportFraction: 1,
//                           height: 200,
//                         ),
//                       )
//                     : DottedBorder(
//                         borderType: BorderType.RRect,
//                         radius: const Radius.circular(10),
//                         dashPattern: const [10, 4],
//                         strokeCap: StrokeCap.round,
//                         child: Container(
//                           width: double.infinity,
//                           height: 150,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Icon(
//                                 Icons.folder_open,
//                                 size: 40,
//                               ),
//                               const SizedBox(height: 15),
//                               Text(
//                                 'Select Meal Image',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.grey.shade400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 30),
//               CustomTextField(
//                 controller: shopNameController,
//                 hintText: 'shop Name',
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a shop name';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),

//               const SizedBox(height: 30),
//               CustomTextField(
//                 controller: shopIdController,
//                 hintText: 'shop Id',
//               ),

//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: shopDescriptionController,
//                 hintText: 'Description',
//                 maxLines: 7,
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a shop description';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: quantityController,
//                 hintText: 'Location',
//               ),
//               const SizedBox(height: 10),
              
//               CustomButton(
//                 text: 'Publish',
//                 onTap: sellProduct,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// class SnacksScreen extends StatelessWidget {
//   final GlobalKey<FormState> addProductFormKey;
//   final List<File> images;
//   final VoidCallback selectImages; // Changed the type to VoidCallback
//   final TextEditingController productNameController;
//   final TextEditingController productDescriptionController;
//   final TextEditingController shopDescriptionController;
//   final TextEditingController shopNameController;
//   final TextEditingController shopIdController;
//   final TextEditingController priceController;
//   final TextEditingController quantityController;
//   final VoidCallback sellProduct; // Changed the type to VoidCallback

//   SnacksScreen({
//     required this.addProductFormKey,
//     required this.images,
//     required this.selectImages,
//     required this.productNameController,
//     required this.productDescriptionController,
//     required this.shopDescriptionController,
//     required this.shopNameController,
//     required this.shopIdController,
//     required this.priceController,
//     required this.quantityController,
//     required this.sellProduct,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: addProductFormKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: selectImages,
//                 child: images.isNotEmpty
//                     ? CarouselSlider(
//                         items: images.map(
//                           (i) {
//                             return Builder(
//                               builder: (BuildContext context) => Image.file(
//                                 i,
//                                 fit: BoxFit.cover,
//                                 height: 200,
//                               ),
//                             );
//                           },
//                         ).toList(),
//                         options: CarouselOptions(
//                           viewportFraction: 1,
//                           height: 200,
//                         ),
//                       )
//                     : DottedBorder(
//                         borderType: BorderType.RRect,
//                         radius: const Radius.circular(10),
//                         dashPattern: const [10, 4],
//                         strokeCap: StrokeCap.round,
//                         child: Container(
//                           width: double.infinity,
//                           height: 150,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Icon(
//                                 Icons.folder_open,
//                                 size: 40,
//                               ),
//                               const SizedBox(height: 15),
//                               Text(
//                                 'Select Meal Image',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.grey.shade400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 30),
//               CustomTextField(
//                 controller: shopNameController,
//                 hintText: 'shop Name',
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a shop name';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),

//               const SizedBox(height: 30),
//               CustomTextField(
//                 controller: productNameController,
//                 hintText: 'shop Id',
//               ),
//               const SizedBox(height: 10),
              
//               CustomTextField(
//                 controller: shopDescriptionController,
//                 hintText: 'Description',
//                 maxLines: 7,
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a shop description';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: quantityController,
//                 hintText: 'Location',
//               ),
//               const SizedBox(height: 10),
              
//               CustomButton(
//                 text: 'Publish',
//                 onTap: sellProduct,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// // Similarly define screens for other categories (AppliancesScreen, BooksScreen, FashionScreen)


// class DrinksScreen extends StatelessWidget {
//   final GlobalKey<FormState> addProductFormKey;
//   final List<File> images;
//   final VoidCallback selectImages; // Changed the type to VoidCallback
//   final TextEditingController productNameController;
//   final TextEditingController productDescriptionController;
//   final TextEditingController shopDescriptionController;
//   final TextEditingController shopNameController;
//   final TextEditingController shopIdController;
//   final TextEditingController priceController;
//   final TextEditingController quantityController;
//   final VoidCallback sellProduct; // Changed the type to VoidCallback

//   DrinksScreen({
//     required this.addProductFormKey,
//     required this.images,
//     required this.selectImages,
//     required this.productNameController,
//     required this.productDescriptionController,
//     required this.shopDescriptionController,
//     required this.shopNameController,
//     required this.shopIdController,
//     required this.priceController,
//     required this.quantityController,
//     required this.sellProduct,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: addProductFormKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: selectImages,
//                 child: images.isNotEmpty
//                     ? CarouselSlider(
//                         items: images.map(
//                           (i) {
//                             return Builder(
//                               builder: (BuildContext context) => Image.file(
//                                 i,
//                                 fit: BoxFit.cover,
//                                 height: 200,
//                               ),
//                             );
//                           },
//                         ).toList(),
//                         options: CarouselOptions(
//                           viewportFraction: 1,
//                           height: 200,
//                         ),
//                       )
//                     : DottedBorder(
//                         borderType: BorderType.RRect,
//                         radius: const Radius.circular(10),
//                         dashPattern: const [10, 4],
//                         strokeCap: StrokeCap.round,
//                         child: Container(
//                           width: double.infinity,
//                           height: 150,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Icon(
//                                 Icons.folder_open,
//                                 size: 40,
//                               ),
//                               const SizedBox(height: 15),
//                               Text(
//                                 'Select Drink Image',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.grey.shade400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 30),
//               CustomTextField(
//                 controller: shopNameController,
//                 hintText: 'shop Name',
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a shop name';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),

//               const SizedBox(height: 30),
//               CustomTextField(
//                 controller: productNameController,
//                 hintText: 'shop Id',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: shopDescriptionController,
//                 hintText: 'Description',
//                 maxLines: 7,
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a shop description';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: quantityController,
//                 hintText: 'Location',
//               ),
//               const SizedBox(height: 10),
              
//               CustomButton(
//                 text: 'Publish',
//                 onTap: sellProduct,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // Similarly define screens for other categories (AppliancesScreen, BooksScreen, FashionScreen)


// class BreakFastScreen extends StatelessWidget {
//   final GlobalKey<FormState> addProductFormKey;
//   final List<File> images;
//   final VoidCallback selectImages; // Changed the type to VoidCallback
//   final TextEditingController productNameController;
//   final TextEditingController productDescriptionController;
//   final TextEditingController shopDescriptionController;
//   final TextEditingController shopNameController;
//   final TextEditingController shopIdController;
//   final TextEditingController priceController;
//   final TextEditingController quantityController;
//   final VoidCallback sellProduct; // Changed the type to VoidCallback

//   BreakFastScreen({
//     required this.addProductFormKey,
//     required this.images,
//     required this.selectImages,
//     required this.productNameController,
//     required this.productDescriptionController,
//     required this.shopDescriptionController,
//     required this.shopNameController,
//     required this.shopIdController,
//     required this.priceController,
//     required this.quantityController,
//     required this.sellProduct,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: addProductFormKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: selectImages,
//                 child: images.isNotEmpty
//                     ? CarouselSlider(
//                         items: images.map(
//                           (i) {
//                             return Builder(
//                               builder: (BuildContext context) => Image.file(
//                                 i,
//                                 fit: BoxFit.cover,
//                                 height: 200,
//                               ),
//                             );
//                           },
//                         ).toList(),
//                         options: CarouselOptions(
//                           viewportFraction: 1,
//                           height: 200,
//                         ),
//                       )
//                     : DottedBorder(
//                         borderType: BorderType.RRect,
//                         radius: const Radius.circular(10),
//                         dashPattern: const [10, 4],
//                         strokeCap: StrokeCap.round,
//                         child: Container(
//                           width: double.infinity,
//                           height: 150,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Icon(
//                                 Icons.folder_open,
//                                 size: 40,
//                               ),
//                               const SizedBox(height: 15),
//                               Text(
//                                 'Select Image',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.grey.shade400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 30),
//               CustomTextField(
//                 controller: shopNameController,
//                 hintText: 'shop Name',
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a shop name';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),

//               const SizedBox(height: 30),
//               CustomTextField(
//                 controller: productNameController,
//                 hintText: 'shop Id',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: shopDescriptionController,
//                 hintText: 'Description',
//                 maxLines: 7,
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a shop description';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: quantityController,
//                 hintText: 'Location',
//               ),
//               const SizedBox(height: 10),
              
//               CustomButton(
//                 text: 'Publish',
//                 onTap: sellProduct,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
