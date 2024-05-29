// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/model/fabel.dart';
import 'package:sketoo/ui/screen/gameplay/buy_animal.dart';
import 'package:sketoo/ui/screen/information/widget/PopupKeluar.dart';
import 'package:sketoo/utils/assets.dart';
import 'package:sketoo/utils/colors.dart';
import 'package:sketoo/utils/typograhpy.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class DrawingApp extends StatefulWidget {
  static const routename = "/play_screen";
  const DrawingApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrawingAppState createState() => _DrawingAppState();
}

class _DrawingAppState extends State<DrawingApp> {
  int time = 20;
  double similarity1 = 0.0;
  double similarity2 = 0.0;
  late Timer _timer;
  List<Widget> hewanPlayer1 = [];
  List<Widget> hewanPlayer2 = [];
  final GlobalKey<SfSignaturePadState> signatureGlobalKey1 = GlobalKey();
  final GlobalKey<SfSignaturePadState> signatureGlobalKey2 = GlobalKey();
  String level = '';

  bool hasClickPop = false;

  @override
  void initState() {
    super.initState();
    setLevel();
    countingTimer();
    context.read<Player_1Cubit>().changeFalseClick();
    context.read<Player_2Cubit>().changeFalseClick();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void countingTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 0) {
        _performPredictionAndUpdateSimilarity();

        setState(() {
          time--;
        });
      } else {
        _timer.cancel();
        _saveSignaturesToCache();
        context.read<Player_1Cubit>().addKoinValue(
            (double.parse((similarity1.toString().substring(0, 3))) * 10)
                .toInt());
        context.read<Player_2Cubit>().addKoinValue(
            (double.parse((similarity2.toString().substring(0, 3))) * 10)
                .toInt());
        Navigator.pushReplacementNamed(context, BuyAnimal.routename);
      }
    });
  }

  void cleanCanvas(GlobalKey<SfSignaturePadState> signatureGlobal) {
    signatureGlobal.currentState!.clear();
  }

  void setLevel() {
    int babak = context.read<Player_1Cubit>().state.babak;
    setState(() {
      level = jawaban[babak - 1];
    });
  }

  Future<Uint8List> signatureToPngImage(
      GlobalKey<SfSignaturePadState> signatureKey) async {
    ui.Image image = await signatureKey.currentState!.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    img.Image? imgData = img.decodeImage(pngBytes);
    Uint8List finalPngBytes = img.encodePng(imgData!);

    return finalPngBytes;
  }

  Future<Uint8List> preprocessImage(
      GlobalKey<SfSignaturePadState> signatureKey) async {
    if (signatureKey.currentState != null) {
      Uint8List signaturePngBytes = await signatureToPngImage(signatureKey);
      img.Image? imgData = img.decodeImage(signaturePngBytes);
      img.Image resizedImg = img.copyResize(imgData!, width: 224, height: 224);
      img.Image grayscaleImg = img.grayscale(resizedImg);
      Uint8List finalPngBytes = img.encodePng(grayscaleImg);

      return finalPngBytes;
    } else {
      throw Exception("SignaturePad currentState is null");
    }
  }

  Future<List> prediction(Uint8List image) async {
    final interpreter =
        await tfl.Interpreter.fromAsset('assets/model/model2.tflite');

    Float32List input = Float32List(1 * 96 * 96 * 1);
    for (int i = 0; i < image.length; i++) {
      input[i] = image[i] / 255.0;
    }

    var output = List.filled(1 * 4, 0).reshape([1, 4]);

    interpreter.run(input.buffer.asUint8List(), output);

    return output;
  }

  void _performPredictionAndUpdateSimilarity() async {
    Uint8List processedImage1;
    Uint8List processedImage2;
    try {
      processedImage1 = await preprocessImage(signatureGlobalKey1);
      processedImage2 = await preprocessImage(signatureGlobalKey2);
      List resultPrediction1 = await prediction(processedImage1);
      List resultPrediction2 = await prediction(processedImage2);
      int index = jawaban.indexOf(level);
      print(similarity1);
      print(similarity2);
      setState(() {
        similarity1 = resultPrediction1[0][index];
        similarity2 = resultPrediction2[0][index];
      });
    } catch (e) {
      throw Exception("perfome predikciton and update gagal $e");
    }
  }

  Future<void> _saveSignaturesToCache() async {
    try {
      Directory cacheDir = await getTemporaryDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String path1 = '${cacheDir.path}/signature1_$timestamp.png';
      String path2 = '${cacheDir.path}/signature2_$timestamp.png';
      context.read<Player_1Cubit>().addPathImages(path1);
      context.read<Player_2Cubit>().addPathImages(path2);
      Uint8List pngBytes1 = await signatureToPngImage(signatureGlobalKey1);
      Uint8List pngBytes2 = await signatureToPngImage(signatureGlobalKey2);
      File file1 = File(path1);
      File file2 = File(path2);
      await file1.writeAsBytes(pngBytes1);
      await file2.writeAsBytes(pngBytes2);
    } catch (e) {
      debugPrint("gagal nyimpan gambar di cache $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: screenHeight < 750
            ? SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imgBackgroundGameplay),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //player 1
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RotatedBox(
                                quarterTurns: 2,
                                child: InkWell(
                                    onTap: () {
                                      cleanCanvas(signatureGlobalKey2);
                                    },
                                    child: Image.asset(iconHapus)),
                              ),
                              BlocBuilder<Player_2Cubit, Player_2State>(
                                builder: (context, state) {
                                  return RotatedBox(
                                    quarterTurns: 2,
                                    child: Row(
                                      children: [
                                        Image.asset(iconKoin),
                                        Text("${state.koin}",
                                            style: jomhuriaBlackGreen20),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RotatedBox(
                                quarterTurns: 2,
                                child:
                                    BlocBuilder<Player_2Cubit, Player_2State>(
                                  builder: (context, state) {
                                    return Text(state.nama,
                                        style: jomhuriaBlackGreen20);
                                  },
                                ),
                              ),
                              RotatedBox(
                                quarterTurns: 2,
                                child: Text(
                                    "${double.parse((similarity2.toString().substring(0, 3))) * 10}%",
                                    style: jomhuriaBlackGreen20),
                              ),
                            ],
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: screenWidth / 1.8,
                                width: screenWidth / 1.4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: const Color(0xFF7D4E23))),
                                child: SfSignaturePad(
                                  key: signatureGlobalKey2,
                                  minimumStrokeWidth: 3,
                                  maximumStrokeWidth: 3,
                                  strokeColor: Colors.black,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                          //time widget
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  Image.asset(imgTali),
                                  const SizedBox(),
                                ],
                              )
                                  .animate(
                                    onPlay: (controller) =>
                                        controller.repeat(reverse: true),
                                  )
                                  .moveX(
                                    duration: 1000.ms,
                                    begin: -10,
                                    end: 10,
                                  ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<Player_2Cubit, Player_2State>(
                                    builder: (context, state) {
                                      return Row(
                                        children: [
                                          for (var hewan in state.pasukanHewan)
                                            RotatedBox(
                                              quarterTurns: 2,
                                              child: Image.asset(
                                                  "assets/gameplay/$hewan.png",
                                                  height: 30),
                                            ),
                                        ],
                                      );
                                    },
                                  )
                                      .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                      )
                                      .moveX(
                                        curve: Curves.easeIn,
                                        duration: 1000.ms,
                                        begin: -10,
                                        end: 10,
                                      ),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: yellow,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$time',
                                        style: poppinsWhite20, // Teks putih
                                      ),
                                    ),
                                  ),
                                  BlocBuilder<Player_1Cubit, Player_1State>(
                                    builder: (context, state) {
                                      return Row(
                                        children: [
                                          for (var hewan in state.pasukanHewan)
                                            Image.asset(
                                                "assets/gameplay/$hewan.png",
                                                height: 30),
                                        ],
                                      );
                                    },
                                  )
                                      .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                      )
                                      .moveX(
                                        curve: Curves.easeIn,
                                        duration: 1000.ms,
                                        begin: -10,
                                        end: 10,
                                      ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          //player 2
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: screenWidth / 1.8,
                              width: screenWidth / 1.4,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: const Color(0xFF7D4E23))),
                              child: SfSignaturePad(
                                key: signatureGlobalKey1,
                                minimumStrokeWidth: 3,
                                maximumStrokeWidth: 3,
                                strokeColor: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  "${double.parse((similarity1.toString().substring(0, 3))) * 10}%",
                                  style: jomhuriaBlackGreen20),
                              BlocBuilder<Player_1Cubit, Player_1State>(
                                builder: (context, state) {
                                  return Text(state.nama,
                                      style: jomhuriaBlackGreen20);
                                },
                              ),
                            ],
                          ),
                          BlocBuilder<Player_1Cubit, Player_1State>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(iconKoin),
                                      Text('${state.koin}',
                                          style: jomhuriaBlackGreen20),
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () {
                                        cleanCanvas(signatureGlobalKey1);
                                      },
                                      child: Image.asset(iconHapus)),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    PopupKeluar(visible: hasClickPop)
                  ],
                ),
              )
            //ukuran layar besar 750
            : Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imgBackgroundGameplay),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //player 1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RotatedBox(
                              quarterTurns: 2,
                              child: InkWell(
                                  onTap: () {
                                    cleanCanvas(signatureGlobalKey2);
                                  },
                                  child: Image.asset(iconHapus)),
                            ),
                            BlocBuilder<Player_2Cubit, Player_2State>(
                              builder: (context, state) {
                                return RotatedBox(
                                  quarterTurns: 2,
                                  child: Row(
                                    children: [
                                      Image.asset(iconKoin),
                                      Text("${state.koin}",
                                          style: jomhuriaBlackGreen20),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RotatedBox(
                              quarterTurns: 2,
                              child: BlocBuilder<Player_2Cubit, Player_2State>(
                                builder: (context, state) {
                                  return Text(state.nama,
                                      style: jomhuriaBlackGreen20);
                                },
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 2,
                              child: Text(
                                  "${double.parse((similarity2.toString().substring(0, 3))) * 10}%",
                                  style: jomhuriaBlackGreen20),
                            ),
                          ],
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: screenWidth / 1.8,
                              width: screenWidth / 1.4,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: const Color(0xFF7D4E23))),
                              child: SfSignaturePad(
                                key: signatureGlobalKey2,
                                minimumStrokeWidth: 3,
                                maximumStrokeWidth: 3,
                                strokeColor: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        //time widget
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                Image.asset(imgTali),
                                const SizedBox(),
                              ],
                            )
                                .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: true),
                                )
                                .moveX(
                                  duration: 1000.ms,
                                  begin: -10,
                                  end: 10,
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocBuilder<Player_2Cubit, Player_2State>(
                                  builder: (context, state) {
                                    return Row(
                                      children: [
                                        for (var hewan in state.pasukanHewan)
                                          RotatedBox(
                                            quarterTurns: 2,
                                            child: Image.asset(
                                                "assets/gameplay/$hewan.png",
                                                height: 30),
                                          ),
                                      ],
                                    );
                                  },
                                )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .moveX(
                                      curve: Curves.easeIn,
                                      duration: 1000.ms,
                                      begin: -10,
                                      end: 10,
                                    ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: yellow,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$time',
                                      style: poppinsWhite20, // Teks putih
                                    ),
                                  ),
                                ),
                                BlocBuilder<Player_1Cubit, Player_1State>(
                                  builder: (context, state) {
                                    return Row(
                                      children: [
                                        for (var hewan in state.pasukanHewan)
                                          Image.asset(
                                              "assets/gameplay/$hewan.png",
                                              height: 30),
                                      ],
                                    );
                                  },
                                )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .moveX(
                                      curve: Curves.easeIn,
                                      duration: 1000.ms,
                                      begin: -10,
                                      end: 10,
                                    ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        //player 2
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: screenWidth / 1.8,
                            width: screenWidth / 1.4,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: const Color(0xFF7D4E23))),
                            child: SfSignaturePad(
                              key: signatureGlobalKey1,
                              minimumStrokeWidth: 3,
                              maximumStrokeWidth: 3,
                              strokeColor: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                "${double.parse((similarity1.toString().substring(0, 3))) * 10}%",
                                style: jomhuriaBlackGreen20),
                            BlocBuilder<Player_1Cubit, Player_1State>(
                              builder: (context, state) {
                                return Text(state.nama,
                                    style: jomhuriaBlackGreen20);
                              },
                            ),
                          ],
                        ),
                        BlocBuilder<Player_1Cubit, Player_1State>(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(iconKoin),
                                    Text('${state.koin}',
                                        style: jomhuriaBlackGreen20),
                                  ],
                                ),
                                InkWell(
                                    onTap: () {
                                      cleanCanvas(signatureGlobalKey1);
                                    },
                                    child: Image.asset(iconHapus)),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  PopupKeluar(visible: hasClickPop)
                ],
              ),
      ),
    );
  }
}
