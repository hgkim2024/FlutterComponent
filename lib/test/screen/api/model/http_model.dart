import 'package:json_annotation/json_annotation.dart';
import 'package:ub_flutter/test/screen/api/utils/http_code.dart';
import 'package:ub_flutter/test/screen/api/utils/utils.dart';

// part 'http_model.g.dart';

class UbHttpResponse<T> {
  UbHttpCode code;
  String message;
  String status;
  DateTime timestamp;
  T? body;

  UbHttpResponse({
    required this.code,
    required this.message,
    required this.status,
    required this.timestamp,
    this.body,
  });

  factory UbHttpResponse.fromJson(
    Map<String, dynamic> json,
    T? Function(Object? json)? fromJsonT,
  ) {
    try {
      return  UbHttpResponse<T>(
        code: UbHttpCode.fromString(json['code'] as String),
        message: json['message'] as String,
        status: json['status'] as String,
        timestamp: DataUtils.stringToDateTime(json['timestamp'] as String),
        body: fromJsonT != null ? fromJsonT(json['body']) : null,
      );
    } catch (e) {
      throw FormatException("❌ Failed to parse JSON: $e");
    }
  }

  Map<String, dynamic> toJson(Object? Function(T? value)? toJsonT) => {
        'code': code,
        'message': message,
        'status': status,
        'timestamp': timestamp,
        'body': toJsonT != null ? toJsonT(body) : null,
      };
}

class UbHttpResponseLog {
  UbHttpCode code;
  String message;
  String status;
  DateTime timestamp;
  Map<String, dynamic>? body;

  UbHttpResponseLog({
    required this.code,
    required this.message,
    required this.status,
    required this.timestamp,
    this.body,
  });

  factory UbHttpResponseLog.fromJson(
    Map<String, dynamic> json,
  ) {
    try {
      return UbHttpResponseLog(
        code: UbHttpCode.fromString(json['code'] as String),
        message: json['message'] as String,
        status: json['status'] as String,
        timestamp: DataUtils.stringToDateTime(json['timestamp'] as String),
        body: json['body'] is Map<String, dynamic>
            ? json['body'] as Map<String, dynamic>
            : null,
      );
    } catch (e) {
      throw FormatException("❌ Failed to parse JSON: $e");
    }
  }
}
