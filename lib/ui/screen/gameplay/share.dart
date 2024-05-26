import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sketoo/cubit/player_1/cubit/player_1_cubit.dart';
import 'package:sketoo/cubit/player_2/cubit/player_2_cubit.dart';
import 'package:sketoo/ui/screen/gameplay/conclusion.dart';
import 'package:sketoo/ui/screen/gameplay/widget/dialog_share.dart';
import 'package:sketoo/utils/assets.dart';
import 'package:sketoo/utils/typograhpy.dart';
import 'dart:ui' as ui;

class ShareScreen extends StatefulWidget {
  static const routename = "/share_screen";
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey previewContainer = GlobalKey();
  bool hasClickPop = false;

  Future<int> countFilesInCache() async {
    try {
      Directory cacheDir = await getTemporaryDirectory();

      List<FileSystemEntity> fileList = cacheDir.listSync();

      int fileCount = 0;
      for (FileSystemEntity file in fileList) {
        if (file is File) {
          fileCount++;
        }
      }
      return fileCount;
    } catch (e) {
      print('Error counting files in cache: $e');
      return -1;
    }
  }

  Future<void> takeScreenShot() async {
    final boundary = previewContainer.currentContext!.findRenderObject()
        as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();
    final imgFile = File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes!);

    Share.shareXFiles([XFile('$directory/screenshot.png')]);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    ScreenshotController screenshotController = ScreenshotController();
    bool isBadakMenang = false;
    bool isGajahMenang = false;

    void isWinner() {
      Map<String, int> hewanPoin1 = {
        "kelinci": 30,
        "monyet": 55,
        "gajah": 95,
      };
      Map<String, int> hewanPoin2 = {
        "kelinci": 30,
        "monyet": 55,
        "badak": 95,
      };
      List<String> pasukanPlayer1 =
          context.read<Player_1Cubit>().state.pasukanHewan;
      List<String> pasukanPlayer2 =
          context.read<Player_2Cubit>().state.pasukanHewan;
      int totalPoin1 = 0;
      int totalPoin2 = 0;
      for (String hewan in pasukanPlayer1) {
        totalPoin1 += hewanPoin1[hewan]!;
      }
      for (String hewan in pasukanPlayer2) {
        totalPoin2 += hewanPoin2[hewan]!;
      }

      if (totalPoin1 > totalPoin2) {
        setState(() {
          isGajahMenang = true;
          isBadakMenang = false;
        });
      } else if (totalPoin1 < totalPoin2) {
        setState(() {
          isGajahMenang = false;
          isBadakMenang = true;
        });
      } else {
        setState(() {
          isBadakMenang = false;
          isBadakMenang = false;
        });
      }
    }

    @override
    void initState() {
      super.initState();
      isWinner();
    }

    return RepaintBoundary(
      key: previewContainer,
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          setState(() {
            hasClickPop = !hasClickPop;
          });
        },
        child: Scaffold(
          body: Screenshot(
            controller: screenshotController,
            child: Stack(
              children: [
                screenHeight < 750
                    ? SizedBox(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imgBackgroundResult),
                                fit: BoxFit.cover),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      BlocBuilder<Player_2Cubit, Player_2State>(
                                        builder: (context, state) {
                                          return FutureBuilder<int>(
                                            future: countFilesInCache(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                int fileCount =
                                                    snapshot.data ?? 0;
                                                if (fileCount > 7) {
                                                  return SizedBox(
                                                    height: 260,
                                                    child: GridView.builder(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 3 / 2,
                                                        mainAxisSpacing: 20,
                                                        crossAxisSpacing: 20,
                                                      ),
                                                      itemCount: state
                                                          .pathImages.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        String imagePath = state
                                                            .pathImages[index];
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          child: RotatedBox(
                                                            quarterTurns: 2,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          22),
                                                              child: Image.file(
                                                                File(imagePath),
                                                                height: 300,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  // Jika jumlah file bukan 8, tidak menampilkan apa pun
                                                  return const SizedBox();
                                                }
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      RotatedBox(
                                        quarterTurns: 2,
                                        child: Text(
                                          "Sketoo",
                                          style: monstersYellow30,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(height: 30),
                                          BlocBuilder<Player_1Cubit,
                                              Player_1State>(
                                            builder: (context, state) {
                                              return Text(
                                                state.nama,
                                                style: poppinsBlack16,
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              takeScreenShot();
                                            },
                                            child: Image.asset(imgShareButton),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    Conclusion.routename);
                                              },
                                              child:
                                                  Image.asset(imgNextButton)),
                                        ],
                                      ),
                                      RotatedBox(
                                        quarterTurns: 2,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 30),
                                            BlocBuilder<Player_2Cubit,
                                                Player_2State>(
                                              builder: (context, state) {
                                                return Text(
                                                  state.nama,
                                                  style: poppinsBlack16,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      BlocBuilder<Player_1Cubit, Player_1State>(
                                        builder: (context, state) {
                                          return FutureBuilder<int>(
                                            future: countFilesInCache(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                int fileCount =
                                                    snapshot.data ?? 0;
                                                if (fileCount > 7) {
                                                  return SizedBox(
                                                    height: 260,
                                                    child: GridView.builder(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 3 / 2,
                                                        mainAxisSpacing: 20,
                                                        crossAxisSpacing: 20,
                                                      ),
                                                      itemCount: state
                                                          .pathImages.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        String imagePath = state
                                                            .pathImages[index];
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22),
                                                            child: Image.file(
                                                              File(imagePath),
                                                              height: 300,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      Text(
                                        "Sketoo",
                                        style: monstersYellow30,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: RotatedBox(
                                    quarterTurns: 2,
                                    child: DialogShare(
                                        namaHewan: 'badak',
                                        isMenang: isBadakMenang)),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: DialogShare(
                                      namaHewan: 'gajah',
                                      isMenang: isGajahMenang)),
                            ],
                          ),
                        ),
                      )
                    // layar diatas 750
                    : Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(imgBackgroundResult),
                              fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    BlocBuilder<Player_2Cubit, Player_2State>(
                                      builder: (context, state) {
                                        return FutureBuilder<int>(
                                          future: countFilesInCache(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              int fileCount =
                                                  snapshot.data ?? 0;
                                              if (fileCount > 7) {
                                                return SizedBox(
                                                  height: 220,
                                                  child: GridView.builder(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 3 / 2,
                                                      mainAxisSpacing: 20,
                                                      crossAxisSpacing: 20,
                                                    ),
                                                    itemCount:
                                                        state.pathImages.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      String imagePath = state
                                                          .pathImages[index];
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(22),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(22),
                                                          child: RotatedBox(
                                                            quarterTurns: 2,
                                                            child: Image.file(
                                                              File(imagePath),
                                                              height: 300,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            }
                                          },
                                        );
                                      },
                                    ),
                                    RotatedBox(
                                      quarterTurns: 2,
                                      child: Text(
                                        "Sketoo",
                                        style: monstersYellow30,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(height: 30),
                                        BlocBuilder<Player_1Cubit,
                                            Player_1State>(
                                          builder: (context, state) {
                                            return Text(
                                              state.nama,
                                              style: poppinsBlack16,
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            takeScreenShot();
                                          },
                                          child: Image.asset(imgShareButton),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  Conclusion.routename);
                                            },
                                            child: Image.asset(imgNextButton)),
                                      ],
                                    ),
                                    RotatedBox(
                                      quarterTurns: 2,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 30),
                                          BlocBuilder<Player_2Cubit,
                                              Player_2State>(
                                            builder: (context, state) {
                                              return Text(
                                                state.nama,
                                                style: poppinsBlack16,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    BlocBuilder<Player_1Cubit, Player_1State>(
                                      builder: (context, state) {
                                        return FutureBuilder<int>(
                                          future: countFilesInCache(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              int fileCount =
                                                  snapshot.data ?? 0;
                                              if (fileCount > 7) {
                                                return SizedBox(
                                                  height: 220,
                                                  child: GridView.builder(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 3 / 2,
                                                      mainAxisSpacing: 20,
                                                      crossAxisSpacing: 20,
                                                    ),
                                                    itemCount:
                                                        state.pathImages.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      String imagePath = state
                                                          .pathImages[index];
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(22),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(22),
                                                          child: Image.file(
                                                            File(imagePath),
                                                            height: 300,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            }
                                          },
                                        );
                                      },
                                    ),
                                    Text(
                                      "Sketoo",
                                      style: monstersYellow30,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: RotatedBox(
                                  quarterTurns: 2,
                                  child: DialogShare(
                                      namaHewan: 'badak',
                                      isMenang: isBadakMenang)),
                            ),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: DialogShare(
                                    namaHewan: 'gajah',
                                    isMenang: isGajahMenang)),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
