import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:ub_flutter/test/screen/api/model/video_model.dart';
import 'package:ub_flutter/test/screen/api/provider/dio_provider.dart';
import 'package:ub_flutter/test/screen/api/utils/utils.dart';
import 'package:ub_flutter/utils/data.dart';

import '../../../../utils/log/log.dart';
import '../model/http_model.dart';
import '../model/login_model.dart';

part 'test_repository.g.dart';

final testRepositoryProvider = Provider<TestRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TestRepository(dio, baseUrl: DataUtils.baseUrl);
});

@RestApi()
abstract class TestRepository {
  factory TestRepository(Dio dio, {String baseUrl}) = _TestRepository;

  @POST('/login')
  @Headers({
    'Authorization': 'Basic ZHN0b3A6ZHN0b3BjbGllbnQ=', // dstop:dstopclient
  })
  Future<UbHttpResponse<LoginModel>> login({
    @Body() required LoginBody body,
  });

  @GET('/common/detailModule/{id}/{moduleId}/{detailModuleId}')
  Future<UbHttpResponse<VideoModel>> getVideo({
    @Path('id') required String id,
    @Path('moduleId') required String moduleId,
    @Path('detailModuleId') required String detailModuleId,
  });

  @POST('/login/token')
  Future<UbHttpResponse<LoginModel>> updateToken({
    @Body() required UpdateTokenBody body,
  });
}

class ParseErrorLogger {
  void logError(Object error, StackTrace stackTrace, RequestOptions options) {
    ubLog.tag(Tag.JSON).xe(error.toString());
  }
}
