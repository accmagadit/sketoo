import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/widget/PopupKeluar.dart';

class Exit extends StatelessWidget {
  const Exit({super.key});

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
            PopupKeluar(),
          ],
        ),
      ),
    );
  }
}
