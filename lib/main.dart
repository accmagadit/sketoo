import 'package:flutter/material.dart';
import 'package:sketoo/ui/screen/information/Home.dart';
import 'package:sketoo/ui/screen/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/ui/screen/gameplay/buy_animal.dart';
import 'package:sketoo/ui/screen/gameplay/canvas.dart';
import 'package:sketoo/ui/screen/gameplay/conclusion.dart';
import 'package:sketoo/ui/screen/gameplay/question.dart';
import 'package:sketoo/ui/screen/gameplay/result.dart';
import 'package:sketoo/ui/screen/gameplay/story.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => Player_1Cubit(),
        child: const DrawingApp(),
      ),
      BlocProvider(
        create: (context) => Player_2Cubit(),
        child: const DrawingApp(),
      ),
      BlocProvider(
        create: (context) => Player_1Cubit(),
        child: const BuyAnimal(),
      ),
      BlocProvider(
        create: (context) => Player_2Cubit(),
        child: const BuyAnimal(),
      ),
      BlocProvider(
        create: (context) => Player_1Cubit(),
        child: const StoryScreen(),
      ),
      BlocProvider(
        create: (context) => Player_2Cubit(),
        child: const StoryScreen(),
      ),
      BlocProvider(
        create: (context) => Player_1Cubit(),
        child: const Result(),
      ),
      BlocProvider(
        create: (context) => Player_2Cubit(),
        child: const Result(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: StoryScreen.routename,
      routes: {
        SplashScreen.routename: (context) => const SplashScreen(),
      },
      home: const SplashScreen(),
        StoryScreen.routename: (context) => const StoryScreen(),
        QuestionScreen.routename: (context) => const QuestionScreen(),
        DrawingApp.routename: (context) => const DrawingApp(),
        BuyAnimal.routename: (context) => const BuyAnimal(),
        Result.routename: (context) => const Result(),
        Conclusion.routename: (context) => const Conclusion(),
      },
      //auth

      //information

      //gameplay
    );
  }
}
