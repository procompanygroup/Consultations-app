import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'video_player_fullscreen_widget.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key, required this.videoPath});
  final String videoPath;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = VideoPlayerController.networkUrl(
      Uri.parse(
        // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        widget.videoPath,
      ),)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((_) => controller.play());

    // setLandscape();
    // await WakelockPlus.disable();
     WakelockPlus.disable();

  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller.dispose();
    // setAllOrientations();
    // await WakelockPlus.disable();
     WakelockPlus.disable();
    super.dispose();
  }

  /*
  Future setLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

   await WakelockPlus.enable();
  }

  Future setAllOrientations () async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await WakelockPlus.disable();
  }
  */

  @override
  Widget build(BuildContext context) {
    return VideoPlayerFullscreenWidget(controller:controller );
  }
}
