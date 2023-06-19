import 'package:flutist/controllers/player_controller.dart';
import 'package:flutist/utils/colors.dart';
import 'package:flutist/utils/styles.dart';
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
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
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
                        snapshot.data![index].displayName,
                        style: AppStyles.textStyle(
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data![index].artist!,
                        style: AppStyles.textStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: Obx(
                        () => IconButton(
                          onPressed: () {
                            controller.isPlaying.value
                                ? controller.pauseMusic(
                                    index: index,
                                  )
                                : controller.playMusic(
                                    path: snapshot.data![index].uri,
                                    playIndex: index,
                                  );
                          },
                          icon: Icon(
                            controller.currentPlayIndex.value == index &&
                                    controller.isPlaying.value
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: AppColors.whiteColor,
                            size: 26,
                          ),
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
