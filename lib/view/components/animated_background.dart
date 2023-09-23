import 'package:flutter/material.dart';

import '../../values/app_assets.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({
    super.key,
    required this.isExpanded,
    required this.duration,
  });

  final bool isExpanded;
  final int duration;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
      top: isExpanded ? -(height * 0.6) : 0,
      duration: Duration(milliseconds: duration),
      child: SizedBox(
        height: height * 0.9,
        width: width,
        child: Image.asset(
          AppAssets.backgroundImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
