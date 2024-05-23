import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/widget/PopupInputPlayer.dart';

class InputPlayer extends StatefulWidget {
  const InputPlayer({Key? key}) : super(key: key);

  @override
  State<InputPlayer> createState() => _InputPlayerState();
}

class _InputPlayerState extends State<InputPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/background-biru.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/logo_sketoo.png'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              PopupInputPlayer(),
            ],
          ),
        ),
      ),
    );
  }
}
