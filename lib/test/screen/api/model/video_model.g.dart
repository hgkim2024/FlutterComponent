// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      detailModuleVideoTitle: json['detailModuleVideoTitle'] as String,
      detailModuleFileId: json['detailModuleFileId'] as String,
      detailModuleThumbnail: json['detailModuleThumbnail'] as String,
      detailModuleVideo: json['detailModuleVideo'] as String,
      detailModuleState:
          CMPType.fromString(json['detailModuleState'] as String),
      isForced: json['isForced'] as bool,
      description: json['description'] as String,
      voiceUrl: json['voiceUrl'] as String?,
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'detailModuleVideoTitle': instance.detailModuleVideoTitle,
      'detailModuleFileId': instance.detailModuleFileId,
      'detailModuleThumbnail': instance.detailModuleThumbnail,
      'detailModuleVideo': instance.detailModuleVideo,
      'detailModuleState': _$CMPTypeEnumMap[instance.detailModuleState]!,
      'isForced': instance.isForced,
      'description': instance.description,
      'voiceUrl': instance.voiceUrl,
    };

const _$CMPTypeEnumMap = {
  CMPType.CMP: 'CMP',
  CMPType.NCMP: 'NCMP',
};
