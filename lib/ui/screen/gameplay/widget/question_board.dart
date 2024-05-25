import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sketoo/utils/colors.dart';
import 'package:sketoo/utils/typograhpy.dart';

class QuestionBoard extends StatelessWidget {
  const QuestionBoard(
      {super.key,
      required this.pertanyaan,
      required this.route,
      required this.isQuestion});
  final String pertanyaan;
  final String route;
  final bool isQuestion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: lightGreen,
          border: Border.all(
            color: yellow, 
            width: 10, 
          ),
          borderRadius: BorderRadius.circular(18), // Radius 18
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Transform.rotate(
              angle: 3.14,
              child: Text(
                pertanyaan,
                textAlign: isQuestion ? TextAlign.center : TextAlign.start,
                style: juaGreen15,
              ),
            ).animate().fade(duration: 1000.ms),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, route);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(yellow),
                elevation: MaterialStateProperty.all<double>(4),
                shadowColor: MaterialStateProperty.all<Color>(
                    Colors.grey.withOpacity(0.4)),
              ),
              child: Text(
                "Next",
                style: poppinsWhite20,
              ),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shake(
                  rotation: 0.1,
                  hz: 1.7,
                ),
            Text(
              pertanyaan,
              style: juaGreen15,
            ).animate().fade(duration: 1000.ms),
          ],
        ),
      ),
    );
  }
}
