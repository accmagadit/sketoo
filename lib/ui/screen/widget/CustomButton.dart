import 'package:flutter/material.dart';
import 'package:sketoo/utils/typograhpy.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final double height;
  final double width;

  const CustomButton({
    required this.color,
    required this.text,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            color: Colors.white, 
            width: 0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: textbuttonPoppins,
        ),
      ),
    );
  }
}
