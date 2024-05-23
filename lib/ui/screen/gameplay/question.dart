import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/gameplay/canvas.dart';
import 'package:sketoo/ui/widget/question_board.dart';
import 'package:sketoo/utils/assets.dart';

class QuestionScreen extends StatelessWidget {
  static const routename = "/question_screen";
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imgBackground), fit: BoxFit.cover),
            ),
            child: const QuestionBoard(
              pertanyaan:
                  "Hewan apakah yang terganggu oleh cerita gajah dari cerita sebelumnya?",
              route: DrawingApp.routename,
              isQuestion: true,
            )));
  }
}
