import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/widget/PopupHome.dart';

class HomeState extends StatefulWidget {
  const HomeState({super.key});

  @override
  State<HomeState> createState() => __HomeState();
}

class __HomeState extends State<HomeState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/assets/background-biru.png'),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/logo_sketoo.png'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            PopupHome(),
          ],
        ),
      ),
    );
  }
}
