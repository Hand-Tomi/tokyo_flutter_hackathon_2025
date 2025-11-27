// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_analysis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ImageAnalysis _$ImageAnalysisFromJson(Map<String, dynamic> json) {
  return _ImageAnalysis.fromJson(json);
}

/// @nodoc
mixin _$ImageAnalysis {
  String get id => throw _privateConstructorUsedError;
  String get originalImagePath => throw _privateConstructorUsedError;
  String get analysisText => throw _privateConstructorUsedError;
  String get sceneType =>
      throw _privateConstructorUsedError; // enum 대신 String으로 변경
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ImageAnalysis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageAnalysisCopyWith<ImageAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageAnalysisCopyWith<$Res> {
  factory $ImageAnalysisCopyWith(
    ImageAnalysis value,
    $Res Function(ImageAnalysis) then,
  ) = _$ImageAnalysisCopyWithImpl<$Res, ImageAnalysis>;
  @useResult
  $Res call({
    String id,
    String originalImagePath,
    String analysisText,
    String sceneType,
    List<String> tags,
    DateTime createdAt,
  });
}

/// @nodoc
class _$ImageAnalysisCopyWithImpl<$Res, $Val extends ImageAnalysis>
    implements $ImageAnalysisCopyWith<$Res> {
  _$ImageAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? originalImagePath = null,
    Object? analysisText = null,
    Object? sceneType = null,
    Object? tags = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            originalImagePath: null == originalImagePath
                ? _value.originalImagePath
                : originalImagePath // ignore: cast_nullable_to_non_nullable
                      as String,
            analysisText: null == analysisText
                ? _value.analysisText
                : analysisText // ignore: cast_nullable_to_non_nullable
                      as String,
            sceneType: null == sceneType
                ? _value.sceneType
                : sceneType // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ImageAnalysisImplCopyWith<$Res>
    implements $ImageAnalysisCopyWith<$Res> {
  factory _$$ImageAnalysisImplCopyWith(
    _$ImageAnalysisImpl value,
    $Res Function(_$ImageAnalysisImpl) then,
  ) = __$$ImageAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String originalImagePath,
    String analysisText,
    String sceneType,
    List<String> tags,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$ImageAnalysisImplCopyWithImpl<$Res>
    extends _$ImageAnalysisCopyWithImpl<$Res, _$ImageAnalysisImpl>
    implements _$$ImageAnalysisImplCopyWith<$Res> {
  __$$ImageAnalysisImplCopyWithImpl(
    _$ImageAnalysisImpl _value,
    $Res Function(_$ImageAnalysisImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? originalImagePath = null,
    Object? analysisText = null,
    Object? sceneType = null,
    Object? tags = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ImageAnalysisImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        originalImagePath: null == originalImagePath
            ? _value.originalImagePath
            : originalImagePath // ignore: cast_nullable_to_non_nullable
                  as String,
        analysisText: null == analysisText
            ? _value.analysisText
            : analysisText // ignore: cast_nullable_to_non_nullable
                  as String,
        sceneType: null == sceneType
            ? _value.sceneType
            : sceneType // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageAnalysisImpl implements _ImageAnalysis {
  const _$ImageAnalysisImpl({
    required this.id,
    required this.originalImagePath,
    required this.analysisText,
    required this.sceneType,
    required final List<String> tags,
    required this.createdAt,
  }) : _tags = tags;

  factory _$ImageAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageAnalysisImplFromJson(json);

  @override
  final String id;
  @override
  final String originalImagePath;
  @override
  final String analysisText;
  @override
  final String sceneType;
  // enum 대신 String으로 변경
  final List<String> _tags;
  // enum 대신 String으로 변경
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ImageAnalysis(id: $id, originalImagePath: $originalImagePath, analysisText: $analysisText, sceneType: $sceneType, tags: $tags, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageAnalysisImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.originalImagePath, originalImagePath) ||
                other.originalImagePath == originalImagePath) &&
            (identical(other.analysisText, analysisText) ||
                other.analysisText == analysisText) &&
            (identical(other.sceneType, sceneType) ||
                other.sceneType == sceneType) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    originalImagePath,
    analysisText,
    sceneType,
    const DeepCollectionEquality().hash(_tags),
    createdAt,
  );

  /// Create a copy of ImageAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageAnalysisImplCopyWith<_$ImageAnalysisImpl> get copyWith =>
      __$$ImageAnalysisImplCopyWithImpl<_$ImageAnalysisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageAnalysisImplToJson(this);
  }
}

abstract class _ImageAnalysis implements ImageAnalysis {
  const factory _ImageAnalysis({
    required final String id,
    required final String originalImagePath,
    required final String analysisText,
    required final String sceneType,
    required final List<String> tags,
    required final DateTime createdAt,
  }) = _$ImageAnalysisImpl;

  factory _ImageAnalysis.fromJson(Map<String, dynamic> json) =
      _$ImageAnalysisImpl.fromJson;

  @override
  String get id;
  @override
  String get originalImagePath;
  @override
  String get analysisText;
  @override
  String get sceneType; // enum 대신 String으로 변경
  @override
  List<String> get tags;
  @override
  DateTime get createdAt;

  /// Create a copy of ImageAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageAnalysisImplCopyWith<_$ImageAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
