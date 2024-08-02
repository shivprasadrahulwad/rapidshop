import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eshop/features/admin/screens/fhome_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeSplashScreen extends StatefulWidget {
  const HomeSplashScreen({super.key});

  @override
  State<HomeSplashScreen> createState() => _HomeSplashScreenState();
}

class _HomeSplashScreenState extends State<HomeSplashScreen> {
  get splash => null;

  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const FhomeScreen(shopCode: '',)));
     });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        height: 300,
        width: 300,
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 35 ,right: 45),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Center(
              child: Lottie.asset('animation/Animation - 1720872965217 (1).json',repeat: true),
            )
            ],
          ),
        ),
      ),
    ),
      nextScreen: const FhomeScreen(shopCode: '',),
      splashIconSize: 400,
      backgroundColor:Colors.white,
       duration: 7000,
    );
      
  }
}