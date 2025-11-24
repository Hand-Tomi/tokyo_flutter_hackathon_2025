// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeneratedImageImpl _$$GeneratedImageImplFromJson(Map<String, dynamic> json) =>
    _$GeneratedImageImpl(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      prompt: json['prompt'] as String,
      status: $enumDecode(_$GenerationStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$GeneratedImageImplToJson(
  _$GeneratedImageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'imagePath': instance.imagePath,
  'prompt': instance.prompt,
  'status': _$GenerationStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$GenerationStatusEnumMap = {
  GenerationStatus.pending: 'pending',
  GenerationStatus.completed: 'completed',
  GenerationStatus.failed: 'failed',
};
