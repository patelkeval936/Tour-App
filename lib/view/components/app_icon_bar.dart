import 'package:flutter/material.dart';

class AppIconBar extends StatelessWidget {
  const AppIconBar({Key? key, required this.isExpanded, required this.collapseBottomSheet, required this.toggleFavorite, required this.isFavorite})
      : super(key: key);

  final bool isExpanded;
  final Function collapseBottomSheet;
  final Function toggleFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 40,
        left: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  if (isExpanded) {
                    collapseBottomSheet();
                  }
                },
                icon: const Icon(
                  Icons.arrow_downward_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              IconButton(
                onPressed: () {
                  toggleFavorite();
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ],
          ),
        ));
  }
}
