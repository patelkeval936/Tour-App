import 'dart:ui';
import 'package:flutter/material.dart';

class BlurBackground extends StatelessWidget {
  const BlurBackground({Key? key, required this.blurAnimation}) : super(key: key);

  final Animation blurAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: blurAnimation,
      builder: (BuildContext context, Widget? child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurAnimation.value,
            sigmaY: blurAnimation.value,
          ),
          child: Container(
            color: Colors.transparent,
          ),
        );
      },
    );
  }
}
