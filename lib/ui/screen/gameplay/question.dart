import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/role/cubit/role_cubit.dart';
import 'package:sketoo/model/fabel.dart';
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
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imgBackgroundInformation),
                  fit: BoxFit.cover),
            ),
            child: QuestionBoard(
              pertanyaan: context.read<RoleCubit>().state.isAnakOrangTua == true
                  ? pertanyaanOrtu[
                      context.read<Player_1Cubit>().state.babak - 1]
                  : pertanyaanAnak[
                      context.read<Player_1Cubit>().state.babak - 1],
              route: DrawingApp.routename,
              isQuestion: true,
            ),
          ),
          PopupKeluar(visible: hasClickPop)
        ],
      )),
    );
  }
}
