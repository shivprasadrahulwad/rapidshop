import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eshop/common/widgets/horizontal_line.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  get splash => null;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthScreen()));
    });
  }

  @override
Widget build(BuildContext context) {
  return AnimatedSplashScreen(
    splash: Container(
      color: GlobalVariables.yelloColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 35 ,right: 45),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'far',
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: 'con',
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 40,
                          color: GlobalVariables.greenColor),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // SizedBox(height: 5,),
              Text(
                "Delivering India's finest products,",
                style: TextStyle(
                    fontFamily: 'Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
               Text(
                "straight from shopers to your doorstep.",
                style: TextStyle(
                    fontFamily: 'Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              HorizontalLine(),
            ],
          ),
        ),
      ),
    ),
    nextScreen: const AuthScreen(),
    splashIconSize: 400,
    backgroundColor: GlobalVariables.yelloColor,
  );
}

}
