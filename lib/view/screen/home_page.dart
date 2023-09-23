import 'package:flutter/material.dart';
import '../components/animated_background.dart';
import '../components/app_heading.dart';
import '../components/app_icon_bar.dart';
import '../components/blur_background.dart';
import '../components/custom_app_gradient.dart';
import '../components/expanded_button.dart';
import '../components/place_description.dart';
import '../components/place_images.dart';
import '../components/place_name_and_location.dart';
import '../components/rounded_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  int duration = 400;
  double width = 0.0;
  double height = 0.0;
  bool isFavorite = false;
  bool isExpanded = false;

  late AnimationController controller;
  late AnimationController smallButtonController;
  late AnimationController expandedButtonController;

  late Animation blueAnimation;
  late Animation opacityAnimation;
  late Animation smallButtonAnimation;
  late Animation<Size?> expandedButtonAnimation;

  void expandBottomSheet() {
    controller.forward();
    smallButtonController.forward();

    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void collapseBottomSheet() {
    controller.reverse();
    expandedButtonController.reverse().then((value) {
      smallButtonController.reverse();
    });

    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
    );

    smallButtonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration ~/ 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          expandedButtonController.forward();
        }
      });

    expandedButtonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration ~/ 2),
    );

    blueAnimation = Tween(begin: 0.0, end: 20.0).animate(controller);
    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(controller);
    smallButtonAnimation = Tween(begin: 30.0, end: 0.0).animate(smallButtonController);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    expandedButtonAnimation = SizeTween(begin: const Size(0, 0), end: Size(width * 0.9, 50)).animate(expandedButtonController);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            AnimatedBackground(
              isExpanded: isExpanded,
              duration: duration,
            ),
            const CustomAppGradient(),
            const PlaceNameAndLocation(),
            BlurBackground(blurAnimation: blueAnimation),
            PlaceDescription(
              isExpanded: isExpanded,
              duration: duration,
            ),
            ...[1, 2, 3, 4].map((e) => PlaceImages(isExpanded: isExpanded, duration: duration, index: e)),
            RoundedButton(
              isExpanded: isExpanded,
              smallButtonAnimation: smallButtonAnimation,
              expandBottomSheet: expandBottomSheet,
            ),
            ExpandedButton(
                isExpanded: isExpanded,
                expandedButtonController: expandedButtonController,
                collapseBottomSheet: collapseBottomSheet,
                expandedButtonAnimation: expandedButtonAnimation),
            AppIconBar(
              isExpanded: isExpanded,
              collapseBottomSheet: collapseBottomSheet,
              toggleFavorite: toggleFavorite,
              isFavorite: isFavorite,
            ),
            AppHeading(
              duration: duration,
              isExpanded: isExpanded,
              opacityAnimation: opacityAnimation,
            ),
          ],
        ),
      ),
    );
  }
}
