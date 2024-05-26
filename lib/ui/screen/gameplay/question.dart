import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/gameplay/canvas.dart';
import 'package:sketoo/ui/screen/gameplay/widget/question_board.dart';
import 'package:sketoo/ui/screen/information/widget/PopupKeluar.dart';
import 'package:sketoo/utils/assets.dart';

class QuestionScreen extends StatefulWidget {
  static const routename = "/question_screen";
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
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
          Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgBackgroundGameplay),
                    fit: BoxFit.cover),
              ),
              child: const QuestionBoard(
                pertanyaan:
                    "Hewan apakah yang terganggu oleh cerita gajah dari cerita sebelumnya?",
                route: DrawingApp.routename,
                isQuestion: true,
              )),
          PopupKeluar(visible: hasClickPop)
        ],
      )),
    );
  }
}
