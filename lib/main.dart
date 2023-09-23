import 'dart:ui';
import 'package:epvi/values/app_assets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  double width = 0.0;
  double height = 0.0;

  bool isExpanded = false;
  int duration = 3000;

  late AnimationController controller;
  late AnimationController smallButtonController;
  late AnimationController expandedButtonController;

  bool isFavorite = false;

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
    expandedButtonController.reverse();

    setState(() {
      isExpanded = !isExpanded;
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
    )..addStatusListener((status) {
        if (status == AnimationStatus.reverse) {
          smallButtonController.reverse();
        }
      });

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
            AnimatedPositioned(
              top: isExpanded ? -(height * 0.6) : 0,
              duration: Duration(milliseconds: duration),
              child: Container(
                height: height * 0.9,
                width: width,
                child: Image.asset(
                  AppAssets.backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: height * 0.9,
              width: width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.black45.withOpacity(1),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
            ),
            Positioned(
                left: 20,
                bottom: height * 0.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'ON SALE',
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Eiffel Tower',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Paris, France',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                )),
            AnimatedBuilder(
              animation: blueAnimation,
              builder: (BuildContext context, Widget? child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: blueAnimation.value,
                    sigmaY: blueAnimation.value,
                  ),
                  child: Container(
                    color: Colors.transparent,
                  ),
                );
              },
            ),
            AnimatedPositioned(
                bottom: isExpanded ? 0 : -(height * 0.6),
                duration: Duration(milliseconds: duration),
                child: Container(
                  height: height * 0.8,
                  width: width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                )),
            Stack(
              children: [
                ...[1, 2, 3, 4].map(
                      (e) => AnimatedPositioned(
                    bottom: isExpanded ? height * 0.62 : 20,
                    left: (e - 1) * height * 0.12 + 20,
                    duration: Duration(milliseconds: duration + (e * 60)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: height * 0.12,
                          width: height * 0.1,
                          child: Image.asset(
                            'assets/images/pic$e.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ))
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: smallButtonAnimation,
                builder: (BuildContext context, Widget? child) {
                  print(smallButtonAnimation.value);
                  return InkWell(
                    onTap: () {
                      if(!isExpanded){
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
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: expandedButtonController,
                builder: (BuildContext context, Widget? child) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        if(isExpanded){
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
                                  'SEARCH FLIGHTS',
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
                                      'ON SALE',
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
            ),
            Positioned(
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
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                )),
            AnimatedPositioned(
              duration: Duration(milliseconds: duration),
              left: 0,
              right: 0,
              top: isExpanded ? 50 : height * 0.12,
              child: AnimatedBuilder(
                animation: opacityAnimation,
                builder: (BuildContext context, Widget? child) {
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Eiffel Tower',
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
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Paris, France',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(opacityAnimation.value)),
                          ),
                        ],
                      ),
                    ],
                  );
                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
