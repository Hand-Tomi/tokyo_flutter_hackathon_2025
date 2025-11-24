import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated_image.freezed.dart';
part 'generated_image.g.dart';

enum GenerationStatus {
  pending,
  completed,
  failed,
}

@freezed
class GeneratedImage with _$GeneratedImage {
  const factory GeneratedImage({
    required String id,
    required String imagePath,
    required String prompt,
    required GenerationStatus status,
    required DateTime createdAt,
  }) = _GeneratedImage;

  factory GeneratedImage.fromJson(Map<String, dynamic> json) =>
      _$GeneratedImageFromJson(json);
}
