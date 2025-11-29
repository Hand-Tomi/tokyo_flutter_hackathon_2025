// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$visionServiceHash() => r'3bd56c175653bac2156608bca5c205102b4a1b88';

/// Vision Service Provider
/// Gemini 2.5 Flash 고정
///
/// Copied from [visionService].
@ProviderFor(visionService)
final visionServiceProvider = AutoDisposeProvider<VisionService>.internal(
  visionService,
  name: r'visionServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$visionServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VisionServiceRef = AutoDisposeProviderRef<VisionService>;
String _$imageGenerationServiceHash() =>
    r'b1a4393275ea8b24ed404d41f94d24c28aa0f820';

/// Image Generation Service Provider
///
/// 환경 변수 IMAGE_GEN_PROVIDER로 선택:
/// - 'imagen': Imagen 3 API (기본값, 추천)
/// - 'gemini': Gemini 2.0 Flash 이미지 생성
///
/// Copied from [imageGenerationService].
@ProviderFor(imageGenerationService)
final imageGenerationServiceProvider =
    AutoDisposeProvider<ImageGenerationService>.internal(
      imageGenerationService,
      name: r'imageGenerationServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$imageGenerationServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ImageGenerationServiceRef =
    AutoDisposeProviderRef<ImageGenerationService>;
String _$sketchToImageServiceHash() =>
    r'0af925c3cb840fab2e479cc568dcdf9d93b1fb8e';

/// Sketch to Image Service Provider
/// 스케치 + 텍스트 → 동화풍 이미지 변환
///
/// Copied from [sketchToImageService].
@ProviderFor(sketchToImageService)
final sketchToImageServiceProvider =
    AutoDisposeProvider<SketchToImageService>.internal(
      sketchToImageService,
      name: r'sketchToImageServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sketchToImageServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SketchToImageServiceRef = AutoDisposeProviderRef<SketchToImageService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
