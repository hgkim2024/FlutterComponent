// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) => LoginBody(
      accessCode: json['accessCode'] as String,
      password: json['password'] as String,
      appVersion: json['appVersion'] as String,
      deviceName: json['deviceName'] as String,
      deviceVersion: json['deviceVersion'] as String,
    );

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) => <String, dynamic>{
      'accessCode': instance.accessCode,
      'password': instance.password,
      'appVersion': instance.appVersion,
      'deviceName': instance.deviceName,
      'deviceVersion': instance.deviceVersion,
    };

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      userName: json['userName'] as String?,
      userGender: json['userGender'] as String?,
      startDate: json['startDate'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'userName': instance.userName,
      'userGender': instance.userGender,
      'startDate': instance.startDate,
    };

UpdateTokenBody _$UpdateTokenBodyFromJson(Map<String, dynamic> json) =>
    UpdateTokenBody(
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$UpdateTokenBodyToJson(UpdateTokenBody instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
    };
