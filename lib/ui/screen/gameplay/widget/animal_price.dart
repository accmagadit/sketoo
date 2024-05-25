import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/utils/assets.dart';

class HargaHewan extends StatelessWidget {
  final String namaGambar;
  final int harga;
  final int player;
  final bool isChoosen;

  const HargaHewan({
    Key? key,
    required this.namaGambar,
    required this.harga,
    required this.player,
    required this.isChoosen,
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
      return Visibility(
        visible: isChoosen,
        child: Column(
          children: [
            Image.asset(
              "assets/gameplay/$namaGambar.png",
              height: 80,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius:
                    BorderRadius.circular(12), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(imgKoinHewan),
                  const SizedBox(
                      width: 4), // Add some space between the image and the text
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
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
