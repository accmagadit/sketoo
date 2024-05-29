import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sketoo/utils/colors.dart';
import 'package:sketoo/utils/typograhpy.dart';

class QuestionBoard extends StatelessWidget {
  final String pertanyaan;
  final String route;
  final bool isQuestion;
  const QuestionBoard(
      {super.key,
      required this.pertanyaan,
      required this.route,
      required this.isQuestion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
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
              child: Container(
                height: !isQuestion
                    ? MediaQuery.of(context).size.height / 3
                    : MediaQuery.of(context).size.height / 5,
                child: SingleChildScrollView(
                  child: Text(
                    pertanyaan,
                    textAlign: TextAlign.center,
                    style: juaGreen15,
                  ),
                ),
              ),
            ).animate().fade(duration: 1000.ms),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, route);
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
            Container(
              height: !isQuestion
                  ? MediaQuery.of(context).size.height / 3
                  : MediaQuery.of(context).size.height / 5,
              child: SingleChildScrollView(
                child: Text(
                  pertanyaan,
                  style: juaGreen15,
                  textAlign: TextAlign.center,
                ).animate().fade(duration: 1000.ms),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
