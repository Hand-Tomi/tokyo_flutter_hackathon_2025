import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated_image_ui.freezed.dart';

@freezed
class GeneratedImageUi with _$GeneratedImageUi {
  const factory GeneratedImageUi({
    required String id,
    required String imagePath,
    required String prompt,
    required String statusLabel,
    required String formattedDate,
  }) = _GeneratedImageUi;
}
