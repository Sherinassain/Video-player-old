// ignore_for_file: prefer_const_constructors


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/features/profile/profile_page.dart';
import '../../styles/colors.dart';
import '../../styles/textstyles.dart';
import '../../widgets/app_bar.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class VideoPlayers extends StatefulWidget {
  const VideoPlayers({Key? key}) : super(key: key);

  @override
  State<VideoPlayers> createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers> {
  late VideoPlayerController controller;
  bool isMusicOn = true;
  FToast? fToast;

  showCustomToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: imageColor,
      ),
      child:  Text(
        "Video Downloaded Successfully",
        style: titleTextStyle,
      ),
    );

    fToast?.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
    );
  }

  Future<void> downloadVideo() async {
    final appDocDirectory = await getAppDocDirectory();

    final finalVideoPath = join(
      appDocDirectory.path,
      'Video-${DateTime
          .now()
          .millisecondsSinceEpoch}.mp4',
    );

    final dio = Dio();

    await dio.download(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      finalVideoPath,
      onReceiveProgress: (actualBytes, totalBytes) {
        final percentage = actualBytes / totalBytes * 100;
      },
    );

    await saveDownloadedVideoToGallery(videoPath: finalVideoPath);
    await removeDownloadedVideo(videoPath: finalVideoPath);
  }

  Future<Directory> getAppDocDirectory() async {
    if (Platform.isIOS) {
      return getApplicationDocumentsDirectory();
    }

    return (await getExternalStorageDirectory())!;
  }

  Future<void> saveDownloadedVideoToGallery({required String videoPath}) async {
    await ImageGallerySaver.saveFile(videoPath);
    showCustomToast();
  }

  Future<void> removeDownloadedVideo({required String videoPath}) async {
    try {
      Directory(videoPath).deleteSync(recursive: true);
    } catch (error) {
      debugPrint('$error');
    }
  }


  @override
  void initState() {
    secureScreen();
    loadVideoPlayer();
    fToast = FToast();
    super.initState();
  }

  Future<void> secureScreen() async {
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  

  @override
  Widget build(BuildContext context) {
    fToast?.init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: backGroundColor,
      appBar: defaultAppBar(context, ()=> Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      )),
      body: Column(children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
            const ClosedCaption(text: ''),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 11, 37),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: VideoProgressIndicator(controller,
                          allowScrubbing: true,
                          padding: const EdgeInsets.only(right: 8, left: 40),
                          colors: const VideoProgressColors(
                            backgroundColor: blackColor,
                            playedColor: greenColor,
                            bufferedColor: blackColor,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          controller.value.position.toString().substring(5, 10),
                          style: durationTextStyle,
                        ),
                        Text(
                          '/',
                          style: durationTextStyle,
                        ),
                        Text(
                          controller.value.duration.toString().substring(5, 10),
                          style: durationTextStyle,
                        ),
                      ],
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -5),
                      child: InkWell(
                        child: Icon(
                          controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: whiteColor,
                          size: 46,
                        ),
                        onTap: () {
                          if (controller.value.isPlaying) {
                            controller.pause();
                          } else {
                            controller.play();
                          }

                          setState(() {});
                        },
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.fast_rewind,
                        size: 18,
                        color: whiteColor,
                      ),
                      onTap: () async {
                        await controller.seekTo(Duration(
                            seconds: controller.value.position.inSeconds - 5));
                      },
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      child: const Icon(
                        Icons.fast_forward,
                        size: 18,
                        color: whiteColor,
                      ),
                      onTap: () async {
                        await controller.seekTo(Duration(
                            seconds: controller.value.position.inSeconds + 5));
                      },
                    ),
                    const SizedBox(width: 14),
                    GestureDetector(
                      child: Icon(
                        isMusicOn == true ? Icons.volume_up : Icons.volume_off,
                        size: 18,
                        color: whiteColor,
                      ),
                      onTap: () async {
                        setState(() {
                          isMusicOn == false
                              ? controller.setVolume(1.0)
                              : controller.setVolume(0.0);
                          isMusicOn = !isMusicOn;
                        });
                      },
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(-9, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.settings,
                        size: 18,
                        color: whiteColor,
                      ),
                      SizedBox(width: 15),
                      Icon(
                        Icons.fullscreen,
                        size: 21,
                        color: whiteColor,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      child: Icon(
                        Icons.keyboard_arrow_left_outlined,
                        size: 28,
                        color: blackColor,
                      ),
                      onTap: () {
                        // controller.previousPage();
                      },
                    )),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    downloadVideo();
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: greenColor,
                    size: 28,
                  ),
                  label: Text('Download ', style: titleTextStyle),
                ),
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 28,
                        color: blackColor,
                      ),
                      onTap: () {
                        // controller.nextPage();
                      },
                    )),
              ],
            )),
      ]),
    ));
  }
}
