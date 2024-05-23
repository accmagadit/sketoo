import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/information/welcome.dart';
import 'package:sketoo/utils/assets.dart';

class SplashScreen extends StatelessWidget {
  static const routename = "/splash_screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routename);
    });

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xFFCAEDFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(imgLogoApp),
            ),
          ],
        ),
      ),
    );
  }
}
