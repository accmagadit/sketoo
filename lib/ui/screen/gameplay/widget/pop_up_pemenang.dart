import 'package:flutter/material.dart';
import 'package:sketoo/utils/colors.dart';
import 'package:sketoo/utils/typograhpy.dart'; // Import widget HargaHewan

class PopUpPemenang extends StatelessWidget {
  final String namaGambar;
  final bool isPemenang;

  const PopUpPemenang({
    Key? key,
    required this.namaGambar,
    required this.isPemenang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 2, color: const Color(0xFF7D4E23)),
      ),
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: lightGreen,
            border: Border.all(
              color: yellow, // Warna kuning
              width: 10, // Ketebalan border
            ),
            borderRadius: BorderRadius.circular(18), // Radius 18
          ),
          child: Column(
            children: [
              Image.asset("assets/gameplay/$namaGambar"),
              Text(
                isPemenang
                    ? "Selamat, kamu memenangkan permainan!"
                    : "Usahamu keren, coba lagi ya!",
                style: poppinsBlack16,
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
