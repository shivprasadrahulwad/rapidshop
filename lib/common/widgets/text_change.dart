import 'dart:async';
import 'package:flutter/material.dart';

class TextChange extends StatefulWidget {
  @override
  _TextChangeState createState() => _TextChangeState();
}

class _TextChangeState extends State<TextChange> {
  int currentIndex = 0;
  List<String> texts = ["Idli", "Dosa", "Samosa"]; // Add more texts as needed

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % texts.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Text Changer"),
        ),
        body: Center(
          child: Text(
            texts[currentIndex],
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
