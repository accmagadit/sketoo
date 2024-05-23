import 'package:flutter/material.dart';
import 'package:sketoo/utils/colors.dart';

//penamaan font
//lalezarBlack104
//==============
//lalezar = nama font
//Black = warna font
//2 digit pertama = ukuran font
//digit terakhir = ketebalan font
TextStyle lalezarBlack104 = const TextStyle(
    fontFamily: "lalezar",
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.black);

TextStyle textbuttonPoppins = TextStyle(
  fontFamily: "Poppins",
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  shadows: [
    Shadow(
      color: Colors.black.withOpacity(0.3),
      offset: Offset(2, 2),
      blurRadius: 10.0,
    ),
  ],
);

TextStyle textPoppins = TextStyle(
  fontFamily: "Poppins",
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  shadows: [
    Shadow(
      color: Colors.black.withOpacity(0.3),
      offset: Offset(2, 2),
      blurRadius: 10.0,
    ),
  ],
);

TextStyle inputJua = const TextStyle(
  fontFamily: "Jua",
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

TextStyle juaGreen15 = TextStyle(
  color: blackGreen,
  fontSize: 15,
  fontFamily: 'Jua',
);
TextStyle juaBlack15 = TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontFamily: 'Jua',
);

TextStyle poppinsWhite20 =
    TextStyle(color: white, fontSize: 20, fontFamily: 'Poppins');

TextStyle poppinsBlack16 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold);

TextStyle jomhuriaBlackGreen20 =
    TextStyle(color: blackGreen, fontFamily: 'Jomhuria', fontSize: 30);

