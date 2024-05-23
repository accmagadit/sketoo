import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/gameplay/story.dart';
import 'package:sketoo/ui/screen/information/widget/CustomButton.dart';
import 'package:sketoo/ui/screen/information/widget/InputText.dart';
import 'package:sketoo/utils/typograhpy.dart';

class PopupInputPlayer extends StatelessWidget {
  const PopupInputPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 280,
            height: 300,
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
                    color: Color.fromARGB(255, 232, 226, 237),
                    offset: Offset(-1.5, -2)),
              ],
            ),
            child: Center(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text('Player', style: textPoppins),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 9,
            child: Container(
              width: 260,
              height: 235,
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const InputText(
                        initialText: "Nama Player 1",
                        backgroundColor: Color(0xFFFFD900),
                        width: 200,
                        height: 40),
                    const SizedBox(height: 20),
                    const InputText(
                        initialText: "Nama Player 2",
                        backgroundColor: Color(0xFFFFD900),
                        width: 200,
                        height: 40),
                    const SizedBox(height: 30),
                    Container(
                      child: CustomButton(
                          onTap: () {
                            Navigator.pushNamed(context, StoryScreen.routename);
                          },
                          color: Color(0xFFFF6EC9),
                          text: 'Start!',
                          height: 45,
                          width: 135),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
