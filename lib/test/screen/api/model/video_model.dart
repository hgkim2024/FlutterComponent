import 'package:json_annotation/json_annotation.dart';
import 'package:ub_flutter/utils/view/text/text.dart';

import '../utils/utils.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel {
  String detailModuleVideoTitle;
  String detailModuleFileId;
  String detailModuleThumbnail;
  String detailModuleVideo;
  @JsonKey(
    fromJson: CMPType.fromString,
  )
  CMPType detailModuleState;
  bool isForced;
  String description;
  String? voiceUrl;

  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  UbHighlightText? highlightText;

  VideoModel({
    required this.detailModuleVideoTitle,
    required this.detailModuleFileId,
    required this.detailModuleThumbnail,
    required this.detailModuleVideo,
    required this.detailModuleState,
    required this.isForced,
    required this.description,
    this.voiceUrl,
    this.highlightText,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
