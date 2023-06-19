import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkPermission();
  }

  // check permission
  checkPermission() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      return audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL,
      );
    } else{
      checkPermission();
    }
  }
  // check permission end
}
