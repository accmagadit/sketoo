import 'package:flutter/material.dart';

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
