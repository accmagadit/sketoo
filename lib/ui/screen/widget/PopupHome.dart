import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/information/InputPlayer.dart';
import 'package:sketoo/ui/screen/widget/CustomButton.dart';
import 'package:sketoo/utils/typograhpy.dart';

class PopupHome extends StatelessWidget {
  const PopupHome({super.key});

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
                  color: Color(0xFF3C273F).withOpacity(0.1), width: 3),
              gradient: LinearGradient(
                colors: [Color(0xFFD2ABF3), Color(0xFFE2D6ED)],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
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
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    'Welcome,',
                    style: textPoppins
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 9,
            child: Container(
              width: 300,
              height: 130,
              decoration: BoxDecoration(
                color: Color(0xFFDCAEDFF),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InputPlayer()),
                        );
                      },
                      child: CustomButton(
                          color: Color(0xFFFFD900),
                          text: 'Play',
                          height: 50,
                          width: 120),
                    )
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
