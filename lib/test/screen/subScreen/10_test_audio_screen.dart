import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ub_flutter/utils/layout/default_layout.dart';

import '../../../utils/data.dart';
import '../../../utils/log/log.dart';
import '../../../utils/view/audio/audio.dart';
import '../../../utils/view/audio/audio_button.dart';
import '../../../utils/view/button/normal/button.dart';
import '../../../utils/view/button/normal/button_size.dart';
import '../../../utils/view/button/normal/button_type.dart';
import '../api/provider/test_provider.dart';

class TestAudioScreen extends ConsumerStatefulWidget {
  const TestAudioScreen({super.key});

  @override
  ConsumerState<TestAudioScreen> createState() => _TestAudioScreenState();
}

class _TestAudioScreenState extends ConsumerState<TestAudioScreen> {

  String? _filePath;

  @override
  Widget build(BuildContext context) {
    var model = ref.watch(testProvider);

    return DefaultLayout(
      title: 'audio',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: UbAudio(
              title: '권유 음성 듣기',
              url: model.videoModel?.voiceUrl == null
                  ? null
                  : model.videoModel!.voiceUrl!,
              type: UbAudioType.play,
              totalDuration: const Duration(seconds: 200),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          //   child: UbAudio(
          //     title: '권유 음성 듣기',
          //     url: 'https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav',
          //     type: AudioType.play,
          //     totalDuration: const Duration(seconds: 200),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: UbAudio(
              title: '녹음 하기',
              type: UbAudioType.record,
              disabled: model.videoModel?.voiceUrl == null ? true : false,
              onFilePathChanged: (filePath){
                setState(() {
                  _filePath = filePath;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: UbAudio(
              title: '녹음 음성 듣기',
              type: UbAudioType.play,
              url: _filePath,
            ),
          ),
          const _RequestVideoScreen(),
        ],
      ),
    );
  }
}

class _RequestVideoScreen extends ConsumerStatefulWidget {
  const _RequestVideoScreen({super.key});

  @override
  ConsumerState<_RequestVideoScreen> createState() =>
      _RequestVideoScreenState();
}

class _RequestVideoScreenState extends ConsumerState<_RequestVideoScreen> {

  @override
  Widget build(BuildContext context) {
    var model = ref.watch(testProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          UbButton(
            title: 'request video',
            onPressed: () async {
              final repository = ref.read(testProvider.notifier);
              await repository.login();
              await repository.requestVideo();
            },
          ),
        ],
      ),
    );
  }
}
