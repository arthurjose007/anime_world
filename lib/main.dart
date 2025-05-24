import 'dart:io';

import 'package:animeworld/myhttpoverrides/myhttpoverride.dart';
import 'package:animeworld/screens/homescreen.dart';
import 'package:animeworld/screens/test.dart';
import 'package:flutter/material.dart';

void main() async {
 
   HttpOverrides.global = MyHttpOverrides();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
