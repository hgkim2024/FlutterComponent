import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginBody {
  final String accessCode;
  final String password;
  final String appVersion;
  final String deviceName;
  final String deviceVersion;

  LoginBody({
    required this.accessCode,
    required this.password,
    required this.appVersion,
    required this.deviceName,
    required this.deviceVersion,
  });

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
// factory LoginBody.fromJson(Map<String, dynamic> json) => _$LoginBodyFromJson(json);
}

@JsonSerializable()
class LoginModel {
  final String accessToken;
  final String refreshToken;
  final String? userName;
  final String? userGender;
  final String? startDate;

  LoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userName,
    required this.userGender,
    required this.startDate,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}

@JsonSerializable()
class UpdateTokenBody {
  final String refreshToken;

  UpdateTokenBody({
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() => _$UpdateTokenBodyToJson(this);
}
