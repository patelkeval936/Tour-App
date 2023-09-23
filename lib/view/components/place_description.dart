import 'dart:ui';
import 'package:epvi/values/app_strings.dart';
import 'package:flutter/material.dart';
import '../../values/app_assets.dart';

class PlaceDescription extends StatelessWidget {
  const PlaceDescription({
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                    height: 5,
                    width: 50,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.17,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(AppStrings.description,textAlign: TextAlign.justify,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    AppStrings.readMore,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.blueGrey.shade800),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          AppAssets.videoThumbnail,
                        )),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Container(
                          color: Colors.transparent,
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.play_arrow_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
