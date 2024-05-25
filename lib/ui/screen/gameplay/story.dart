import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/ui/screen/gameplay/question.dart';
import 'package:sketoo/ui/screen/gameplay/widget/question_board.dart';
import 'package:sketoo/utils/assets.dart';

class StoryScreen extends StatefulWidget {
  static const routename = "/story_screen";
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<Player_1Cubit>().addBabak();
    context.read<Player_2Cubit>().addBabak();
    debugPrint(
        "klik player 1: ${context.read<Player_1Cubit>().state.hasClick}");
    debugPrint(
        "klik player 2: ${context.read<Player_2Cubit>().state.hasClick}");
    debugPrint("Babak p1: ${context.read<Player_1Cubit>().state.babak}");
    debugPrint("Babak p2: ${context.read<Player_2Cubit>().state.babak}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imgBackgroundGameplay), fit: BoxFit.cover),
            ),
            child: const QuestionBoard(
              pertanyaan:
                  "Gajah dikenal sebagai binatang yang besar. Suatu hari, kawanan gajah yang besar datang ke hutan untuk mencari makan.\nKehadiran gajah ini mengganggu kawanan semut yang tinggal di sana. Banyak rumah semut hancur karena diinjak gajah yang mencari makan.",
              route: QuestionScreen.routename,
              isQuestion: false,
            )));
  }
}
