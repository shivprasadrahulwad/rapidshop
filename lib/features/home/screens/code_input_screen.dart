import 'dart:convert';
import 'package:eshop/features/admin/screens/user_cart_products.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/screens/fhome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CodeInputScreen extends StatefulWidget {
  const CodeInputScreen({super.key});

  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  String _errorMessage = '';

  void _verifyCode() async {
  if (_formKey.currentState!.validate()) {
    String shopCode = _controllers.map((controller) => controller.text).join();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    try {
      final response = await http.post(
        Uri.parse('$uri/api/verify-code'), // Correctly parse the URI here
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'shopCode': shopCode,
        }),
      );

      if (response.statusCode == 200) {
        GlobalVariables.setShopCode(shopCode);
        // Shop code verification successful
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => UserCartProducts(totalPrice: 0,shopCode: shopCode, address: '', instruction: [], index: 0, tips: null, totalSave: '',),
        //   ),
        // );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FhomeScreen(shopCode: shopCode),
          ),
        );
      } else {
        // Shop code not found or other error
        setState(() {
          _errorMessage = 'Shop with this code not found';
        });
      }
    } catch (e) {
      print('Error verifying shop code: $e');
      setState(() {
        _errorMessage = 'Error verifying shop code';
      });
    }
  } else {
    setState(() {
      _errorMessage = 'All fields are required';
    });
  }
}



  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 15),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Verification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Enter your Shop code number",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black38),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return _textFieldOTP(
                            controller: _controllers[index],
                            first: index == 0,
                            last: index == 5,
                          );
                        }),
                      ),
                      SizedBox(height: 30),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _verifyCode,
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text('Verify', style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text(
                "Didn't remember shop code?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black38),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18),
              Text(
                "Used codes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({
    required TextEditingController controller,
    required bool first,
    required bool last,
  }) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Container(
        height: 43,
        width: 43,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: TextFormField(
            controller: controller,
            autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && !last) {
                FocusScope.of(context).nextFocus();
              }
              if (value.length == 0 && !first) {
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
            decoration: InputDecoration(
              counter: Offstage(),
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
