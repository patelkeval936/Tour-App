import 'package:epvi/values/app_assets.dart';
import 'package:flutter/material.dart';

class PlaceImages extends StatelessWidget {
  const PlaceImages({
    super.key,
    required this.isExpanded,
    required this.duration,
    required this.index,
  });

  final bool isExpanded;
  final int duration;
  final int index;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return AnimatedPositioned(
      bottom: isExpanded ? height * 0.62 : 22,
      left: (index - 1) * height * 0.12 + 20,
      duration: Duration(milliseconds: duration + (index * 50)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: height * 0.12,
            width: height * 0.1,
            child: Image.asset(
              AppAssets.getPic(index),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
