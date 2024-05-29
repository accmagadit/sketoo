import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/model/fabel.dart';
import 'package:sketoo/ui/screen/gameplay/question.dart';
import 'package:sketoo/ui/screen/gameplay/widget/question_board.dart';
import 'package:sketoo/ui/screen/information/widget/PopupKeluar.dart';
import 'package:sketoo/utils/assets.dart';

class StoryScreen extends StatefulWidget {
  static const routename = "/story_screen";
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  bool hasClickPop = false;

  @override
  void initState() {
    super.initState();
    context.read<Player_1Cubit>().addBabak();
    context.read<Player_2Cubit>().addBabak();
    debugPrint(
        "panjang cerita fabel: ${ceritaFabel.length}");
    debugPrint(
        "index cerita fabel: ${context.read<Player_1Cubit>().state.babak - 1}");
    debugPrint("index Babak: ${context.read<Player_1Cubit>().state.babak}");
  }

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
              child: QuestionBoard(
                pertanyaan:
                    ceritaFabel[context.read<Player_1Cubit>().state.babak - 1],
                route: QuestionScreen.routename,
                isQuestion: false,
              )),
          PopupKeluar(visible: hasClickPop)
        ],
      )),
    );
  }
}
