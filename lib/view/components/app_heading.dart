import 'package:epvi/values/app_strings.dart';
import 'package:flutter/material.dart';

class AppHeading extends StatelessWidget {
  const AppHeading({
    super.key,
    required this.duration,
    required this.isExpanded,
    required this.opacityAnimation,
  });

  final int duration;
  final bool isExpanded;
  final Animation opacityAnimation;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return AnimatedPositioned(
      duration: Duration(milliseconds: duration),
      left: 0,
      right: 0,
      top: isExpanded ? 90 : height * 0.24,
      child: AnimatedBuilder(
        animation: opacityAnimation,
        builder: (BuildContext context, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.eiffelTower,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(opacityAnimation.value), height: 1.2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white.withOpacity(opacityAnimation.value),
                    size: 12,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    AppStrings.location,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(opacityAnimation.value)),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
