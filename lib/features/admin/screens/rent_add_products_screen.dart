// import 'dart:io';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:shop/common/widgets/custom_buttons.dart';
// import 'package:shop/common/widgets/custum_textFields.dart';
// import 'package:shop/common/widgets/date_picker.dart';
// import 'package:shop/constants/global_variables.dart';
// import 'package:shop/constants/utils.dart';
// import 'package:shop/features/admin/service/admin_services.dart';

// class RentAddProductScreenAdmin extends StatefulWidget {
//   static const String routeName = '/add-product-rent';
//   const RentAddProductScreenAdmin({Key? key}) : super(key: key);
  

//   @override
//   State<RentAddProductScreenAdmin> createState() => _AddProductScreenState();
// }



// class _AddProductScreenState extends State<RentAddProductScreenAdmin> {
//   final TextEditingController ownerNameController = TextEditingController(text: '');
//   final TextEditingController mobileNoController = TextEditingController(text: '');
//   final TextEditingController houseNameController = TextEditingController(text:  '');
//   final TextEditingController rentController = TextEditingController(text: '');
//   final TextEditingController depositController = TextEditingController(text: '');
//   final TextEditingController genderController = TextEditingController(text: '');
//   final TextEditingController furnishController = TextEditingController(text: '');
//   final TextEditingController wifiController = TextEditingController(text: '');
//   final TextEditingController parkingController = TextEditingController(text: '');
//   final TextEditingController dateController = TextEditingController(text: '');
//   final TextEditingController securityController = TextEditingController(text: '');

//   final AdminServices adminServices = AdminServices();


//   List<File> images = [];
//   final _addProductFormKey = GlobalKey<FormState>();
  

//   @override
//   void dispose() {
//     super.dispose();
//     ownerNameController.dispose();
//     houseNameController.dispose();
//     mobileNoController.dispose();
//     rentController.dispose();
//     depositController.dispose();
//     wifiController.dispose();
//     securityController.dispose();
//     dateController.dispose();
//     parkingController.dispose();
//     furnishController.dispose();
//     genderController.dispose();
//   }

//   List<String> productCategories = [
//     'Hostel',
//     '1 BHK Flat',
//     '2 BHK Flat',
//     '1 RK',
//   ];

//   String selectedCategory = 'Hostel'; 
//   String selectedGender = 'Male';
//   String selectedFerniture= 'None';
//   String selectedWifi= 'No';
//   String selectedParking = 'No';

//   void rentSellProduct() {
//   if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {

//     adminServices.rentSellProduct(
//       context: context, 
//       category: selectedCategory, 
//       ownerName: ownerNameController.text, 
//       mobileNo: double.parse(mobileNoController.text), 
//       houseName: houseNameController.text, 
//       rent: double.parse(rentController.text), 
//       deposit: double.parse(depositController.text), 
//       gender: genderController.text, 
//       furnish: furnishController.text, 
//       wifi: wifiController.text, 
//       security: securityController.text, 
//       parking: parkingController.text, 
//       date: dateController.text, 
//       images: images);
//   }
// }


//   void selectImages() async {
//     var res = await pickImages();
//     setState(() {
//       images = res;
//     });
//   }

//   void updateSelectedGender(String gender ,) {
//     setState(() {
//       selectedGender = gender;
//     });
//   }

//   void updateSelectedFerniture(String ferniture ,) {
//     setState(() {
//       selectedFerniture = ferniture;
//     });
//   }

//   void updateSelectedWifi(String wifi ,) {
//     setState(() {
//       selectedWifi = wifi;
//     });
//   }

//   void updateSelectedParking(String parking ,) {
//     setState(() {
//       selectedParking = parking;
//     });
//   }

//   void updateSelectedSecurity(String security ,) {
//     setState(() {
//       selectedParking = security;
//     });
//   }

  

//   Widget buildCategoryScreen(String category) {
//   switch (category) {
//     case '1 BHK':
//       return OneBhkScreen(
//         addProductFormKey: _addProductFormKey, // Pass the GlobalKey
//         images: images,
//         selectImages: selectImages,
//         ownerNameController:ownerNameController,
//         houseNameController: houseNameController,
//         mobileNoController: mobileNoController,
//         rentController: rentController,
//         depositController: depositController,
//         parkingController: parkingController,
//         wifiController: wifiController,
//         dateController: dateController,
//         genderController: genderController,
//         securityController: securityController,
//         furnishController: furnishController,
//         rentSellProduct: rentSellProduct, // Pass the sellProduct function
//       );
//     case '2 BHK':
//       return TwoBhkScreen(
//         addProductFormKey: _addProductFormKey, // Pass the GlobalKey
//         images: images,
//         selectImages: selectImages,
//         ownerNameController:ownerNameController,
//         houseNameController: houseNameController,
//         mobileNoController: mobileNoController,
//         rentController: rentController,
//         depositController: depositController,
//         parkingController: parkingController,
//         wifiController: wifiController,
//         dateController: dateController,
//         genderController: genderController,
//         securityController: securityController,
//         furnishController: furnishController,
//         rentSellProduct: rentSellProduct,
//       );
//     case '1 RK':
//       return OneRkScreen(
//         addProductFormKey: _addProductFormKey, // Pass the GlobalKey
//         images: images,
//         selectImages: selectImages,
//         ownerNameController:ownerNameController,
//         houseNameController: houseNameController,
//         mobileNoController: mobileNoController,
//         rentController: rentController,
//         depositController: depositController,
//         parkingController: parkingController,
//         wifiController: wifiController,
//         dateController: dateController,
//         genderController: genderController,
//         securityController: securityController,
//         furnishController: furnishController,
//         rentSellProduct: rentSellProduct,
//       );
//     case 'Hostel':
//       return HostelScreen(
//         addProductFormKey: _addProductFormKey, // Pass the GlobalKey
//         images: images,
//         selectImages: selectImages,
//         ownerNameController:ownerNameController,
//         houseNameController: houseNameController,
//         mobileNoController: mobileNoController,
//         rentController: rentController,
//         depositController: depositController,
//         parkingController: parkingController,
//         wifiController: wifiController,
//         dateController: dateController,
//         genderController: genderController,
//         securityController: securityController,
//         furnishController: furnishController,
//         rentSellProduct: rentSellProduct,
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
//             'Add Rent Info',
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



// class OneBhkScreen extends StatefulWidget {
//   final GlobalKey<FormState> addProductFormKey;
//   final List<File> images;
//   final VoidCallback selectImages; 
//   final TextEditingController ownerNameController;
//   final TextEditingController houseNameController;
//   final TextEditingController mobileNoController;
//   final TextEditingController rentController;
//   final TextEditingController depositController;
//   final TextEditingController genderController;
//   final TextEditingController wifiController;
//   final TextEditingController parkingController;
//   final TextEditingController furnishController;
//   final TextEditingController dateController;
//   final TextEditingController securityController;
//   final VoidCallback rentSellProduct; 

//   OneBhkScreen({
//     required this.addProductFormKey,
//     required this.images,
//     required this.selectImages,
//     required this.ownerNameController,
//     required this.houseNameController,
//     required this.mobileNoController,
//     required this.rentController,
//     required this.depositController,
//     required this.wifiController,
//     required this.parkingController,
//     required this.genderController,
//     required this.furnishController,
//     required this.dateController,
//     required this.securityController,
//     required this.rentSellProduct,
//   });

//   @override
//   State<OneBhkScreen> createState() => _OneBhkScreenState();
// }

// class _OneBhkScreenState extends State<OneBhkScreen> {
//   var selectedGender='Male';
//   var selectedFerniture='None';
//   var selectedWifi='No';
//   var selectedParking='No';
//   var selectedSecurity='None';

//   @override
//   Widget build(BuildContext context) {
    
//     return SingleChildScrollView(
//       child: Form(
//         key: widget.addProductFormKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: widget.selectImages,
//                 child: widget.images.isNotEmpty
//                     ? CarouselSlider(
//                         items: widget.images.map(
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
//                 controller: widget.ownerNameController,
//                 hintText: 'Your Name',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.mobileNoController,
//                 hintText: 'Your Mobile No.',
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter Mobile Number';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),
//               const SizedBox(height: 10),

//               CustomTextField(
//                 controller: widget.houseNameController,
//                 hintText: 'House Name',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.rentController,
//                 hintText: 'Rent',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.depositController,
//                 hintText: 'Deposit',
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Preferred Gender'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Male',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         widget.genderController.text=selectedGender;
//                       });
//                     },
//                   ),
//                   const Text('Male'),
//                   Radio(
//                     value: 'Female',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         widget.genderController.text=selectedGender;
//                       });
//                     },
//                   ),
//                   const Text('Female'),
//                 ],
//               ),


//               const Text(
//                 'Furnishing'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Full',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('Full'),
//                   Radio(
//                     value: 'Semi',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('Semi'),
//                   Radio(
//                     value: 'None',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('None'),
//                 ],
//               ),

//               const Text(
//                 'Wifi'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Available',
//                     groupValue:selectedWifi,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedWifi = value.toString();
//                         widget.wifiController.text=selectedWifi;
//                       });
//                     },
//                   ),
//                   const Text('Available'),
//                   Radio(
//                     value: 'No',
//                     groupValue: selectedWifi,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedWifi = value.toString();
//                         widget.wifiController.text=selectedWifi;
//                       });
//                     },
//                   ),
//                   const Text('No'),
//                 ],
//               ),


//               const Text(
//                 'Security'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: '24*7 Security',
//                     groupValue:selectedSecurity,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedSecurity = value.toString();
//                         widget.securityController.text=selectedSecurity;
//                       });
//                     },
//                   ),
//                   const Text('24*7 Security'),
//                   Radio(
//                     value: 'None',
//                     groupValue: selectedSecurity,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedSecurity = value.toString();
//                         widget.securityController.text=selectedSecurity;
//                       });
//                     },
//                   ),
//                   const Text('None'),
//                 ],
//               ),


//               const Text(
//                 'Parking'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Available',
//                     groupValue:selectedParking,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedParking = value.toString();
//                         widget.parkingController.text=selectedParking;
//                       });
//                     },
//                   ),
//                   const Text('Available'),
//                   Radio(
//                     value: 'No',
//                     groupValue: selectedParking,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedParking = value.toString();
//                         widget.parkingController.text=selectedParking;
//                       });
//                     },
//                   ),
//                   const Text('No'),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               // CustomTextField(
//               //   controller: widget.shopIdController,
//               //   hintText: 'Available From Date',
//               // ),
//               const Text('Available From Date',style: TextStyle(
//                 fontSize: 15,
//               ),),
//               const SizedBox(height: 10),
//               const CustomDatePicker(),

//               const SizedBox(height: 10),
//               CustomButton(
//                 text: 'Submit',
//                 onTap: widget.rentSellProduct,
//               ),
//               const SizedBox(height: 20),
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// class TwoBhkScreen extends StatefulWidget {
//   final GlobalKey<FormState> addProductFormKey;
//   final List<File> images;
//   final VoidCallback selectImages; // Changed the type to VoidCallback
//   final TextEditingController ownerNameController;
//   final TextEditingController houseNameController;
//   final TextEditingController mobileNoController;
//   final TextEditingController rentController;
//   final TextEditingController depositController;
//   final TextEditingController genderController;
//   final TextEditingController wifiController;
//   final TextEditingController parkingController;
//   final TextEditingController furnishController;
//   final TextEditingController dateController;
//   final TextEditingController securityController;
//   final VoidCallback rentSellProduct;

//   TwoBhkScreen({
//     required this.addProductFormKey,
//     required this.images,
//     required this.selectImages,
//     required this.ownerNameController,
//     required this.houseNameController,
//     required this.mobileNoController,
//     required this.rentController,
//     required this.depositController,
//     required this.wifiController,
//     required this.parkingController,
//     required this.genderController,
//     required this.furnishController,
//     required this.dateController,
//     required this.securityController,
//     required this.rentSellProduct,
//   });

//   @override
//   State<TwoBhkScreen> createState() => _TwoBhkScreenState();
// }

// class _TwoBhkScreenState extends State<TwoBhkScreen> {
//   var selectedGender='Male';
//   var selectedFerniture='None';
//   var selectedWifi='No';
//   var selectedParking='No';
//   var selectedSecurity='None';
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: widget.addProductFormKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: widget.selectImages,
//                 child: widget.images.isNotEmpty
//                     ? CarouselSlider(
//                         items: widget.images.map(
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
//                 controller: widget.ownerNameController,
//                 hintText: 'Your Name',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.mobileNoController,
//                 hintText: 'Your Mobile No.',
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter Mobile Number';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),
//               const SizedBox(height: 10),

//               CustomTextField(
//                 controller: widget.houseNameController,
//                 hintText: 'House Name',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.rentController,
//                 hintText: 'Rent',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.depositController,
//                 hintText: 'Deposit',
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Preferred Gender'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Male',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         widget.genderController.text=selectedGender;
//                       });
//                     },
//                   ),
//                   const Text('Male'),
//                   Radio(
//                     value: 'Female',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         widget.genderController.text=selectedGender;
//                       });
//                     },
//                   ),
//                   const Text('Female'),
//                 ],
//               ),


//               const Text(
//                 'Furnishing'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Full',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('Full'),
//                   Radio(
//                     value: 'Semi',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('Semi'),
//                   Radio(
//                     value: 'None',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('None'),
//                 ],
//               ),

//               const Text(
//                 'Wifi'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Available',
//                     groupValue:selectedWifi,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedWifi = value.toString();
//                         widget.wifiController.text=selectedWifi;
//                       });
//                     },
//                   ),
//                   const Text('Available'),
//                   Radio(
//                     value: 'No',
//                     groupValue: selectedWifi,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedWifi = value.toString();
//                         widget.wifiController.text=selectedWifi;
//                       });
//                     },
//                   ),
//                   const Text('No'),
//                 ],
//               ),


//               const Text(
//                 'Security'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: '24*7 Security',
//                     groupValue:selectedSecurity,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedSecurity = value.toString();
//                         widget.securityController.text=selectedSecurity;
//                       });
//                     },
//                   ),
//                   const Text('24*7 Security'),
//                   Radio(
//                     value: 'None',
//                     groupValue: selectedSecurity,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedSecurity = value.toString();
//                         widget.securityController.text=selectedSecurity;
//                       });
//                     },
//                   ),
//                   const Text('None'),
//                 ],
//               ),


//               const Text(
//                 'Parking'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Available',
//                     groupValue:selectedParking,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedParking = value.toString();
//                         widget.parkingController.text=selectedParking;
//                       });
//                     },
//                   ),
//                   const Text('Available'),
//                   Radio(
//                     value: 'No',
//                     groupValue: selectedParking,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedParking = value.toString();
//                         widget.parkingController.text=selectedParking;
//                       });
//                     },
//                   ),
//                   const Text('No'),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               // CustomTextField(
//               //   controller: widget.shopIdController,
//               //   hintText: 'Available From Date',
//               // ),
//               const Text('Available From Date',style: TextStyle(
//                 fontSize: 15,
//               ),),
//               const SizedBox(height: 10),
//               const CustomDatePicker(),

//               const SizedBox(height: 10),
//               CustomButton(
//                 text: 'Submit',
//                 onTap: widget.rentSellProduct,
//               ),
//               const SizedBox(height: 20),
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// // // Similarly define screens for other categories (AppliancesScreen, BooksScreen, FashionScreen)


// class OneRkScreen extends StatefulWidget {
//   final GlobalKey<FormState> addProductFormKey;
//   final List<File> images;
//   final VoidCallback selectImages; // Changed the type to VoidCallback
//   final TextEditingController ownerNameController;
//   final TextEditingController houseNameController;
//   final TextEditingController mobileNoController;
//   final TextEditingController rentController;
//   final TextEditingController depositController;
//   final TextEditingController genderController;
//   final TextEditingController wifiController;
//   final TextEditingController parkingController;
//   final TextEditingController furnishController;
//   final TextEditingController dateController;
//   final TextEditingController securityController;
//   final VoidCallback rentSellProduct;

//   OneRkScreen({
//     required this.addProductFormKey,
//     required this.images,
//     required this.selectImages,
//     required this.ownerNameController,
//     required this.houseNameController,
//     required this.mobileNoController,
//     required this.rentController,
//     required this.depositController,
//     required this.wifiController,
//     required this.parkingController,
//     required this.genderController,
//     required this.furnishController,
//     required this.dateController,
//     required this.securityController,
//     required this.rentSellProduct,
//   });

//   @override
//   State<OneRkScreen> createState() => _OneRkScreenState();
// }

// class _OneRkScreenState extends State<OneRkScreen> {
//   var selectedGender='Male';
//   var selectedFerniture='None';
//   var selectedWifi='No';
//   var selectedParking='No';
//   var selectedSecurity='None';
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: widget.addProductFormKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: widget.selectImages,
//                 child: widget.images.isNotEmpty
//                     ? CarouselSlider(
//                         items: widget.images.map(
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
//                 controller: widget.ownerNameController,
//                 hintText: 'Your Name',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.mobileNoController,
//                 hintText: 'Your Mobile No.',
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter Mobile Number';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),
//               const SizedBox(height: 10),

//               CustomTextField(
//                 controller: widget.houseNameController,
//                 hintText: 'House Name',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.rentController,
//                 hintText: 'Rent',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.depositController,
//                 hintText: 'Deposit',
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Preferred Gender'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Male',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         widget.genderController.text=selectedGender;
//                       });
//                     },
//                   ),
//                   const Text('Male'),
//                   Radio(
//                     value: 'Female',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         widget.genderController.text=selectedGender;
//                       });
//                     },
//                   ),
//                   const Text('Female'),
//                 ],
//               ),


//               const Text(
//                 'Furnishing'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Full',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('Full'),
//                   Radio(
//                     value: 'Semi',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('Semi'),
//                   Radio(
//                     value: 'None',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('None'),
//                 ],
//               ),

//               const Text(
//                 'Wifi'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Available',
//                     groupValue:selectedWifi,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedWifi = value.toString();
//                         widget.wifiController.text=selectedWifi;
//                       });
//                     },
//                   ),
//                   const Text('Available'),
//                   Radio(
//                     value: 'No',
//                     groupValue: selectedWifi,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedWifi = value.toString();
//                         widget.wifiController.text=selectedWifi;
//                       });
//                     },
//                   ),
//                   const Text('No'),
//                 ],
//               ),


//               const Text(
//                 'Security'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: '24*7 Security',
//                     groupValue:selectedSecurity,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedSecurity = value.toString();
//                         widget.securityController.text=selectedSecurity;
//                       });
//                     },
//                   ),
//                   const Text('24*7 Security'),
//                   Radio(
//                     value: 'None',
//                     groupValue: selectedSecurity,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedSecurity = value.toString();
//                         widget.securityController.text=selectedSecurity;
//                       });
//                     },
//                   ),
//                   const Text('None'),
//                 ],
//               ),


//               const Text(
//                 'Parking'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Available',
//                     groupValue:selectedParking,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedParking = value.toString();
//                         widget.parkingController.text=selectedParking;
//                       });
//                     },
//                   ),
//                   const Text('Available'),
//                   Radio(
//                     value: 'No',
//                     groupValue: selectedParking,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedParking = value.toString();
//                         widget.parkingController.text=selectedParking;
//                       });
//                     },
//                   ),
//                   const Text('No'),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               // CustomTextField(
//               //   controller: widget.shopIdController,
//               //   hintText: 'Available From Date',
//               // ),
//               const Text('Available From Date',style: TextStyle(
//                 fontSize: 15,
//               ),),
//               const SizedBox(height: 10),
//               const CustomDatePicker(),

//               const SizedBox(height: 10),
//               CustomButton(
//                 text: 'Submit',
//                 onTap: widget.rentSellProduct,
//               ),
//               const SizedBox(height: 20),
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // // Similarly define screens for other categories (AppliancesScreen, BooksScreen, FashionScreen)


// class HostelScreen extends StatefulWidget {
//   final GlobalKey<FormState> addProductFormKey;
//   final List<File> images;
//   final VoidCallback selectImages; // Changed the type to VoidCallback
//   final TextEditingController ownerNameController;
//   final TextEditingController houseNameController;
//   final TextEditingController mobileNoController;
//   final TextEditingController rentController;
//   final TextEditingController depositController;
//   final TextEditingController genderController;
//   final TextEditingController wifiController;
//   final TextEditingController parkingController;
//   final TextEditingController furnishController;
//   final TextEditingController dateController;
//   final TextEditingController securityController;
//   final VoidCallback rentSellProduct;

//   HostelScreen({
//     required this.addProductFormKey,
//     required this.images,
//     required this.selectImages,
//     required this.ownerNameController,
//     required this.houseNameController,
//     required this.mobileNoController,
//     required this.rentController,
//     required this.depositController,
//     required this.wifiController,
//     required this.parkingController,
//     required this.genderController,
//     required this.furnishController,
//     required this.dateController,
//     required this.securityController,
//     required this.rentSellProduct,
//   });

//   @override
//   State<HostelScreen> createState() => _HostelScreenState();
// }

// class _HostelScreenState extends State<HostelScreen> {
//   var selectedGender='Male';
//   var selectedFerniture='None';
//   var selectedWifi='No';
//   var selectedParking='No';
//   var selectedSecurity='None';
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: widget.addProductFormKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: widget.selectImages,
//                 child: widget.images.isNotEmpty
//                     ? CarouselSlider(
//                         items: widget.images.map(
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
//                 controller: widget.ownerNameController,
//                 hintText: 'Your Name',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.mobileNoController,
//                 hintText: 'Your Mobile No.',
//                 validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter Mobile Number';
//     }
//     return null; // Return null if the validation is successful
//   },
//               ),
//               const SizedBox(height: 10),

//               CustomTextField(
//                 controller: widget.houseNameController,
//                 hintText: 'House Name',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.rentController,
//                 hintText: 'Rent',
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: widget.depositController,
//                 hintText: 'Deposit',
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Preferred Gender'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Male',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         widget.genderController.text=selectedGender;
//                       });
//                     },
//                   ),
//                   const Text('Male'),
//                   Radio(
//                     value: 'Female',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                         widget.genderController.text=selectedGender;
//                       });
//                     },
//                   ),
//                   const Text('Female'),
//                 ],
//               ),


//               const Text(
//                 'Furnishing'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Full',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('Full'),
//                   Radio(
//                     value: 'Semi',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('Semi'),
//                   Radio(
//                     value: 'None',
//                     groupValue: selectedFerniture,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFerniture = value.toString();
//                         widget.furnishController.text=selectedFerniture;
//                       });
//                     },
//                   ),
//                   const Text('None'),
//                 ],
//               ),

//               const Text(
//                 'Wifi'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Available',
//                     groupValue:selectedWifi,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedWifi = value.toString();
//                         widget.wifiController.text=selectedWifi;
//                       });
//                     },
//                   ),
//                   const Text('Available'),
//                   Radio(
//                     value: 'No',
//                     groupValue: selectedWifi,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedWifi = value.toString();
//                         widget.wifiController.text=selectedWifi;
//                       });
//                     },
//                   ),
//                   const Text('No'),
//                 ],
//               ),


//               const Text(
//                 'Security'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: '24*7 Security',
//                     groupValue:selectedSecurity,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedSecurity = value.toString();
//                         widget.securityController.text=selectedSecurity;
//                       });
//                     },
//                   ),
//                   const Text('24*7 Security'),
//                   Radio(
//                     value: 'None',
//                     groupValue: selectedSecurity,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedSecurity = value.toString();
//                         widget.securityController.text=selectedSecurity;
//                       });
//                     },
//                   ),
//                   const Text('None'),
//                 ],
//               ),


//               const Text(
//                 'Parking'
//               ),
//               Row(
//                 children: [
//                   Radio(
//                     value: 'Available',
//                     groupValue:selectedParking,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedParking = value.toString();
//                         widget.parkingController.text=selectedParking;
//                       });
//                     },
//                   ),
//                   const Text('Available'),
//                   Radio(
//                     value: 'No',
//                     groupValue: selectedParking,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedParking = value.toString();
//                         widget.parkingController.text=selectedParking;
//                       });
//                     },
//                   ),
//                   const Text('No'),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               // CustomTextField(
//               //   controller: widget.shopIdController,
//               //   hintText: 'Available From Date',
//               // ),
//               const Text('Available From Date',style: TextStyle(
//                 fontSize: 15,
//               ),),
//               const SizedBox(height: 10),
//               const CustomDatePicker(),

//               const SizedBox(height: 10),
//               CustomButton(
//                 text: 'Submit',
//                 onTap: widget.rentSellProduct,
//               ),
//               const SizedBox(height: 20),
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
