import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/ui/screen/gameplay/result.dart';
import 'package:sketoo/ui/screen/gameplay/story.dart';
import 'package:sketoo/ui/screen/gameplay/widget/animal_price.dart';
import 'package:sketoo/utils/assets.dart';
import 'package:sketoo/utils/colors.dart';
import 'package:sketoo/utils/typograhpy.dart';

class BuyAnimal extends StatefulWidget {
  static const routename = "/buy_animal";
  const BuyAnimal({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BuyAnimalState createState() => _BuyAnimalState();
}

class _BuyAnimalState extends State<BuyAnimal> {
  // button for player 1
  bool isRabbit1Choosen = true;
  bool isMonkey1Choosen = true;
  bool isElephant1Choosen = true;
  bool isSkip1Choosen = true;

  // button for player 2
  bool isRabbit2Choosen = true;
  bool isMonkey2Choosen = true;
  bool isRhino2Choosen = true;
  bool isSkip2Choosen = true;

  // logic
  void logicGamePlay(int player, int hargaHewan, String namaGambar, bool skip) {
    bool player1Click = context.read<Player_1Cubit>().state.hasClick;
    bool player2Click = context.read<Player_2Cubit>().state.hasClick;
    int playerBabak = context.read<Player_1Cubit>().state.babak;

    if (player == 1 && player1Click == false) {
      context.read<Player_1Cubit>().subtractionKoin(hargaHewan);
      context.read<Player_1Cubit>().changeTrueClick();
      if (!skip) {
        context.read<Player_1Cubit>().addPasukanHewan(namaGambar);
      }
    } else if (player == 2 && player2Click == false) {
      context.read<Player_2Cubit>().subtractionKoin(hargaHewan);
      context.read<Player_2Cubit>().changeTrueClick();
      if (!skip) {
        context.read<Player_2Cubit>().addPasukanHewan(namaGambar);
      }
    }
    if (player1Click || player2Click) {
      if (playerBabak != 4) {
        Navigator.pushNamed(context, StoryScreen.routename);
      } else {
        Navigator.pushNamed(context, Result.routename);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imgBackgroundGameplay), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //player 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RotatedBox(
                  quarterTurns: 2,
                  child: Image.asset(iconHapus),
                ),
                BlocBuilder<Player_2Cubit, Player_2State>(
                  builder: (context, state) {
                    return RotatedBox(
                      quarterTurns: 2,
                      child: Row(
                        children: [
                          Image.asset(iconKoin),
                          Text("${state.koin}", style: jomhuriaBlackGreen20),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                RotatedBox(
                  quarterTurns: 2,
                  child: Text('Yaya Bobong', style: jomhuriaBlackGreen20),
                ),
                Visibility(
                  visible: isSkip2Choosen,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            isSkip2Choosen = true;
                            isRabbit2Choosen = false;
                            isMonkey2Choosen = false;
                            isRhino2Choosen = false;
                          });
                          logicGamePlay(2, 0, "", true);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: !isSkip2Choosen
                              ? BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: const Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],
                                )
                              : null,
                          child: Text('Skip', style: jomhuriaBlackGreen20),
                        )),
                  ),
                ),
              ],
            ),
            RotatedBox(
              quarterTurns: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: screenWidth / 1.8,
                  width: screenWidth / 1.2,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: const Color(0xFF7D4E23))),
                  child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        border: Border.all(
                          color: yellow, // Warna kuning
                          width: 10, // Ketebalan border
                        ),
                        borderRadius: BorderRadius.circular(18), // Radius 18
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSkip2Choosen = false;
                                  isRabbit2Choosen = true;
                                  isMonkey2Choosen = false;
                                  isRhino2Choosen = false;
                                });
                                logicGamePlay(2, 30, "kelinci", false);
                              },
                              child: HargaHewan(
                                namaGambar: "kelinci",
                                harga: 30,
                                player: 2,
                                isChoosen: isRabbit2Choosen,
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSkip2Choosen = false;
                                  isRabbit2Choosen = false;
                                  isMonkey2Choosen = true;
                                  isRhino2Choosen = false;
                                });
                                logicGamePlay(2, 55, "monyet", false);
                              },
                              child: HargaHewan(
                                namaGambar: "monyet",
                                harga: 55,
                                player: 2,
                                isChoosen: isMonkey2Choosen,
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSkip2Choosen = false;
                                  isRabbit2Choosen = false;
                                  isMonkey2Choosen = false;
                                  isRhino2Choosen = true;
                                });
                                logicGamePlay(2, 95, "badak", false);
                              },
                              child: HargaHewan(
                                namaGambar: "badak",
                                harga: 95,
                                player: 2,
                                isChoosen: isRhino2Choosen,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),

            const SizedBox(height: 10),
            //player 2
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: screenWidth / 1.8,
                width: screenWidth / 1.2,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 2, color: const Color(0xFF7D4E23))),
                child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: lightGreen,
                      border: Border.all(
                        color: yellow, // Warna kuning
                        width: 10, // Ketebalan border
                      ),
                      borderRadius: BorderRadius.circular(18), // Radius 18
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isRabbit1Choosen = true;
                                isMonkey1Choosen = false;
                                isElephant1Choosen = false;
                                isSkip1Choosen = false;
                              });
                              logicGamePlay(1, 30, "kelinci", false);
                            },
                            child: HargaHewan(
                              namaGambar: "kelinci",
                              harga: 30,
                              player: 1,
                              isChoosen: isRabbit1Choosen,
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isRabbit1Choosen = false;
                                isMonkey1Choosen = true;
                                isElephant1Choosen = false;
                                isSkip1Choosen = false;
                              });
                              logicGamePlay(1, 30, "monyet", false);
                            },
                            child: HargaHewan(
                              namaGambar: "monyet",
                              harga: 55,
                              player: 1,
                              isChoosen: isMonkey1Choosen,
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isRabbit1Choosen = false;
                                isMonkey1Choosen = false;
                                isElephant1Choosen = true;
                                isSkip1Choosen = false;
                              });
                              logicGamePlay(1, 95, "gajah", false);
                            },
                            child: HargaHewan(
                              namaGambar: "gajah",
                              harga: 95,
                              player: 1,
                              isChoosen: isElephant1Choosen,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                Visibility(
                  visible: isSkip1Choosen,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          isRabbit1Choosen = false;
                          isMonkey1Choosen = false;
                          isElephant1Choosen = false;
                          isSkip1Choosen = true;
                        });
                        logicGamePlay(1, 0, "", true);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: !isSkip1Choosen
                            ? BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              )
                            : null,
                        child: Text('Skip', style: jomhuriaBlackGreen20),
                      )),
                ),
                Text('Yaya Bobong', style: jomhuriaBlackGreen20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<Player_1Cubit, Player_1State>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Image.asset(iconKoin),
                        Text("${state.koin}", style: jomhuriaBlackGreen20),
                      ],
                    );
                  },
                ),
                Image.asset(iconHapus),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
