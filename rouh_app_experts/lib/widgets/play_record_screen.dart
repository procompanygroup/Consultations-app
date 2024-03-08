import 'package:flutter/material.dart';

import 'dart:io';
import 'package:audioplayers/audioplayers.dart' as audioplayers;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../mystyle/constantsColors.dart';

class PlayRecordScreen extends StatefulWidget {
  const PlayRecordScreen({Key? key, required this.audioUrl}) : super(key: key);
  final String audioUrl;

  @override
  State<PlayRecordScreen> createState() => _PlayRecordScreenState();
}

class _PlayRecordScreenState extends State<PlayRecordScreen> {
  bool isRecorderReady = false;

  final audioPlayer = audioplayers.AudioPlayer();
  bool isPlaying = false;
  bool isPlayerLoad = false;
  String audioPlayerState = "";
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  int audioCounter = 0;
  Future startRecord() async {
    if (!isRecorderReady) return;
    isPlayerLoad = false;
    setState(() {
      position = Duration.zero;
      duration = Duration.zero;
    });
    audioCounter++;

  }
  late File audioFile;
  Future stopRecord() async {

    audioFile = await DefaultCacheManager().getSingleFile(widget.audioUrl);

    print('Record audio: $audioFile');
    await setAudio(audioFile);
    setState(() {
      isPlayerLoad = true;

    });
  }



  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
  @override
  void dispose() {
    audioPlayer.dispose();
    // audioRecord.dispose();

    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    // audioPlayer = AudioPlayer();
    // audioRecord = Record();
    // TODO: implement initState
    super.initState();

    initRecorder();

    // Listen To State: playing, paused, stopped
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        // isPlaying = state == audioplayers.PlayerState.PLAYING;
        isPlaying = state == audioplayers.PlayerState.playing;
        // print(state.name);
        audioPlayerState = state.name;
      });
    });

    //setAudio();

    /// Listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        // print('newDuration: $newDuration');
        duration = newDuration;
      });
    });

    /// Listen to audio position
    // audioPlayer.onAudioPositionChanged.listen((newPosition) {
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        // print('newPosition: $newPosition');
        position = newPosition;
      });
    });


    /// Listen to audio Complete
    // audioPlayer.onPlayerComplete.listen((event) {
    //   //Here goes the code that will be called when the audio finishes
    //   // onComplete();
    //   setState(() {
    //     position =Duration.zero;
    //   });
    // });

    stopRecord();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }


    isRecorderReady = true;

  }



  loadAgain() async{

    // setState(() {
    //   position =Duration.zero;
    // });
    //

    print('Record audio: $audioFile');
    await setAudio(audioFile);
    await audioPlayer.resume();

  }

  Future setAudio(File audioFile) async {

    //audioPlayer.setSource(audioFile.path, isLocal: true);
    await audioPlayer.setPlayerMode(audioplayers.PlayerMode.mediaPlayer);
    await audioPlayer.setSourceUrl(audioFile.path);
    // await audioPlayer.resume();
    print('audioPlayer setUrl');

    // }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // return Scaffold(
    //   backgroundColor: Colors.grey.shade900,
    // appBar: AppBar(
    //   title: Text("Record And Play Screen"),
    // ),
    // body:
    return ClipRRect(
          borderRadius:
          //BorderRadius.circular(15),
          BorderRadius.all(Radius.circular(75.0)),
          child: Container(
              height: 45,
              color: Color(0xffD6D6D6),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Stack(
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child:  Padding(
                        padding:  EdgeInsetsDirectional.only(start: 20, end: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: myprimercolor,
                                    inactiveTrackColor: Colors.white,
                                    trackShape: RectangularSliderTrackShape(),
                                    trackHeight: 5.0,
                                    thumbColor: myprimercolor,
                                    thumbShape: RoundSliderThumbShape(
                                      //enabledThumbRadius: 12.0),
                                        enabledThumbRadius: 0.0),
                                    overlayColor: Colors.red.withAlpha(32),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 28.0),
                                  ),
                                  child: Slider(
                                    min: 0,
                                    max: duration.inSeconds.toDouble(),
                                    value: position.inSeconds.toDouble(),
                                    onChanged: (value) async {
                                      final position =
                                      Duration(seconds: value.toInt());
                                      await audioPlayer.seek(position);

                                      /// Optional: Play audio if was paused
                                      await audioPlayer.resume();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      start: 0,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: 10),
                          // child: Text(formatTime(duration - position),
                          child:    Text(formatTime(position),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      end: 0,
                      child:
                        !isPlayerLoad?
                        Container(
                          child:Center(child: CircularProgressIndicator()),
                        ):
                        GestureDetector(
                          onTap: () async {

                            if (!isPlayerLoad  )
                            {
                              // await stopRecord();
                              return;
                            }
                            if(audioPlayerState == "playing") {
                              await audioPlayer.pause();
                            }else if(audioPlayerState == "completed")
                            {
                              // String url = '';
                              // await audioPlayer.play(url);
                              await loadAgain();
                            } else
                            {
                              // paused
                              await audioPlayer.resume();
                            }

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150),
                                  color: Colors.grey.shade50),
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 25,
                                color: myprimercolor,
                              ),
                            ),
                          ),
                        ),

                    )
                  ],
                ),
              )),
        );
  }
}
