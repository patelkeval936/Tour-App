import 'package:epvi/values/app_strings.dart';
import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton(
      {Key? key,
      required this.isExpanded,
      required this.expandedButtonController,
      required this.collapseBottomSheet,
      required this.expandedButtonAnimation})
      : super(key: key);

  final bool isExpanded;
  final AnimationController expandedButtonController;
  final Function collapseBottomSheet;
  final Animation<Size?> expandedButtonAnimation;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: expandedButtonController,
        builder: (BuildContext context, Widget? child) {
          return Center(
            child: InkWell(
              onTap: () {
                if (isExpanded) {
                  collapseBottomSheet();
                }
              },
              child: SizedBox(
                height: expandedButtonAnimation.value!.height,
                width: expandedButtonAnimation.value!.width,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Colors.blueGrey.shade900,
                        Colors.blueGrey.shade600,
                      ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.flight_takeoff_rounded,
                          size: expandedButtonAnimation.value!.height - 26 > 0 ? expandedButtonAnimation.value!.height - 26 : 0,
                          color: Colors.white,
                        ),
                        Text(
                          AppStrings.searchFlight,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500, fontSize: (expandedButtonAnimation.value!.height / 50) * 14),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Text(
                              AppStrings.onSale,
                              style: TextStyle(color: Colors.white, fontSize: (expandedButtonAnimation.value!.height / 50) * 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
