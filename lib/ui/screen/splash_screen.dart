import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/information/Home.dart';

class SplashScreen extends StatelessWidget {
  static const routename = "/splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _navigateToHome() async {
      await Future.delayed(Duration(milliseconds: 2500)); 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeState()),
      );
    }

    _navigateToHome();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFFCAEDFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.asset('lib/assets/logo_sketoo.png'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: SplashScreen.routename,
    routes: {
      SplashScreen.routename: (context) => SplashScreen(), 
    },
  ));
}
