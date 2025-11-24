// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generated_image_ui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GeneratedImageUi {
  String get id => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  String get prompt => throw _privateConstructorUsedError;
  String get statusLabel => throw _privateConstructorUsedError;
  String get formattedDate => throw _privateConstructorUsedError;

  /// Create a copy of GeneratedImageUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeneratedImageUiCopyWith<GeneratedImageUi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratedImageUiCopyWith<$Res> {
  factory $GeneratedImageUiCopyWith(
    GeneratedImageUi value,
    $Res Function(GeneratedImageUi) then,
  ) = _$GeneratedImageUiCopyWithImpl<$Res, GeneratedImageUi>;
  @useResult
  $Res call({
    String id,
    String imagePath,
    String prompt,
    String statusLabel,
    String formattedDate,
  });
}

/// @nodoc
class _$GeneratedImageUiCopyWithImpl<$Res, $Val extends GeneratedImageUi>
    implements $GeneratedImageUiCopyWith<$Res> {
  _$GeneratedImageUiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeneratedImageUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imagePath = null,
    Object? prompt = null,
    Object? statusLabel = null,
    Object? formattedDate = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            imagePath: null == imagePath
                ? _value.imagePath
                : imagePath // ignore: cast_nullable_to_non_nullable
                      as String,
            prompt: null == prompt
                ? _value.prompt
                : prompt // ignore: cast_nullable_to_non_nullable
                      as String,
            statusLabel: null == statusLabel
                ? _value.statusLabel
                : statusLabel // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$GeneratedImageUiImplCopyWith<$Res>
    implements $GeneratedImageUiCopyWith<$Res> {
  factory _$$GeneratedImageUiImplCopyWith(
    _$GeneratedImageUiImpl value,
    $Res Function(_$GeneratedImageUiImpl) then,
  ) = __$$GeneratedImageUiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String imagePath,
    String prompt,
    String statusLabel,
    String formattedDate,
  });
}

/// @nodoc
class __$$GeneratedImageUiImplCopyWithImpl<$Res>
    extends _$GeneratedImageUiCopyWithImpl<$Res, _$GeneratedImageUiImpl>
    implements _$$GeneratedImageUiImplCopyWith<$Res> {
  __$$GeneratedImageUiImplCopyWithImpl(
    _$GeneratedImageUiImpl _value,
    $Res Function(_$GeneratedImageUiImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GeneratedImageUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imagePath = null,
    Object? prompt = null,
    Object? statusLabel = null,
    Object? formattedDate = null,
  }) {
    return _then(
      _$GeneratedImageUiImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        imagePath: null == imagePath
            ? _value.imagePath
            : imagePath // ignore: cast_nullable_to_non_nullable
                  as String,
        prompt: null == prompt
            ? _value.prompt
            : prompt // ignore: cast_nullable_to_non_nullable
                  as String,
        statusLabel: null == statusLabel
            ? _value.statusLabel
            : statusLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        formattedDate: null == formattedDate
            ? _value.formattedDate
            : formattedDate // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$GeneratedImageUiImpl implements _GeneratedImageUi {
  const _$GeneratedImageUiImpl({
    required this.id,
    required this.imagePath,
    required this.prompt,
    required this.statusLabel,
    required this.formattedDate,
  });

  @override
  final String id;
  @override
  final String imagePath;
  @override
  final String prompt;
  @override
  final String statusLabel;
  @override
  final String formattedDate;

  @override
  String toString() {
    return 'GeneratedImageUi(id: $id, imagePath: $imagePath, prompt: $prompt, statusLabel: $statusLabel, formattedDate: $formattedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratedImageUiImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.statusLabel, statusLabel) ||
                other.statusLabel == statusLabel) &&
            (identical(other.formattedDate, formattedDate) ||
                other.formattedDate == formattedDate));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    imagePath,
    prompt,
    statusLabel,
    formattedDate,
  );

  /// Create a copy of GeneratedImageUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratedImageUiImplCopyWith<_$GeneratedImageUiImpl> get copyWith =>
      __$$GeneratedImageUiImplCopyWithImpl<_$GeneratedImageUiImpl>(
        this,
        _$identity,
      );
}

abstract class _GeneratedImageUi implements GeneratedImageUi {
  const factory _GeneratedImageUi({
    required final String id,
    required final String imagePath,
    required final String prompt,
    required final String statusLabel,
    required final String formattedDate,
  }) = _$GeneratedImageUiImpl;

  @override
  String get id;
  @override
  String get imagePath;
  @override
  String get prompt;
  @override
  String get statusLabel;
  @override
  String get formattedDate;

  /// Create a copy of GeneratedImageUi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneratedImageUiImplCopyWith<_$GeneratedImageUiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
