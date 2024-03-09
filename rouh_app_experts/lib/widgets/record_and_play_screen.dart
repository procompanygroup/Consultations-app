import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import 'package:audioplayers/audioplayers.dart' as audioplayers;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../mystyle/constantsColors.dart';
// import '../bloc/audio_file/audio_file_cubit.dart';

class RecordAndPlayScreen extends StatefulWidget {
  const RecordAndPlayScreen({Key? key}) : super(key: key);
// final int RecordInputServiceId;
  @override
  State<RecordAndPlayScreen> createState() => _RecordAndPlayScreenState();
}

class _RecordAndPlayScreenState extends State<RecordAndPlayScreen> {
  final recorder = FlutterSoundRecorder();
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
    await recorder.startRecorder(toFile: 'audio_$audioCounter');

  }
  late File audioFile;
  Future stopRecord() async {
    if (!isRecorderReady) return;

    final path = await recorder.stopRecorder();
    audioFile = File(path!);

    print('Record audio: $audioFile');
    await setAudio(audioFile);
    isPlayerLoad = true;

  }

  loadAgain() async{

    // String url = '';
    // await audioPlayer.play(url);

    print('Record audio: $audioFile');
    await setAudio(audioFile);
    await audioPlayer.resume();

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
    //
    //   });
    // });
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

    //audioPlayer.setSource(audioFile.path, isLocal: true);
    await audioPlayer.setPlayerMode(audioplayers.PlayerMode.mediaPlayer);
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
    double screenWidth = MediaQuery.of(context).size.width;

    // return Scaffold(
    //   backgroundColor: Colors.grey.shade900,
      // appBar: AppBar(
      //   title: Text("Record And Play Screen"),
      // ),
      // body:
      return Column(
        children: [
          ClipRRect(
            borderRadius:
            //BorderRadius.circular(15),
            BorderRadius.all(Radius.circular(75.0)),
            child: Container(
               height: 55,
                color: Color(0xffD6D6D6),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Stack(
                    children: [
                      Container(
                        width: screenWidth - 10,
                        child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(1),
                                    backgroundColor:
                                    Colors.grey.shade50, // <-- Button color
                                  ),
                                  onPressed: () async {
                                    if (recorder.isRecording) {
                                      await stopRecord();
                                    } else {
                                      await startRecord();
                                    }
                                    setState(() {});
                                  },
                                  child: Icon(
                                    recorder.isRecording ? Icons.stop : Icons
                                        .mic,
                                    size: 30,
                                    color: myprimercolor,
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
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(1),
                                    backgroundColor:
                                    Colors.grey.shade50, // <-- Button color
                                  ),
                                  onPressed: () async {
                                    if (!isPlayerLoad || recorder.isRecording) {
                                      // await stopRecord();
                                      return;
                                    }
                                    if (audioPlayerState == "playing") {
                                      await audioPlayer.pause();
                                    } else
                                    if (audioPlayerState == "completed") {
                                      // String url = '';
                                      // await audioPlayer.play(url);
                                      await loadAgain();
                                    } else {
                                      // paused
                                      await audioPlayer.resume();
                                    }
                                  },
                                  child: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                    size: 30,
                                    color: myprimercolor,
                                  ),
                                ),
                              ],
                            ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
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
                )),
          ),
        ],
      );
    // );
  }
}
