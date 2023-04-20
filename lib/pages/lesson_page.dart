import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quran_app/data/list_lessons_data.dart';
import 'package:quran_app/ui/colors.dart';
import 'package:quran_app/widgets/custom_appbar.dart';

class LessonPage extends StatefulWidget {
  final int index;
  const LessonPage({required this.index, super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  IconData btnIcon = Icons.play_arrow_rounded;

  @override
  void initState() {
    super.initState();

    // Listen to states: playing, paused, stoped
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    // Listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // Listen to audio duration
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mainPosition = position.inSeconds.toDouble();
    // End music
    endMusic();

    return Scaffold(
      appBar: CustomAppbar(index: widget.index, audioPlayer: audioPlayer),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20.0,
                right: 20.0,
                bottom: 150.0,
              ),
              child: listLessons[widget.index]['pageNumber'] == '۱۰'
                  ? Column(
                      children: [
                        CustomQuranText(
                          index: widget.index,
                          ayatListName: 'ayat',
                          ayatNumberListName: 'ayatNumber',
                        ),
                        CustomQuranText(
                          index: widget.index,
                          ayatListName: 'ayatAlrahman',
                          ayatNumberListName: 'ayatNumberAlrahman',
                        ),
                      ],
                    )
                  : CustomQuranText(
                      index: widget.index,
                      ayatListName: 'ayat',
                      ayatNumberListName: 'ayatNumber',
                    ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 95.0,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -15),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 60.0),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Slider.adaptive(
                        activeColor: primaryColor,
                        inactiveColor: Colors.grey.shade300,
                        min: 0.0,
                        max: duration.inSeconds.toDouble(),
                        value: mainPosition,
                        onChanged: (value) async {
                          final position = Duration(seconds: value.toInt());
                          await audioPlayer.seek(position);

                          // Optional: play audio if was paused
                          if (isPlaying) {
                            await audioPlayer.resume();
                            setState(() {
                              btnIcon = Icons.pause_rounded;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 33.0,
                      bottom: 12.0,
                      right: 33.0,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatTime(duration),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            formatTime(position),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final position =
                                  Duration(seconds: mainPosition.toInt() + 10);
                              await audioPlayer.seek(position);
                            },
                            icon: const Icon(
                              Icons.forward_10_rounded,
                              size: 35.0,
                              color: Color(0xFFADADAD),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 12.0),
                            child: InkWell(
                              onTap: () async {
                                // Checking Net
                                bool result = await InternetConnectionChecker()
                                    .hasConnection;
                                if (result) {
                                  // await playMusic();
                                  playMusic();
                                } else {
                                  Fluttertoast.showToast(
                                    msg:
                                        'برای پخش صوت اتصال به اینترنت نیاز است!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.grey.shade700,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                              child: Container(
                                width: 52.0,
                                height: 52.0,
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(btnIcon,
                                    size: 38.0, color: Colors.white),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final position =
                                  Duration(seconds: mainPosition.toInt() - 10);
                              await audioPlayer.seek(position);
                            },
                            icon: const Icon(
                              Icons.replay_10_rounded,
                              size: 35.0,
                              color: Color(0xFFADADAD),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Play Music
  Future<void> playMusic() async {
    if (isPlaying) {
      await audioPlayer.pause();
      setState(() {
        btnIcon = Icons.play_arrow_rounded;
      });
    } else {
      // Play from Url
      await audioPlayer.play(listLessons[widget.index]['url']);
      // print(NetworkSe);
      setState(() {
        btnIcon = Icons.pause_rounded;
      });
    }
  }

  // Format Time
  String formatTime(Duration duration) {
    int time = duration.inSeconds.toInt();
    int m = time % 60;
    int s = time ~/ 60;
    String result = m < 10 ? '$s:0$m' : '$s:$m';
    return result;
  }

  // End Music
  void endMusic() {
    if (isPlaying &&
        position.inSeconds > 0 &&
        position.inSeconds == duration.inSeconds) {
      setState(() {
        btnIcon = Icons.replay;
      });
    } else if (isPlaying) {
      setState(() {
        btnIcon = Icons.pause_rounded;
      });
    }
  }
}

class Besmellah extends StatelessWidget {
  const Besmellah({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Text(
        'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
        style: TextStyle(
          fontFamily: 'QuranTaha',
          fontSize: 24.0,
          color: Color(0xFF3B3B3B),
        ),
      ),
    );
  }
}

class CustomQuranText extends StatelessWidget {
  const CustomQuranText({
    Key? key,
    required this.index,
    required this.ayatListName,
    required this.ayatNumberListName,
  }) : super(key: key);

  final int index;
  final String ayatListName;
  final String ayatNumberListName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Besmellah(),
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            children: [
              for (int i = 0; i < listLessons[index][ayatListName].length; i++)
                TextSpan(
                  text: listLessons[index][ayatListName][i],
                  style: const TextStyle(
                    fontFamily: 'QuranTaha',
                    fontSize: 24.0,
                    color: Color(0xFF3B3B3B),
                  ),
                  children: [
                    const TextSpan(
                      text: ' ﴿',
                      style: TextStyle(
                        fontFamily: 'msuighur',
                        fontSize: 35.0,
                        color: primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: listLessons[index][ayatNumberListName][i],
                      style: const TextStyle(
                        fontFamily: 'QuranTaha',
                        fontSize: 26.0,
                        color: Color(0xFF3B3B3B),
                      ),
                    ),
                    const TextSpan(
                      text: '﴾ ',
                      style: TextStyle(
                        fontFamily: 'msuighur',
                        fontSize: 35.0,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
