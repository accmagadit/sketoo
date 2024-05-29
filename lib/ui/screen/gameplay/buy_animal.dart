import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/ui/screen/gameplay/result.dart';
import 'package:sketoo/ui/screen/gameplay/story.dart';
import 'package:sketoo/ui/screen/gameplay/widget/animal_price.dart';
import 'package:sketoo/ui/screen/information/widget/PopupKeluar.dart';
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
  bool hasClickPop = false;
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

    debugPrint("$playerBabak");

    if (player1Click || player2Click) {
      if (playerBabak < 4) {
        Navigator.pushReplacementNamed(context, StoryScreen.routename);
      } else if (playerBabak == 4) {
        Navigator.pushReplacementNamed(context, Result.routename);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    int koinPlayer1 = context.read<Player_1Cubit>().state.koin;
    int koinPlayer2 = context.read<Player_2Cubit>().state.koin;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: screenHeight < 750
            ? SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imgBackgroundGameplay),
                            fit: BoxFit.cover),
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
                                        Text("${state.koin}",
                                            style: jomhuriaBlackGreen20),
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
                              RotatedBox(
                                quarterTurns: 2,
                                child:
                                    BlocBuilder<Player_2Cubit, Player_2State>(
                                  builder: (context, state) {
                                    return Text(state.nama,
                                        style: jomhuriaBlackGreen20);
                                  },
                                ),
                              ),
                              Visibility(
                                visible: isSkip2Choosen,
                                child: RotatedBox(
                                  quarterTurns: 2,
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isRabbit2Choosen = false;
                                          isMonkey2Choosen = false;
                                          isRhino2Choosen = false;
                                        });
                                        logicGamePlay(2, 0, "", true);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              offset: const Offset(0, 4),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Text('Skip',
                                            style: jomhuriaBlackGreen20),
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
                                    border: Border.all(
                                        width: 2,
                                        color: const Color(0xFF7D4E23))),
                                child: Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: lightGreen,
                                      border: Border.all(
                                        color: yellow, // Warna kuning
                                        width: 10, // Ketebalan border
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          18), // Radius 18
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Visibility(
                                            visible: isRabbit2Choosen,
                                            child: InkWell(
                                              onTap: () {
                                                if (koinPlayer2 > 29) {
                                                  setState(() {
                                                    isSkip2Choosen = false;
                                                    isMonkey2Choosen = false;
                                                    isRhino2Choosen = false;
                                                  });
                                                  logicGamePlay(
                                                      2, 30, "kelinci", false);
                                                }
                                              },
                                              child: const HargaHewan(
                                                namaGambar: "kelinci",
                                                harga: 30,
                                                player: 2,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Visibility(
                                            visible: isMonkey2Choosen,
                                            child: InkWell(
                                              onTap: () {
                                                if (koinPlayer2 > 54) {
                                                  setState(() {
                                                    isSkip2Choosen = false;
                                                    isRabbit2Choosen = false;
                                                    isRhino2Choosen = false;
                                                  });
                                                  logicGamePlay(
                                                      2, 55, "monyet", false);
                                                }
                                              },
                                              child: const HargaHewan(
                                                namaGambar: "monyet",
                                                harga: 55,
                                                player: 2,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Visibility(
                                            visible: isRhino2Choosen,
                                            child: InkWell(
                                              onTap: () {
                                                if (koinPlayer2 > 94) {
                                                  setState(() {
                                                    isSkip2Choosen = false;
                                                    isRabbit2Choosen = false;
                                                    isMonkey2Choosen = false;
                                                  });
                                                  logicGamePlay(
                                                      2, 95, "badak", false);
                                                }
                                              },
                                              child: const HargaHewan(
                                                namaGambar: "badak",
                                                harga: 95,
                                                player: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                          //player 1
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: screenWidth / 1.8,
                              width: screenWidth / 1.2,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: const Color(0xFF7D4E23))),
                              child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: lightGreen,
                                    border: Border.all(
                                      color: yellow, // Warna kuning
                                      width: 10, // Ketebalan border
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(18), // Radius 18
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: isRabbit1Choosen,
                                          child: InkWell(
                                            onTap: () {
                                              if (koinPlayer1 > 29) {
                                                setState(() {
                                                  isMonkey1Choosen = false;
                                                  isElephant1Choosen = false;
                                                  isSkip1Choosen = false;
                                                });
                                                logicGamePlay(
                                                    1, 30, "kelinci", false);
                                              }
                                            },
                                            child: const HargaHewan(
                                              namaGambar: "kelinci",
                                              harga: 30,
                                              player: 1,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Visibility(
                                          visible: isMonkey1Choosen,
                                          child: InkWell(
                                            onTap: () {
                                              if (koinPlayer1 > 54) {
                                                setState(() {
                                                  isRabbit1Choosen = false;
                                                  isElephant1Choosen = false;
                                                  isSkip1Choosen = false;
                                                });
                                                logicGamePlay(
                                                    1, 55, "monyet", false);
                                              }
                                            },
                                            child: const HargaHewan(
                                              namaGambar: "monyet",
                                              harga: 55,
                                              player: 1,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Visibility(
                                          visible: isElephant1Choosen,
                                          child: InkWell(
                                            onTap: () {
                                              if (koinPlayer1 > 94) {
                                                setState(() {
                                                  isRabbit1Choosen = false;
                                                  isMonkey1Choosen = false;
                                                  isSkip1Choosen = false;
                                                });
                                                logicGamePlay(
                                                    1, 95, "gajah", false);
                                              }
                                            },
                                            child: const HargaHewan(
                                              namaGambar: "gajah",
                                              harga: 95,
                                              player: 1,
                                            ),
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
                              Visibility(
                                visible: isSkip1Choosen,
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isRabbit1Choosen = false;
                                        isMonkey1Choosen = false;
                                        isElephant1Choosen = false;
                                      });
                                      logicGamePlay(1, 0, "", true);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            offset: const Offset(0, 4),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Text('Skip',
                                          style: jomhuriaBlackGreen20),
                                    )),
                              ),
                              BlocBuilder<Player_1Cubit, Player_1State>(
                                builder: (context, state) {
                                  return Text(state.nama,
                                      style: jomhuriaBlackGreen20);
                                },
                              ),
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
                                      Text("${state.koin}",
                                          style: jomhuriaBlackGreen20),
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
                    PopupKeluar(visible: hasClickPop)
                  ],
                ),
              )

            //ukuran hp diatas 750
            : Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imgBackgroundGameplay),
                          fit: BoxFit.cover),
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
                                      Text("${state.koin}",
                                          style: jomhuriaBlackGreen20),
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
                            RotatedBox(
                              quarterTurns: 2,
                              child: BlocBuilder<Player_2Cubit, Player_2State>(
                                builder: (context, state) {
                                  return Text(state.nama,
                                      style: jomhuriaBlackGreen20);
                                },
                              ),
                            ),
                            Visibility(
                              visible: isSkip2Choosen,
                              child: RotatedBox(
                                quarterTurns: 2,
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isRabbit2Choosen = false;
                                        isMonkey2Choosen = false;
                                        isRhino2Choosen = false;
                                      });
                                      logicGamePlay(2, 0, "", true);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            offset: const Offset(0, 4),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Text('Skip',
                                          style: jomhuriaBlackGreen20),
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
                                  border: Border.all(
                                      width: 2,
                                      color: const Color(0xFF7D4E23))),
                              child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: lightGreen,
                                    border: Border.all(
                                      color: yellow, // Warna kuning
                                      width: 10, // Ketebalan border
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(18), // Radius 18
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: isRabbit2Choosen,
                                          child: InkWell(
                                            onTap: () {
                                              if (koinPlayer2 > 29) {
                                                setState(() {
                                                  isSkip2Choosen = false;
                                                  isMonkey2Choosen = false;
                                                  isRhino2Choosen = false;
                                                });
                                                logicGamePlay(
                                                    2, 30, "kelinci", false);
                                              }
                                            },
                                            child: const HargaHewan(
                                              namaGambar: "kelinci",
                                              harga: 30,
                                              player: 2,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Visibility(
                                          visible: isMonkey2Choosen,
                                          child: InkWell(
                                            onTap: () {
                                              if (koinPlayer2 > 54) {
                                                setState(() {
                                                  isSkip2Choosen = false;
                                                  isRabbit2Choosen = false;
                                                  isRhino2Choosen = false;
                                                });
                                                logicGamePlay(
                                                    2, 55, "monyet", false);
                                              }
                                            },
                                            child: const HargaHewan(
                                              namaGambar: "monyet",
                                              harga: 55,
                                              player: 2,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Visibility(
                                          visible: isRhino2Choosen,
                                          child: InkWell(
                                            onTap: () {
                                              if (koinPlayer2 > 94) {
                                                setState(() {
                                                  isSkip2Choosen = false;
                                                  isRabbit2Choosen = false;
                                                  isMonkey2Choosen = false;
                                                });
                                                logicGamePlay(
                                                    2, 95, "badak", false);
                                              }
                                            },
                                            child: const HargaHewan(
                                              namaGambar: "badak",
                                              harga: 95,
                                              player: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        //player 1
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: screenWidth / 1.8,
                            width: screenWidth / 1.2,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: const Color(0xFF7D4E23))),
                            child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: lightGreen,
                                  border: Border.all(
                                    color: yellow, // Warna kuning
                                    width: 10, // Ketebalan border
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(18), // Radius 18
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible: isRabbit1Choosen,
                                        child: InkWell(
                                          onTap: () {
                                            if (koinPlayer1 > 29) {
                                              setState(() {
                                                isMonkey1Choosen = false;
                                                isElephant1Choosen = false;
                                                isSkip1Choosen = false;
                                              });
                                              logicGamePlay(
                                                  1, 30, "kelinci", false);
                                            }
                                          },
                                          child: const HargaHewan(
                                            namaGambar: "kelinci",
                                            harga: 30,
                                            player: 1,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Visibility(
                                        visible: isMonkey1Choosen,
                                        child: InkWell(
                                          onTap: () {
                                            if (koinPlayer1 > 54) {
                                              setState(() {
                                                isRabbit1Choosen = false;
                                                isElephant1Choosen = false;
                                                isSkip1Choosen = false;
                                              });
                                              logicGamePlay(
                                                  1, 55, "monyet", false);
                                            }
                                          },
                                          child: const HargaHewan(
                                            namaGambar: "monyet",
                                            harga: 55,
                                            player: 1,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Visibility(
                                        visible: isElephant1Choosen,
                                        child: InkWell(
                                          onTap: () {
                                            if (koinPlayer1 > 94) {
                                              setState(() {
                                                isRabbit1Choosen = false;
                                                isMonkey1Choosen = false;
                                                isSkip1Choosen = false;
                                              });
                                              logicGamePlay(
                                                  1, 95, "gajah", false);
                                            }
                                          },
                                          child: const HargaHewan(
                                            namaGambar: "gajah",
                                            harga: 95,
                                            player: 1,
                                          ),
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
                            Visibility(
                              visible: isSkip1Choosen,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isRabbit1Choosen = false;
                                      isMonkey1Choosen = false;
                                      isElephant1Choosen = false;
                                    });
                                    logicGamePlay(1, 0, "", true);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Text('Skip',
                                        style: jomhuriaBlackGreen20),
                                  )),
                            ),
                            BlocBuilder<Player_1Cubit, Player_1State>(
                              builder: (context, state) {
                                return Text(state.nama,
                                    style: jomhuriaBlackGreen20);
                              },
                            ),
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
                                    Text("${state.koin}",
                                        style: jomhuriaBlackGreen20),
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
                  PopupKeluar(visible: hasClickPop)
                ],
              ),
      ),
    );
  }
}
