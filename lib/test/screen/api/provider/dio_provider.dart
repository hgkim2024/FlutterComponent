import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ub_flutter/test/screen/api/model/http_model.dart';
import 'package:ub_flutter/test/screen/api/model/login_model.dart';
import 'package:ub_flutter/test/screen/api/provider/secure_storage_provider.dart';
import 'package:ub_flutter/test/screen/api/utils/http_code.dart';
import 'package:ub_flutter/utils/data.dart';
import 'package:ub_flutter/utils/log/log.dart';

import '../utils/utils.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.read(secureStorageProvider);

  dio.interceptors.add(
    DioInterceptor(
      storage: storage,
    ),
  );

  return dio;
});

class DioInterceptor extends Interceptor {
  final FlutterSecureStorage? storage;

  DioInterceptor({
    this.storage,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final url = _parseUri(options.uri);

    if (!url.contains('login')) {
      final token = await storage?.read(key: ACCESS_TOKEN_KEY);
      if (token != null) {
        options.headers.addAll({
          'authorization': 'Bearer $token',
        });
      }
    }

    const List<Tag> tags = [Tag.API, Tag.REQUEST];
    ubLog.tags(tags).xd("🚀 ——→ $_endSeparator");
    ubLog.tags(tags).xd(
          '🚀 [URL] - [${options.method}] $url',
        );
    ubLog.tags(tags).xd('🚀 [HEADERS] - ${options.headers}');
    final data = options.data;
    if (data is Map<String, dynamic>) {
      ubLog.tags(tags).xd('🚀 [BODY] - ${data.toPrettyString()}');
    } else {
      ubLog.tags(tags).xd('🚀 [BODY] - $data');
    }
    ubLog.tags(tags).xd('🚀 ——→ $_endSeparator');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = UbHttpResponseLog.fromJson(response.data);
    final failed = data.code != UbHttpCode.OK;
    List<Tag> tags = [
      Tag.API,
      Tag.RESPONSE,
    ];

    if (failed) {
      handleDioErrorOrResponse(response: response, handler: handler);
    } else {
      ubLog.tags(tags).xd("✅ ←—— $_endSeparator");
      ubLog.tags(tags).xd(
            '✅ [URL] - [${response.requestOptions.method}] ${_parseUri(response.requestOptions.uri)}',
          );
      ubLog.tags(tags).xd(
            '✅ [HEADERS] - ${response.requestOptions.headers}',
          );
      ubLog.tags(tags).xd(
          '✅ [CODE] - [${data.status}] ${data.code.code}, ${response.statusCode}');
      ubLog.tags(tags).xd('✅ [MESSAGE] - ${data.message}');
      ubLog.tags(tags).xd('✅ [TIME] - ${data.timestamp}');
      ubLog.tags(tags).xd('✅ [BODY] - ${data.body?.toPrettyString()}');
      ubLog.tags(tags).xd('✅ ←—— $_endSeparator');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    handleDioErrorOrResponse(err: err, handler: handler);
  }

  Future<void> handleDioErrorOrResponse(
      {DioException? err, Response? response, required dynamic handler}) async {
    const List<Tag> tags = [Tag.API];

    try {
      if (err != null) {
        if (err.response == null) {
          throw Exception('response is null');
        }

        response = err.response!;
      }

      if (response == null) {
        throw Exception('response is null');
      }

      final data = UbHttpResponseLog.fromJson(response.data);
      ubLog.tags(tags).xe("❌ ←—— $_endSeparator");
      ubLog.tags(tags).xe(
            '❌ [URL] - [${response.requestOptions.method}] ${_parseUri(response.requestOptions.uri)}',
          );
      ubLog.tags(tags).xe(
            '❌ [HEADERS] - ${response.requestOptions.headers}',
          );
      ubLog.tags(tags).xe(
          '❌ [CODE] - [${data.status}] ${data.code.code}, ${response.statusCode}');
      ubLog.tags(tags).xe('❌ [MESSAGE] - ${data.message}');
      ubLog.tags(tags).xe('❌ [TIME] - ${data.timestamp}');
      ubLog.tags(tags).xe('❌ [BODY] - ${data.body?.toPrettyString()}');
      ubLog.tags(tags).xe('❌ ←—— $_endSeparator');

      var accessToken = await storage?.read(key: ACCESS_TOKEN_KEY);
      final refreshToken = await storage?.read(key: REFRESH_TOKEN_KEY);

      if (accessToken == null || refreshToken == null) {
        throw _LogException();
      }

      const refreshTokenPath = '/login/refresh';
      final isExpiredAccessToken = data.code == UbHttpCode.EXPIRED_TOKEN;
      final isPathRefresh = response.requestOptions.path.contains(refreshTokenPath);

      // 리프레시 토큰 갱신하는 로직 개선하기 - 어떻게 할지 고민할 것
      if (isExpiredAccessToken && !isPathRefresh) {
        final updateTokenBody = UpdateTokenBody(refreshToken: refreshToken);
        final dio = Dio()..interceptors.add(DioInterceptor());
        final reps = await dio.post('${DataUtils.baseUrl}$refreshTokenPath',
            data: updateTokenBody.toJson(),
            options: Options(headers: {
              'authorization': 'Bearer $accessToken',
            }));

        final loginModel = UbHttpResponse<LoginModel>.fromJson(
          reps.data,
          (json) => LoginModel.fromJson(json as Map<String, dynamic>),
        ).body;

        if (loginModel == null) {
          throw _LogException();
        }
        accessToken = loginModel.accessToken;
        storage?.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        final options = response.requestOptions;
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });
        final originResponse = await dio.fetch(options);
        return handler.resolve(originResponse);
      }
    } catch (e) {
      if (e is! _LogException && e is! FormatException) {
        ubLog.tags(tags).xe("❌ ←—— $_endSeparator");
        ubLog.tags(tags).xe(
              '❌ [URL] - [${err?.requestOptions.method ?? response?.requestOptions.method}] ${_parseUri(err?.requestOptions.uri ?? response?.requestOptions.uri)}',
            );
        ubLog.tags(tags).xe(
              '❌ [HEADERS] - ${err?.requestOptions.headers ?? response?.requestOptions.headers}',
            );
        ubLog.tags(tags).xe('❌ [ERROR] - ${err?.error}');
        ubLog.tags(tags).xe('❌$_endSeparator');
      }

      if (err != null) {
        return handler.reject(err);
      } else {
        handler.next(response!);
      }
    }
  }

  String get _endSeparator {
    return '——————————————————————————————————————————————————————————————————————';
  }

  String _parseUri(Uri? uri) {
    // String pathWithQuery = uri.replace(scheme: '', host: '').toString();
    // return '/${pathWithQuery.replaceFirst(RegExp(r'^/+'), '')}';
    if (uri == null) {
      return 'NULL';
    }
    return uri.toString().replaceAll(DataUtils.baseUrl, '');
  }
}

class _LogException implements Exception {}
