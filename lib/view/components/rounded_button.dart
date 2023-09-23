import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key? key, required this.isExpanded, required this.smallButtonAnimation, required this.expandBottomSheet}) : super(key: key);

  final bool isExpanded;
  final Animation smallButtonAnimation;
  final Function expandBottomSheet;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: smallButtonAnimation,
        builder: (BuildContext context, Widget? child) {
          return InkWell(
            onTap: () {
              if (!isExpanded) {
                expandBottomSheet();
              }
            },
            child: CircleAvatar(
              radius: smallButtonAnimation.value,
              backgroundColor: Colors.blueGrey.shade800,
              child: Icon(
                Icons.flight_takeoff_rounded,
                size: smallButtonAnimation.value > 10 ? smallButtonAnimation.value : 0,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
