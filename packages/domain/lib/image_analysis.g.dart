// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageAnalysisImpl _$$ImageAnalysisImplFromJson(Map<String, dynamic> json) =>
    _$ImageAnalysisImpl(
      id: json['id'] as String,
      originalImagePath: json['originalImagePath'] as String,
      analysisText: json['analysisText'] as String,
      sceneType: json['sceneType'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ImageAnalysisImplToJson(_$ImageAnalysisImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originalImagePath': instance.originalImagePath,
      'analysisText': instance.analysisText,
      'sceneType': instance.sceneType,
      'tags': instance.tags,
      'createdAt': instance.createdAt.toIso8601String(),
    };
