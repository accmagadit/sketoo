import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/ui/screen/gameplay/buy_animal.dart';
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
  int time = 2;
  double similarity1 = 0.0;
  double similarity2 = 0.0;
  late Timer _timer;
  List<Widget> hewanPlayer1 = [];
  List<Widget> hewanPlayer2 = [];
  List<String> classesModel = [
    'ambulans',
    'apel',
    'burung',
    'jam alarm',
    'kapal',
    'landasar',
    'lengan',
    'peri',
    'pesawat',
    'semut'
  ];
  final GlobalKey<SfSignaturePadState> signatureGlobalKey1 = GlobalKey();
  final GlobalKey<SfSignaturePadState> signatureGlobalKey2 = GlobalKey();
  String level = '';

  @override
  void initState() {
    super.initState();
    setLevel();
    countingTimer();
    print(
        "pasukan player 1: ${context.read<Player_1Cubit>().state.pasukanHewan}");
    print(
        "pasukan player 2: ${context.read<Player_2Cubit>().state.pasukanHewan}");
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
        context.read<Player_1Cubit>().changeKoinValue(200);
        context.read<Player_2Cubit>().changeKoinValue(400);
        Navigator.pushNamed(context, BuyAnimal.routename);
      }
    });
  }

  void cleanCanvas(GlobalKey<SfSignaturePadState> signatureGlobal) {
    signatureGlobal.currentState!.clear();
  }

  void setLevel() {
    setState(() {
      level = classesModel[0];
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
      img.Image resizedImg = img.copyResize(imgData!, width: 28, height: 28);
      img.Image grayscaleImg = img.grayscale(resizedImg);
      Uint8List finalPngBytes = img.encodePng(grayscaleImg);

      return finalPngBytes;
    } else {
      throw Exception("SignaturePad currentState is null");
    }
  }

  Future<List> prediction(Uint8List image) async {
    final interpreter =
        await tfl.Interpreter.fromAsset('assets/model/model.tflite');

    Float32List input = Float32List(28 * 28 * 1);
    for (int i = 0; i < image.length; i++) {
      input[i] = image[i] / 255.0;
    }

    var output = List.filled(1 * 10, 0).reshape([1, 10]);

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
      int index = classesModel.indexOf(level);
      setState(() {
        similarity1 = resultPrediction1[0][index];
        similarity2 = resultPrediction2[0][index];
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      imgBackgroundGameplay,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
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
                            child: Text(
                                '${(similarity2 * 100).toStringAsFixed(2)}%',
                                style: jomhuriaBlackGreen20),
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: Text('Yaya Bobong',
                                style: jomhuriaBlackGreen20),
                          ),
                        ],
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: constraints.maxWidth / 1.8,
                            width: constraints.maxWidth / 1.4,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: const Color(0xFF7D4E23))),
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
                          height: constraints.maxWidth / 1.8,
                          width: constraints.maxWidth / 1.4,
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
                          Text('${(similarity1 * 100).toStringAsFixed(2)}%',
                              style: jomhuriaBlackGreen20),
                          Text('Yaya Bobong', style: jomhuriaBlackGreen20),
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
                ],
              );
            },
          );
        },
      ),
    );
  }
}
