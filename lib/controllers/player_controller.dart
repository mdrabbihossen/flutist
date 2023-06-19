import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  RxInt currentPlayIndex = 0.obs;
  RxBool isPlaying = false.obs;
  RxString durations = "".obs;
  RxString positions = "".obs;
  RxDouble maxDuration = 0.0.obs;
  RxDouble songValue = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkPermission();
  }

  // update position
  updatePosition() async {
    // for the duration
    audioPlayer.durationStream.listen((duration) {
      durations.value = duration.toString().split(".")[0];
      maxDuration.value = duration!.inSeconds.toDouble();
    });
    // for the position
    audioPlayer.positionStream.listen((position) {
      positions.value = position.toString().split(".")[0];
      songValue.value = position.inSeconds.toDouble();
    });
  }

  // check permission
  checkPermission() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
    } else {
      checkPermission();
    }
  }

// check permission end
// play music
  playMusic({String? path, int? playIndex}) async {
    currentPlayIndex.value = playIndex!;

    try {
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(path!),
        ),
      );
      audioPlayer.play();
      isPlaying.value = true;
      updatePosition();
    } on Exception catch (e) {
      debugPrint("error: $e");
    }
  }

// play music end
// pause music
  pauseMusic({int? index}) async {
    currentPlayIndex.value = index!;
    isPlaying.value = false;
    try {
      await audioPlayer.pause();
      isPlaying.value = false;
    } on Exception catch (e) {
      debugPrint("error: $e");
    }
  }

// pause music end

  // duration to seconds
  durationToSeconds(seconds) async {
    Duration duration = Duration(seconds: seconds.inSeconds);
    audioPlayer.seek(duration);
  }
}
