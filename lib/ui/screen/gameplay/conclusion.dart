import 'package:flutter/material.dart';
import 'package:sketoo/utils/assets.dart';
import 'package:sketoo/utils/colors.dart';

class Conclusion extends StatelessWidget {
  static const routename = "/conclusion";
  const Conclusion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              imgBackgroundResult,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: MediaQuery.of(context).size.width / 1.8,
                  width: MediaQuery.of(context).size.width / 1.2,
                  color: purple,
                  child: Column(
                    children: [
                      Text("Scores"),
                      Container(
                          decoration: BoxDecoration(
                            color: lightGreen,
                            border: Border.all(
                              color: yellow, // Warna kuning
                              width: 10, // Ketebalan border
                            ),
                            borderRadius:
                                BorderRadius.circular(18), // Radius 18
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    imgGajahResult,
                                    height: 60,
                                  ),
                                  Column(
                                    children: [
                                      Text("yaya boboboy"),
                                      Text("yaya boboboy"),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    imgGajahResult,
                                    height: 60,
                                  ),
                                  Column(
                                    children: [
                                      Text("yaya boboboy"),
                                      Text("yaya boboboy"),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
