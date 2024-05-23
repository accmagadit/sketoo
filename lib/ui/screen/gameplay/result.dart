import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/ui/screen/gameplay/conclusion.dart';
import 'package:sketoo/ui/screen/gameplay/widget/pop_up_pemenang.dart';
import 'package:sketoo/utils/assets.dart';
import 'package:sketoo/utils/colors.dart';
import 'package:sketoo/utils/typograhpy.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);
  static const routename = "/result_screen";

  @override
  // ignore: library_private_types_in_public_api
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      imgBackgroundGameplay,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: [
                      //player 1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RotatedBox(
                            quarterTurns: 2,
                            child: Image.asset(iconHapus),
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: Row(
                              children: [
                                Image.asset(iconKoin),
                                Text('0', style: jomhuriaBlackGreen20),
                              ],
                            ),
                          ),
                        ],
                      ),

                      RotatedBox(
                        quarterTurns: 2,
                        child: const PopUpPemenang(
                                namaGambar: "badak_result.png",
                                isPemenang: true)
                            .animate()
                            .scale(duration: 1000.ms, curve: Curves.bounceOut),
                      ),

                      const SizedBox(height: 10),
                      //time widget
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Image.asset(imgTali),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<Player_2Cubit, Player_2State>(
                                builder: (context, state) {
                                  return Row(
                                    children: [
                                      for (var hewan in state.pasukanHewan)
                                        Image.asset(
                                            "assets/gameplay/$hewan.png",
                                            height: 30),
                                    ],
                                  );
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Conclusion.routename);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: yellow,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                      child: Text(
                                    'OK',
                                    style: poppinsWhite20, // Teks putih
                                  )),
                                )
                                    .animate(
                                      onPlay: (controller) => controller.repeat(
                                        reverse: true,
                                      ),
                                    )
                                    .scale(
                                        duration: 1000.ms,
                                        begin: const Offset(1, 1),
                                        end: const Offset(1.3, 1.3)),
                              ),
                              BlocBuilder<Player_1Cubit, Player_1State>(
                                builder: (context, state) {
                                  return Row(
                                    children: [
                                      for (var hewan in state.pasukanHewan)
                                        Image.asset(
                                            "assets/gameplay/$hewan.png",
                                            height: 30),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      //player 2
                      const PopUpPemenang(
                              namaGambar: "gajah_result.png", isPemenang: false)
                          .animate()
                          .scale(duration: 1000.ms, curve: Curves.bounceOut),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(iconKoin),
                              Text('0', style: jomhuriaBlackGreen20),
                            ],
                          ),
                          Image.asset(iconHapus),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
