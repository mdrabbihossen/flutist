import 'package:flutist/controllers/player_controller.dart';
import 'package:flutist/utils/colors.dart';
import 'package:flutist/utils/styles.dart';
import 'package:flutist/views/player/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgDarkColor,
        leading: const Icon(
          Icons.sort_rounded,
          color: AppColors.whiteColor,
        ),
        title: Text(
          "Flutist",
          style: AppStyles.textStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (context, snapshot) {
          debugPrint("snapshot: ${snapshot.data}");
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No songs found",
                style: AppStyles.textStyle(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final musicData = snapshot.data![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      onTap: () {
                        controller.isPlaying.value
                            ? controller.pauseMusic(
                                index: index,
                              )
                            : controller.playMusic(
                                path: musicData.uri,
                                playIndex: index,
                              );
                        Get.to(
                          () => PlayerScreen(
                            songData: snapshot.data![index],
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: AppColors.bgColor,
                      leading: QueryArtworkWidget(
                        id: snapshot.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(
                          Icons.music_note,
                          color: AppColors.whiteColor,
                          size: 32,
                        ),
                      ),
                      title: Text(
                        musicData.displayNameWOExt,
                        style: AppStyles.textStyle(
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        musicData.artist!,
                        style: AppStyles.textStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: Obx(
                        () => Icon(
                          controller.currentPlayIndex.value == index &&
                                  controller.isPlaying.value
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: AppColors.whiteColor,
                          size: 26,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
