import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ub_flutter/test/screen/api/model/http_model.dart';
import 'package:ub_flutter/test/screen/api/model/login_model.dart';
import 'package:ub_flutter/test/screen/api/model/test_model.dart';
import 'package:ub_flutter/test/screen/api/model/video_model.dart';
import 'package:ub_flutter/test/screen/api/provider/secure_storage_provider.dart';
import 'package:ub_flutter/test/screen/api/repository/test_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

// final testStateNotifier = StateNotifier();

final testProvider =
    StateNotifierProvider.autoDispose<TestStateNotifier, TestModel>((ref) {
  final repository = ref.watch(testRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return TestStateNotifier(
    repository: repository,
    storage: storage,
  );
});

class TestStateNotifier extends StateNotifier<TestModel> {
  final TestRepository repository;
  final FlutterSecureStorage storage;

  TestStateNotifier({
    required this.repository,
    required this.storage,
  }) : super(TestModel());

  login() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String deviceName = '';
    String deviceVersion = '';

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name;
      deviceVersion = iosInfo.systemVersion;
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
      deviceVersion = androidInfo.version.release;
    }

    final body = LoginBody(
      accessCode: 'DST0000230',
      password: 'xtq1bq',
      appVersion: packageInfo.version,
      deviceName: deviceName,
      deviceVersion: deviceVersion,
    );

    final response = await repository.login(body: body);
    final loginModel = response.body!;

    await storage.write(key: LOGIN_ID_KEY, value: body.accessCode);
    await storage.write(key: ACCESS_TOKEN_KEY, value: loginModel.accessToken);
    await storage.write(key: REFRESH_TOKEN_KEY, value: loginModel.refreshToken);
  }

  requestVideo() async {
    final id = await storage.read(key: LOGIN_ID_KEY);
    const moduleId = 'M02';
    const detailModuleId = 'M0205';

    final response = await repository.getVideo(
      id: id!,
      moduleId: moduleId,
      detailModuleId: detailModuleId,
    );

    final videoModel = response.body!;
    state = state.copyWith(
      videoModel: videoModel,
    );
  }

  updateToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null)
      return;

    final updateTokenBody = UpdateTokenBody(
      refreshToken: refreshToken,
    );
  }
}
