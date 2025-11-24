// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_analysis_ui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ImageAnalysisUi {
  String get id => throw _privateConstructorUsedError;
  String get originalImagePath => throw _privateConstructorUsedError;
  String get analysisText => throw _privateConstructorUsedError;
  String get sceneType =>
      throw _privateConstructorUsedError; // 이미 한글이니까 Label 불필요
  List<String> get tags => throw _privateConstructorUsedError;
  String get formattedDate => throw _privateConstructorUsedError;

  /// Create a copy of ImageAnalysisUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageAnalysisUiCopyWith<ImageAnalysisUi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageAnalysisUiCopyWith<$Res> {
  factory $ImageAnalysisUiCopyWith(
    ImageAnalysisUi value,
    $Res Function(ImageAnalysisUi) then,
  ) = _$ImageAnalysisUiCopyWithImpl<$Res, ImageAnalysisUi>;
  @useResult
  $Res call({
    String id,
    String originalImagePath,
    String analysisText,
    String sceneType,
    List<String> tags,
    String formattedDate,
  });
}

/// @nodoc
class _$ImageAnalysisUiCopyWithImpl<$Res, $Val extends ImageAnalysisUi>
    implements $ImageAnalysisUiCopyWith<$Res> {
  _$ImageAnalysisUiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageAnalysisUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? originalImagePath = null,
    Object? analysisText = null,
    Object? sceneType = null,
    Object? tags = null,
    Object? formattedDate = null,
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
            formattedDate: null == formattedDate
                ? _value.formattedDate
                : formattedDate // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ImageAnalysisUiImplCopyWith<$Res>
    implements $ImageAnalysisUiCopyWith<$Res> {
  factory _$$ImageAnalysisUiImplCopyWith(
    _$ImageAnalysisUiImpl value,
    $Res Function(_$ImageAnalysisUiImpl) then,
  ) = __$$ImageAnalysisUiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String originalImagePath,
    String analysisText,
    String sceneType,
    List<String> tags,
    String formattedDate,
  });
}

/// @nodoc
class __$$ImageAnalysisUiImplCopyWithImpl<$Res>
    extends _$ImageAnalysisUiCopyWithImpl<$Res, _$ImageAnalysisUiImpl>
    implements _$$ImageAnalysisUiImplCopyWith<$Res> {
  __$$ImageAnalysisUiImplCopyWithImpl(
    _$ImageAnalysisUiImpl _value,
    $Res Function(_$ImageAnalysisUiImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageAnalysisUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? originalImagePath = null,
    Object? analysisText = null,
    Object? sceneType = null,
    Object? tags = null,
    Object? formattedDate = null,
  }) {
    return _then(
      _$ImageAnalysisUiImpl(
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
        formattedDate: null == formattedDate
            ? _value.formattedDate
            : formattedDate // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ImageAnalysisUiImpl implements _ImageAnalysisUi {
  const _$ImageAnalysisUiImpl({
    required this.id,
    required this.originalImagePath,
    required this.analysisText,
    required this.sceneType,
    required final List<String> tags,
    required this.formattedDate,
  }) : _tags = tags;

  @override
  final String id;
  @override
  final String originalImagePath;
  @override
  final String analysisText;
  @override
  final String sceneType;
  // 이미 한글이니까 Label 불필요
  final List<String> _tags;
  // 이미 한글이니까 Label 불필요
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String formattedDate;

  @override
  String toString() {
    return 'ImageAnalysisUi(id: $id, originalImagePath: $originalImagePath, analysisText: $analysisText, sceneType: $sceneType, tags: $tags, formattedDate: $formattedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageAnalysisUiImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.originalImagePath, originalImagePath) ||
                other.originalImagePath == originalImagePath) &&
            (identical(other.analysisText, analysisText) ||
                other.analysisText == analysisText) &&
            (identical(other.sceneType, sceneType) ||
                other.sceneType == sceneType) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.formattedDate, formattedDate) ||
                other.formattedDate == formattedDate));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    originalImagePath,
    analysisText,
    sceneType,
    const DeepCollectionEquality().hash(_tags),
    formattedDate,
  );

  /// Create a copy of ImageAnalysisUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageAnalysisUiImplCopyWith<_$ImageAnalysisUiImpl> get copyWith =>
      __$$ImageAnalysisUiImplCopyWithImpl<_$ImageAnalysisUiImpl>(
        this,
        _$identity,
      );
}

abstract class _ImageAnalysisUi implements ImageAnalysisUi {
  const factory _ImageAnalysisUi({
    required final String id,
    required final String originalImagePath,
    required final String analysisText,
    required final String sceneType,
    required final List<String> tags,
    required final String formattedDate,
  }) = _$ImageAnalysisUiImpl;

  @override
  String get id;
  @override
  String get originalImagePath;
  @override
  String get analysisText;
  @override
  String get sceneType; // 이미 한글이니까 Label 불필요
  @override
  List<String> get tags;
  @override
  String get formattedDate;

  /// Create a copy of ImageAnalysisUi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageAnalysisUiImplCopyWith<_$ImageAnalysisUiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
