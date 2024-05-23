import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/ui/widget/animal_price.dart';
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
                      imgBackground,
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
                          const SizedBox(),
                          RotatedBox(
                            quarterTurns: 2,
                            child: InkWell(
                                onTap: () {
                                  context
                                      .read<Player_2Cubit>()
                                      .changeHasClick();
                                },
                                child:
                                    Text('Skip', style: jomhuriaBlackGreen20)),
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: Text('Yaya Bobong',
                                style: jomhuriaBlackGreen20),
                          ),
                        ],
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: constraints.maxWidth / 1.8,
                            width: constraints.maxWidth / 1.2,
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
                                child: const SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      HargaHewan(
                                        namaGambar: "kelinci",
                                        harga: 30,
                                        player: 2,
                                      ),
                                      SizedBox(width: 20),
                                      HargaHewan(
                                        namaGambar: "monyet",
                                        harga: 55,
                                        player: 2,
                                      ),
                                      SizedBox(width: 20),
                                      HargaHewan(
                                        namaGambar: "badak",
                                        harga: 95,
                                        player: 2,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      //time widget

                      const SizedBox(height: 10),
                      //player 2
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: constraints.maxWidth / 1.8,
                          width: constraints.maxWidth / 1.2,
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
                              child: const SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    HargaHewan(
                                      namaGambar: "kelinci",
                                      harga: 30,
                                      player: 1,
                                    ),
                                    SizedBox(width: 20),
                                    HargaHewan(
                                      namaGambar: "monyet",
                                      harga: 55,
                                      player: 1,
                                    ),
                                    SizedBox(width: 20),
                                    HargaHewan(
                                      namaGambar: "gajah",
                                      harga: 95,
                                      player: 1,
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
                          InkWell(
                              onTap: () {
                                context.read<Player_1Cubit>().changeHasClick();
                              },
                              child: Text('Skip', style: jomhuriaBlackGreen20)),
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
                                  Text("${state.koin}",
                                      style: jomhuriaBlackGreen20),
                                  Image.asset(iconKoin),
                                ],
                              );
                            },
                          ),
                          Image.asset(iconHapus),
                        ],
                      ),
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
