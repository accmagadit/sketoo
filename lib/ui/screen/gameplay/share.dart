
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sketoo/ui/screen/gameplay/conclusion.dart';
import 'package:sketoo/ui/screen/gameplay/widget/dialog_share.dart';
import 'package:sketoo/utils/assets.dart';
import 'package:sketoo/utils/typograhpy.dart';

class ShareScreen extends StatelessWidget {
  static const routename = "/share_screen";
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgBackgroundGameplay), fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: 2,
                            child: SizedBox(
                              height: 300,
                              child: GridView.count(
                                padding: EdgeInsets.all(0),
                                childAspectRatio: 3 / 2,
                                mainAxisSpacing: 20,
                                crossAxisCount: 2,
                                children: <Widget>[
                                  Image.asset(
                                    imgShareResult,
                                  ),
                                  Image.asset(
                                    imgShareResult,
                                  ),
                                  Image.asset(
                                    imgShareResult,
                                  ),
                                  Image.asset(
                                    imgShareResult,
                                  ),
                                ],
                              ),
                            ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                "Gopal",
                                style: poppinsBlack16,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Share.share(
                                        'check out my website https://example.com',
                                        subject: "share");
                                  },
                                  child: Image.asset(imgShareButton)),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Conclusion.routename);
                                  },
                                  child: Image.asset(imgNextButton)),
                            ],
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: Column(
                              children: [
                                const SizedBox(height: 30),
                                Text(
                                  "Dinho",
                                  style: poppinsBlack16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 300,
                            child: GridView.count(
                              padding: EdgeInsets.all(0),
                              childAspectRatio: 3 / 2,
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              children: <Widget>[
                                Image.asset(
                                  imgShareResult,
                                ),
                                Image.asset(
                                  imgShareResult,
                                ),
                                Image.asset(
                                  imgShareResult,
                                ),
                                Image.asset(
                                  imgShareResult,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Sketoo",
                            style: monstersYellow30,
                          )
                        ],
                      ),
                    ],
                  ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: RotatedBox(
                        quarterTurns: 2,
                        child: DialogShare(namaHewan: 'badak', isMenang: false)),
                  ),
                  const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: DialogShare(namaHewan: 'gajah', isMenang: true)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
