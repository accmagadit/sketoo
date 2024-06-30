import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sketoo/cubit/role/cubit/role_cubit.dart';
import 'package:sketoo/ui/screen/gameplay/share.dart';
import 'package:sketoo/ui/screen/information/exit.dart';
import 'package:sketoo/ui/screen/information/role.dart';
import 'package:sketoo/ui/screen/information/welcome.dart';
import 'package:sketoo/ui/screen/information/input_player.dart';
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
import 'package:sketoo/utils/assets.dart';

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
      BlocProvider(
        create: (context) => Player_1Cubit(),
        child: const ShareScreen(),
      ),
      BlocProvider(
        create: (context) => Player_2Cubit(),
        child: const ShareScreen(),
      ),
      BlocProvider(
        create: (context) => Player_1Cubit(),
        child: const Conclusion(),
      ),
      BlocProvider(
        create: (context) => Player_2Cubit(),
        child: const Conclusion(),
      ),

      //ROLE
      BlocProvider(
        create: (context) => RoleCubit(),
        child: const RoleScreen(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playMusic();
  }

  Future<void> _playMusic() async {
    await _audioPlayer.setSource(AssetSource(musicPath));
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.resume();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routename,
      routes: {
        SplashScreen.routename: (context) => const SplashScreen(),

        // Gameplay
        StoryScreen.routename: (context) => const StoryScreen(),
        QuestionScreen.routename: (context) => const QuestionScreen(),
        DrawingApp.routename: (context) => const DrawingApp(),
        BuyAnimal.routename: (context) => const BuyAnimal(),
        Result.routename: (context) => const Result(),
        Conclusion.routename: (context) => const Conclusion(),
        ShareScreen.routename: (context) => const ShareScreen(),

        // Information
        Exit.routename: (context) => const Exit(),
        HomeScreen.routename: (context) => const HomeScreen(),
        InputPlayer.routename: (context) => const InputPlayer(),
        RoleScreen.routename: (context) => const RoleScreen(),
      },
      //auth

      //information

      //gameplay
    );
  }
}
