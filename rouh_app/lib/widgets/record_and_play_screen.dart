import 'package:flutter/material.dart';

import 'dart:io';
import 'package:audioplayers/audioplayers.dart' as audioplayers;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../mystyle/constantsColors.dart';

class RecordAndPlayScreen extends StatefulWidget {
  const RecordAndPlayScreen({Key? key}) : super(key: key);

  @override
  State<RecordAndPlayScreen> createState() => _RecordAndPlayScreenState();
}

class _RecordAndPlayScreenState extends State<RecordAndPlayScreen> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  final audioPlayer = audioplayers.AudioPlayer();
  bool isPlaying = false;
  bool isPlayerLoad = false;
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
    await recorder.startRecorder(toFile: 'audio_$audioCounter');

  }

  Future stopRecord() async {
    if (!isRecorderReady) return;

    final path = await recorder.stopRecorder();
    final audioFile = File(path!);

    print('Record audio: $audioFile');
    await setAudio(audioFile);
    isPlayerLoad = true;

  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
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
      });
    });

    //setAudio();

    /// Listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        print('newDuration: $newDuration');
        duration = newDuration;
      });
    });

    /// Listen to audio position
    // audioPlayer.onAudioPositionChanged.listen((newPosition) {
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        print('newPosition: $newPosition');
        position = newPosition;
      });
    });
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();

    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future setAudio(File audioFile) async {
    // Repeat song when completed
    //audioPlayer.setReleaseMode(audioplayers.ReleaseMode.LOOP);
    // audioPlayer.setUrl(audioFile.path, isLocal: true);
    audioPlayer.setSourceUrl(audioFile.path);
    print('audioPlayer setUrl');

    // }
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    // audioPlayer.dispose();
    // audioRecord.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text("Record And Play Screen"),
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius:
            //BorderRadius.circular(15),
            BorderRadius.all(Radius.circular(75.0)),
            child: Container(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: Icon(
                                  recorder.isRecording ? Icons.stop : Icons.mic,
                                  color: myprimercolor,
                                ),
                                iconSize: 35,
                                onPressed: () async {
                                  if (recorder.isRecording) {
                                    await stopRecord();
                                  } else {
                                    await startRecord();
                                  }
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: myprimercolor,
                                    inactiveTrackColor: Colors.white,
                                    trackShape: RectangularSliderTrackShape(),
                                    trackHeight: 4.0,
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
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: myprimercolor,
                                ),
                                iconSize: 35,
                                onPressed: () async {
                                  if (!isPlayerLoad || recorder.isRecording )
                                  {
                                    // await stopRecord();
                                    return;
                                  }
                                  if (isPlaying) {
                                    await audioPlayer.pause();
                                  } else {
                                    // String url = '';
                                    // await audioPlayer.play(url);
                                    await audioPlayer.resume();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: recorder.isRecording
                              ? StreamBuilder<RecordingDisposition>(
                            stream: recorder.onProgress,
                            builder: (context, snapshot) {
                              final duration = snapshot.hasData
                                  ? snapshot.data!.duration
                                  : Duration.zero;
                              String twoDigits(int n) =>
                                  n.toString().padLeft(2, '0');
                              final twoDigitMinutes = twoDigits(
                                  duration.inMinutes.remainder(60));
                              final twoDigitSeconds = twoDigits(
                                  duration.inSeconds.remainder(60));
                              return Text(
                                '$twoDigitMinutes:$twoDigitSeconds',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          )
                              : Text(formatTime(duration - position),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
