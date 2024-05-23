import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sketoo/ui/screen/information/widget/PopupHome.dart';
import 'package:sketoo/utils/assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routename = "/home";

  @override
  State<HomeScreen> createState() => __HomeScreen();
}

class __HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imgBackgroundInformation), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imgLogoApp),
                  ),
                ),
              ),
            ).animate().scale(duration: 1500.ms, curve: Curves.bounceOut),
            const SizedBox(height: 20),
            const PopupHome().animate().flip(delay: 1500.ms),
          ],
        ),
      ),
    );
  }
}
