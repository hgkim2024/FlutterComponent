import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ub_flutter/test/screen/api/model/login_model.dart';
import 'package:ub_flutter/test/screen/api/model/video_model.dart';

class TestModel {
  LoginModel? loginModel;
  VideoModel? videoModel;

  TestModel({
    this.loginModel,
    this.videoModel,
  });

  TestModel copyWith({
    LoginModel? loginModel,
    VideoModel? videoModel,
  }) {
    return TestModel(
      loginModel: loginModel ?? this.loginModel,
      videoModel: videoModel ?? this.videoModel,
    );
  }
}
