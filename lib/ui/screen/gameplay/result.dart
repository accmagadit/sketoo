import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/ui/screen/gameplay/share.dart';
import 'package:sketoo/ui/screen/gameplay/widget/pop_up_pemenang.dart';
import 'package:sketoo/ui/screen/information/widget/PopupKeluar.dart';
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
  bool isBadakMenang = false;
  bool isGajahMenang = false;
  bool hasClickPop = false;

  void isWinner() {
    Map<String, int> hewanPoin1 = {
      "kelinci": 30,
      "monyet": 55,
      "gajah": 95,
    };
    Map<String, int> hewanPoin2 = {
      "kelinci": 30,
      "monyet": 55,
      "badak": 95,
    };
    List<String> pasukanPlayer1 =
        context.read<Player_1Cubit>().state.pasukanHewan;
    List<String> pasukanPlayer2 =
        context.read<Player_2Cubit>().state.pasukanHewan;
    int totalPoin1 = 0;
    int totalPoin2 = 0;
    for (String hewan in pasukanPlayer1) {
      totalPoin1 += hewanPoin1[hewan]!;
    }
    for (String hewan in pasukanPlayer2) {
      totalPoin2 += hewanPoin2[hewan]!;
    }

    if (totalPoin1 > totalPoin2) {
      setState(() {
        isGajahMenang = true;
        isBadakMenang = false;
      });
    } else if (totalPoin1 < totalPoin2) {
      setState(() {
        isGajahMenang = false;
        isBadakMenang = true;
      });
    } else {
      setState(() {
        isBadakMenang = false;
        isBadakMenang = false;
      });
    }
  }

  List<Widget> hasilTarikan() {
    Map<String, int> hewanPoin = {
      "kelinci": 30,
      "monyet": 55,
      "gajah": 95,
    };
    List<String> pasukanPlayer1 =
        context.read<Player_1Cubit>().state.pasukanHewan;
    List<String> pasukanPlayer2 =
        context.read<Player_2Cubit>().state.pasukanHewan;
    int totalPoin1 = 0;
    int totalPoin2 = 0;
    for (String hewan in pasukanPlayer1) {
      totalPoin1 += hewanPoin[hewan]!;
    }
    for (String hewan in pasukanPlayer2) {
      totalPoin2 += hewanPoin[hewan]!;
    }

    if (totalPoin1 > totalPoin2) {
      return [
        const SizedBox(),
        Image.asset(
          imgTali,
          width: 200,
        ),
      ];
    } else if (totalPoin1 < totalPoin2) {
      return [
        Image.asset(
          imgTali,
          width: 200,
        ),
        const SizedBox(),
      ];
    } else {
      return [
        Image.asset(
          imgTali,
          width: 300,
        ),
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    isWinner();
    hasilTarikan();
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imgBackgroundGameplay), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //player 2
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
                          BlocBuilder<Player_2Cubit, Player_2State>(
                            builder: (context, state) {
                              return Text("${state.koin}",
                                  style: jomhuriaBlackGreen20);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                RotatedBox(
                  quarterTurns: 2,
                  child: PopUpPemenang(
                          namaGambar: "badak_result.png",
                          isPemenang: isBadakMenang)
                      .animate()
                      .scale(duration: 1000.ms, curve: Curves.bounceOut),
                ),

                const SizedBox(height: 10),
                //time widget
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: !isBadakMenang && !isGajahMenang
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                      children: hasilTarikan(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<Player_2Cubit, Player_2State>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                for (var hewan in state.pasukanHewan)
                                  RotatedBox(
                                    quarterTurns: 2,
                                    child: Image.asset(
                                        "assets/gameplay/$hewan.png",
                                        height: 30),
                                  ),
                              ],
                            );
                          },
                        ),
                        BlocBuilder<Player_1Cubit, Player_1State>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                for (var hewan in state.pasukanHewan)
                                  Image.asset("assets/gameplay/$hewan.png",
                                      height: 30),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, ShareScreen.routename);
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
                  ],
                ),

                const SizedBox(height: 10),
                //player 1
                PopUpPemenang(
                        namaGambar: "gajah_result.png",
                        isPemenang: isGajahMenang)
                    .animate()
                    .scale(duration: 1000.ms, curve: Curves.bounceOut),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(iconKoin),
                        BlocBuilder<Player_1Cubit, Player_1State>(
                          builder: (context, state) {
                            return Text("${state.koin}",
                                style: jomhuriaBlackGreen20);
                          },
                        ),
                      ],
                    ),
                    Image.asset(iconHapus),
                  ],
                ),
              ],
            ),
          ),
          PopupKeluar(visible: hasClickPop)
        ],
      )),
    );
  }
}
