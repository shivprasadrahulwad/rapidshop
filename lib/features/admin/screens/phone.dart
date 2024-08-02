// import 'package:eshop/features/admin/screens/verify.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class MyPhone extends StatefulWidget {
//   static const String routeName = '/phone';
//   const MyPhone({Key? key}) : super(key: key);

//   @override
//   State<MyPhone> createState() => _MyPhoneState();
// }

// class _MyPhoneState extends State<MyPhone> {
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     countryController.text = "+91";  // Default country code
//   }

//   Future<void> _submitPhoneNumber(BuildContext context) async {
//   String phoneNumber = _phoneNumberController.text.trim();
//   if (!phoneNumber.startsWith('+')) {
//     phoneNumber = countryController.text + phoneNumber;
//   }
//   print("Formatted phone number: $phoneNumber");

//   FirebaseAuth auth = FirebaseAuth.instance;

//   await auth.verifyPhoneNumber(
//     phoneNumber: phoneNumber,
//     verificationCompleted: (PhoneAuthCredential credential) async {},
//     verificationFailed: (FirebaseAuthException e) {
//       print(e.message.toString());
//     },
//     codeSent: (String verificationId, int? resendToken) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MyVerify(verificationId: verificationId),
//         ),
//       );
//     },
//     codeAutoRetrievalTimeout: (String verificationId) {},
//   );
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/img1.png',
//                 width: 150,
//                 height: 150,
//               ),
//               SizedBox(height: 25),
//               Text(
//                 "Phone Verification",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "We need to register your phone to get started!",
//                 style: TextStyle(fontSize: 16),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 30),
//               Container(
//                 height: 55,
//                 decoration: BoxDecoration(
//                   border: Border.all(width: 1, color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(width: 10),
//                     SizedBox(
//                       width: 40,
//                       child: TextField(
//                         controller: countryController,
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "|",
//                       style: TextStyle(fontSize: 33, color: Colors.grey),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: TextField(
//                         controller: _phoneNumberController,
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Phone",
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.green.shade600,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: () {
//                     _submitPhoneNumber(context);
//                   },
//                   child: Text("Send the code"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:eshop/features/admin/screens/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPhone extends StatefulWidget {
  static const String routeName = '/phone';
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    countryController.text = "+91"; // Default country code
  }

  String formatPhoneNumber(String countryCode, String phoneNumber) {
    return '$countryCode${phoneNumber.trim()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 25),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We need to register your phone before getting started!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    String phoneNumber = formatPhoneNumber(
                      countryController.text,
                      phoneController.text,
                    );

                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException ex) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Verification failed. Please try again. ${ex.message}')),
                        );
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyVerify(
                              verificationid: verificationId,
                            ),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: Text("Send the code"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
