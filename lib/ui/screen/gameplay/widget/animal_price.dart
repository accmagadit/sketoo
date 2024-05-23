import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/ui/screen/gameplay/result.dart';
import 'package:sketoo/ui/screen/gameplay/story.dart';
import 'package:sketoo/utils/assets.dart';

class HargaHewan extends StatelessWidget {
  final String namaGambar;
  final int harga;
  final int player;

  const HargaHewan({
    Key? key,
    required this.namaGambar,
    required this.harga,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isKoinPlayerEnough(int player) {
      if (player == 1) {
        int koin = context.read<Player_1Cubit>().state.koin;
        return koin > harga ? true : false;
      } else {
        int koin = context.read<Player_2Cubit>().state.koin;
        return koin > harga ? true : false;
      }
    }

    if (isKoinPlayerEnough(player)) {
      return Column(
        children: [
          Image.asset(
            "assets/gameplay/$namaGambar.png",
            height: 80,
          ),
          ElevatedButton(
            onPressed: () {
              int babakPlayer = context.read<Player_1Cubit>().state.babak;
              bool player1Click = context.read<Player_1Cubit>().state.hasClick;
              bool player2Click = context.read<Player_2Cubit>().state.hasClick;

              if (player == 1) {
                context.read<Player_1Cubit>().subtractionKoin(harga);
                context.read<Player_1Cubit>().addPasukanHewan(namaGambar);
                context.read<Player_1Cubit>().changeHasClick();
                print(context.read<Player_1Cubit>().state.pasukanHewan);
              } else if (player == 2) {
                context.read<Player_2Cubit>().subtractionKoin(harga);
                context.read<Player_2Cubit>().addPasukanHewan(namaGambar);
                context.read<Player_2Cubit>().changeHasClick();
                print(context.read<Player_2Cubit>().state.pasukanHewan);
              }
              if (babakPlayer != 4) {
                if (player1Click || player2Click) {
                  Navigator.pushNamed(context, StoryScreen.routename);
                }
              } else {
                if (player1Click || player2Click) {
                  Navigator.pushNamed(context, Result.routename);
                }
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
              elevation: MaterialStateProperty.all<double>(4),
              shadowColor: MaterialStateProperty.all<Color>(
                Colors.grey.withOpacity(0.4),
              ),
            ),
            child: Row(
              children: [
                Image.asset(imgKoinHewan),
                Text(
                  harga.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .shake(
                rotation: 0.1,
                hz: 1.7,
              ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
