import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(

            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
            "https://reqres.in/img/faces/10-image.jpg",
              ),

          ),

        ],
      ));
  }
}
