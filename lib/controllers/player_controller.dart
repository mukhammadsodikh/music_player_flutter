import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var playIndex = 0.obs;
  var isPlaying = false.obs;

  var value = 0.0.obs;
  var max = 0.0.obs;
  var duration = ''.obs;
  var position = ''.obs;



  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  changeDurationToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }


  void playSong(String? uri, index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(uri!)),
      );
      audioPlayer.play();
      isPlaying.value = true;
      updatePosition();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> play(int index) async {
    final songs = await audioQuery.querySongs();
    if (songs.isNotEmpty && index >= 0 && index < songs.length) {
      final song = songs[index];
      playSong(song.uri, index);
    }
  }

  void checkPermission() async {
    print('worked');
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        print("Successfully granted");
      } else {
        print("Not granted");
      }
    } else {
      print("Already granted");
    }
  }
}
