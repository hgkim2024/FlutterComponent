import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ub_flutter/test/screen/api/model/video_model.dart';
import 'package:ub_flutter/test/screen/api/provider/secure_storage_provider.dart';
import 'package:ub_flutter/test/screen/api/provider/test_provider.dart';
import 'package:ub_flutter/test/screen/api/repository/test_repository.dart';
import 'package:ub_flutter/test/screen/api/utils/utils.dart';
import 'package:ub_flutter/utils/data.dart';
import 'package:ub_flutter/utils/layout/default_layout.dart';
import 'package:ub_flutter/utils/log/log.dart';
import 'package:ub_flutter/utils/view/button/normal/button.dart';
import 'package:ub_flutter/utils/view/color.dart';
import 'package:ub_flutter/utils/view/image.dart';
import 'package:ub_flutter/utils/view/text/font.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

import '../../../utils/view/button/normal/button_icon.dart';
import '../../../utils/view/button/video/video_thumbnail.dart';
import '../api/model/http_model.dart';
import '../api/model/login_model.dart';
import '../api/provider/dio_provider.dart';

class TestVideoScreen extends ConsumerWidget {
  const TestVideoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var model = ref.watch(testProvider);

    return DefaultLayout(
      title: 'video',
      child: Container(
        child: model.videoModel == null
            ? const _RequestVideoScreen()
            : _VideoThumbnailScreen(
                videoModel: model.videoModel!,
                onPressed: () {},
              ),
      ),
    );
  }
}

class _RequestVideoScreen extends ConsumerWidget {
  const _RequestVideoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          UbButton(
            title: 'request video',
            onPressed: () async {
              final repository = ref.read(testProvider.notifier);
              await repository.login();
              await repository.requestVideo();


              //// update token code
              // final storage = ref.read(secureStorageProvider);
              // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
              // final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
              //
              // const refreshTokenPath = '/login/refresh';
              // final updateTokenBody =
              //     UpdateTokenBody(refreshToken: refreshToken!);
              // final dio = Dio()..interceptors.add(DioInterceptor());
              // final reps = await dio.post(
              //   '${DataUtils.baseUrl}$refreshTokenPath',
              //   data: updateTokenBody.toJson(),
              //   options: Options(
              //     headers: {
              //       'authorization': 'Bearer $accessToken',
              //     },
              //   ),
              // );
              //
              // final loginModel = UbHttpResponse<LoginModel>.fromJson(
              //   reps.data,
              //       (json) => LoginModel.fromJson(json as Map<String, dynamic>),
              // ).body;
            },
          ),
        ],
      ),
    );
  }
}

class _VideoThumbnailScreen extends ConsumerWidget {
  final VideoModel videoModel;
  final VoidCallback onPressed;

  const _VideoThumbnailScreen({
    super.key,
    required this.videoModel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      bottom: true,
      child: Container(
        color: UbColor.white.color,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _Content(context),
      ),
    );
  }

  Widget _Content(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return _Body(context);
    } else {
      return ListView(
        children: [_Body(context)],
      );
    }
  }

  Widget _Body(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: UbText(
            videoModel.detailModuleVideoTitle,
            font: UbFont.title3,
            color: UbColor.textNormal,
          ),
        ),
        UbVideoThumbnail(videoModel: videoModel),
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          Expanded(child: Container()),
        if (MediaQuery.of(context).orientation == Orientation.landscape)
          const SizedBox(height: 24),
        UbButton(
          title: '다음',
          icon: UbButtonIcon.right,
          onPressed:
              videoModel.detailModuleState == CMPType.CMP ? onPressed : null,
        )
      ],
    );
  }
}
