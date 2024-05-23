import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sketoo/ui/screen/information/Home.dart';
import 'package:sketoo/ui/screen/widget/CustomButton.dart';
import 'package:sketoo/utils/typograhpy.dart';

class PopupKeluar extends StatelessWidget {
  const PopupKeluar({super.key});

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
                  child: Text('Keluar?', style: textPoppins),
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
                color: Color(0xFFDCAEDFF),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      blurStyle: BlurStyle.inner,
                      color: Colors.white,
                      offset: Offset(1, 1.5))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomButton(
                      color: Color(0xFFFF6EC9),
                      text: 'Tidak',
                      height: 40,
                      width: 100,
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      // Exit the app
                      Future.delayed(Duration(milliseconds: 100), () {
                        SystemNavigator.pop();
                      });
                    },
                    child: CustomButton(
                      color: Color(0xFFFFEF96),
                      text: 'Ya',
                      height: 40,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
