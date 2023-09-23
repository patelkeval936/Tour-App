import 'package:flutter/material.dart';

class CustomAppGradient extends StatelessWidget {
  const CustomAppGradient({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.9,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.black45.withOpacity(1),
        Colors.black.withOpacity(0),
        Colors.black.withOpacity(0),
      ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
    );
  }
}
