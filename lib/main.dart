import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/information/Home.dart';
import 'package:sketoo/ui/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routename,
      routes: {
        SplashScreen.routename: (context) => const SplashScreen(),
      },
      home: const SplashScreen(),
      //auth

      //information

      //gameplay
    );
  }
}
