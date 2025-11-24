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
    r'9899ca9096923a97b95a08052b185e6378ff4843';

/// Image Generation Service Provider
/// Mock 서비스 (추후 Imagen 3로 교체 예정)
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
