import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/utils/assets.dart';
import 'package:sketoo/utils/typograhpy.dart';

class ScoreConclusion extends StatelessWidget {
  const ScoreConclusion({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 320,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color(0xFF3C273F).withOpacity(0.1), width: 3),
              gradient: const LinearGradient(
                colors: [Color(0xFFD2ABF3), Color(0xFFE2D6ED)],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 15,
                    blurStyle: BlurStyle.outer,
                    color: Color(0xFF767676)),
                BoxShadow(
                    blurStyle: BlurStyle.inner,
                    color: Color(0xFFE8E2ED),
                    offset: Offset(-1.5, -2)),
              ],
            ),
            child: Center(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text('Scores', style: textPoppins),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 9,
            child: Container(
                width: 300,
                height: 135,
                decoration: BoxDecoration(
                  color: const Color(0xffdcaedff),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        blurStyle: BlurStyle.inner,
                        color: Colors.white,
                        offset: Offset(1, 1.5))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          imgGajahResult,
                          height: 40,
                        ),
                        Image.asset(
                          imgBadakResult,
                          height: 40,
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<Player_1Cubit, Player_1State>(
                          builder: (context, state) {
                            return Text(
                              state.nama,
                              style: poppinsBlack16,
                            );
                          },
                        ),
                        BlocBuilder<Player_1Cubit, Player_1State>(
                          builder: (context, state) {
                            Map<String, int> hewanPoin = {
                              "kelinci": 30,
                              "monyet": 55,
                              "gajah": 95,
                            };
                            List<String> pasukan = state.pasukanHewan;
                            int totalPoin = 0;
                            for (String hewan in pasukan) {
                              totalPoin += hewanPoin[hewan]!;
                            }
                            return Text(
                              "$totalPoin",
                              style: juaBlack15,
                            );
                          },
                        ),
                        BlocBuilder<Player_2Cubit, Player_2State>(
                          builder: (context, state) {
                            return Text(
                              state.nama,
                              style: poppinsBlack16,
                            );
                          },
                        ),
                        BlocBuilder<Player_2Cubit, Player_2State>(
                          builder: (context, state) {
                            Map<String, int> hewanPoin = {
                              "kelinci": 30,
                              "monyet": 55,
                              "badak": 95,
                            };
                            List<String> pasukan = state.pasukanHewan;
                            int totalPoin = 0;
                            for (String hewan in pasukan) {
                              totalPoin += hewanPoin[hewan]!;
                            }
                            return Text(
                              "$totalPoin",
                              style: juaBlack15,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
