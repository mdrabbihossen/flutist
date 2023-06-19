import 'package:flutist/controllers/player_controller.dart';
import 'package:flutist/utils/colors.dart';
import 'package:flutist/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final List<SongModel> songData;

  const PlayerScreen({
    Key? key,
    required this.songData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  height: 300,
                  width: 300,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(),
                  child: QueryArtworkWidget(
                    id: songData[controller.currentPlayIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkFit: BoxFit.contain,
                    artworkQuality: FilterQuality.high,
                    quality: 100,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: const CircleAvatar(
                      radius: 500,
                      child: Icon(
                        Icons.music_note,
                        size: 48,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    )),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        songData[controller.currentPlayIndex.value]
                            .displayNameWOExt,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyle(
                          color: AppColors.bgDarkColor,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        songData[controller.currentPlayIndex.value]
                            .artist
                            .toString(),
                        style: AppStyles.textStyle(
                          color: AppColors.bgDarkColor,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.positions.value,
                              style: AppStyles.textStyle(
                                color: AppColors.bgDarkColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: AppColors.sliderColor,
                                activeColor: AppColors.sliderColor,
                                inactiveColor: AppColors.bgColor,
                                value: controller.songValue.value,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: controller.maxDuration.value,
                                onChanged: (value) {
                                  controller.durationToSeconds(value.toInt());
                                  value = value;
                                },
                              ),
                            ),
                            Text(
                              controller.durations.value,
                              style: AppStyles.textStyle(
                                color: AppColors.bgDarkColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.skipPrevious();
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              size: 40,
                              color: AppColors.bgDarkColor,
                            ),
                          ),
                          Obx(
                            () => CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColors.bgColor,
                              child: Transform.scale(
                                scale: 2.5,
                                child: IconButton(
                                  onPressed: () {
                                    if (controller.isPlaying.value) {
                                      controller.audioPlayer.pause();
                                      controller.isPlaying.value = false;
                                    } else {
                                      controller.audioPlayer.play();
                                      controller.isPlaying.value = true;
                                    }
                                  },
                                  icon: controller.isPlaying.value
                                      ? const Icon(
                                          Icons.pause_rounded,
                                          color: AppColors.whiteColor,
                                        )
                                      : const Icon(
                                          Icons.play_arrow_rounded,
                                          color: AppColors.whiteColor,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.skipNext();
                            },
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              size: 40,
                              color: AppColors.bgDarkColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
