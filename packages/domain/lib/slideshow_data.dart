import 'package:freezed_annotation/freezed_annotation.dart';

part 'slideshow_data.freezed.dart';
part 'slideshow_data.g.dart';

@freezed
class SlideshowData with _$SlideshowData {
  const factory SlideshowData({
    required int id,
    required String title,
    required String fileName,
  }) = _SlideshowData;

  factory SlideshowData.fromJson(Map<String, dynamic> json) =>
      _$SlideshowDataFromJson(json);
}
