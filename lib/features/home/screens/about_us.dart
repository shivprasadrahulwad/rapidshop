import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  static const String routeName = '/aboutUs';
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("About Us"),
      ),
    );
  }
}