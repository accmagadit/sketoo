import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sketoo/ui/screen/gameplay/widget/scores_conclusion.dart';
import 'package:sketoo/ui/screen/information/welcome.dart';
import 'package:sketoo/ui/screen/information/widget/PopupKeluar.dart';
import 'package:sketoo/utils/assets.dart';

class Conclusion extends StatefulWidget {
  static const routename = "/conclusion";
  const Conclusion({super.key});

  @override
  State<Conclusion> createState() => _ConclusionState();
}

class _ConclusionState extends State<Conclusion> {
  bool hasClickPop = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        setState(() {
          hasClickPop = !hasClickPop;
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imgBackgroundResult,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imgLogoApp),
                      ),
                    ),
                  ).animate().scale(duration: 1500.ms, curve: Curves.bounceOut),
                  const SizedBox(height: 30),
                  const ScoreConclusion().animate().flip(delay: 1500.ms)
                ],
              ),
            ),
            PopupKeluar(visible: hasClickPop)
          ],
        ),
        floatingActionButton: InkWell(
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.routename);
            },
            child: Image.asset(imgHomeButton)),
      ),
    );
  }
}
