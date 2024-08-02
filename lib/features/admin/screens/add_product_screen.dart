// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:shop/common/widgets/custom_buttons.dart';
// import 'package:shop/common/widgets/custum_textFields.dart';
// import 'package:shop/constants/global_variables.dart';
// import 'package:shop/constants/utils.dart';
// import 'package:shop/features/admin/service/admin_services.dart';

// class AddProductScreen extends StatefulWidget {
//   static const String routeName = '/add';
//   const AddProductScreen({Key? key}) : super(key: key);

//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final TextEditingController productNameController = TextEditingController();
//   final TextEditingController productDescriptionController = TextEditingController();
//   final TextEditingController shopNameController= TextEditingController();
//   final TextEditingController shopDescriptionController = TextEditingController();
//   final TextEditingController shopIdController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//   final AdminServices adminServices = AdminServices();

//   String category = 'Mobiles';
//   List<File> images = [];
//   final _addProductFormKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     super.dispose();
//     productNameController.dispose();
//     productDescriptionController.dispose();
//     shopNameController.dispose();
//     shopDescriptionController.dispose();
//     shopIdController.dispose();
//     priceController.dispose();
//     quantityController.dispose();
//   }

//   List<String> productCategories = [
//     'Mobiles',
//     'Essentials',
//     'Appliances',
//     'Books',
//     'Fashion'
//   ];

//  void sellProduct() {
//   if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
//     double price;
//     try {
//       price = double.parse(priceController.text);
//     } catch (e) {
//       // Handle the invalid price format gracefully
//       print('Invalid price format: ${priceController.text}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Invalid price format: ${priceController.text}'),
//         ),
//       );
//       return;
//     }

//     // Add additional validation checks here if needed

//     // If all validation passes, sell the product
//     adminServices.sellProduct(
//       context: context,
//       shopName: productNameController.text,
//       shopDescription: shopDescriptionController.text,
//       shopId: shopIdController.text,
//       productName: productNameController.text,
//       productDescription: productDescriptionController.text,
//       price: price,
//       quantity: quantityController.text,
//       category: category,
//       images: images,
//     );
//   } else {
//     // If validation fails, show a generic error message
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Product validation failed. Please check your input.'),
//       ),
//     );
//   }
// }


//   void selectImages() async {
//     var res = await pickImages();
//     setState(() {
//       images = res;
//     });
//   }

//   void navigateToCategory(String selectedCategory) {
//     // Implement navigation logic here, for now, print selected category
//     print('Selected category: $selectedCategory');
//   }

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
//             'Add Product',
//             style: TextStyle(
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _addProductFormKey,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: Column(
//               children: [
//                 // Display category images dynamically
//                 // Wrap(
//                 //   spacing: 10,
//                 //   children: productCategories.map((category) {
//                 //     return GestureDetector(
//                 //       onTap: () => navigateToCategory(category),
//                 //       child: Image.asset(
//                 //         '${category.toLowerCase()}.jpg', // Assuming category images are named accordingly
//                 //         width: 100,
//                 //         height: 100,
//                 //         fit: BoxFit.cover,
//                 //       ),
//                 //     );
//                 //   }).toList(),
//                 // ),
//                 const SizedBox(height: 20),
//                 // Rest of the UI remains unchanged
//                 images.isNotEmpty
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
//                     : GestureDetector(
//                         onTap: selectImages,
//                         child: DottedBorder(
//                           borderType: BorderType.RRect,
//                           radius: const Radius.circular(10),
//                           dashPattern: const [10, 4],
//                           strokeCap: StrokeCap.round,
//                           child: Container(
//                             width: double.infinity,
//                             height: 150,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(
//                                   Icons.folder_open,
//                                   size: 40,
//                                 ),
//                                 const SizedBox(height: 15),
//                                 Text(
//                                   'Select Product Images',
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     color: Colors.grey.shade400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                 const SizedBox(height: 30),
//                 CustomTextField(
//                   controller: productNameController,
//                   hintText: 'Product Name',
//                 ),
//                 const SizedBox(height: 10),
//                 CustomTextField(
//                   controller: productDescriptionController,
//                   hintText: 'Description',
//                   maxLines: 7,
//                 ),
//                 const SizedBox(height: 10),
//                 CustomTextField(
//                   controller: priceController,
//                   hintText: 'Price',
//                 ),
//                 const SizedBox(height: 10),
//                 CustomTextField(
//                   controller: quantityController,
//                   hintText: 'quantity',
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   width: double.infinity,
//                   child: DropdownButton(
//                     value: category,
//                     icon: const Icon(Icons.keyboard_arrow_down),
//                     items: productCategories.map((String item) {
//                       return DropdownMenuItem(
//                         value: item,
//                         child: Text(item),
//                       );
//                     }).toList(),
//                     onChanged: (String? newVal) {
//                       setState(() {
//                         category = newVal!;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 CustomButton(
//                   text: 'Sell',
//                   onTap: sellProduct,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
