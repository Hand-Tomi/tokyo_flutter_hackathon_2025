// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sketch_test_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SketchTestPageUiState {
  /// 선택된 스케치 이미지 바이트
  Uint8List? get sketchBytes => throw _privateConstructorUsedError;

  /// 동화 텍스트 입력
  String get storyText => throw _privateConstructorUsedError;

  /// 생성된 이미지 경로
  String? get generatedImagePath => throw _privateConstructorUsedError;

  /// 로딩 상태
  bool get isLoading => throw _privateConstructorUsedError;

  /// 상태 메시지
  String get statusMessage => throw _privateConstructorUsedError;

  /// Create a copy of SketchTestPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SketchTestPageUiStateCopyWith<SketchTestPageUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SketchTestPageUiStateCopyWith<$Res> {
  factory $SketchTestPageUiStateCopyWith(
    SketchTestPageUiState value,
    $Res Function(SketchTestPageUiState) then,
  ) = _$SketchTestPageUiStateCopyWithImpl<$Res, SketchTestPageUiState>;
  @useResult
  $Res call({
    Uint8List? sketchBytes,
    String storyText,
    String? generatedImagePath,
    bool isLoading,
    String statusMessage,
  });
}

/// @nodoc
class _$SketchTestPageUiStateCopyWithImpl<
  $Res,
  $Val extends SketchTestPageUiState
>
    implements $SketchTestPageUiStateCopyWith<$Res> {
  _$SketchTestPageUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SketchTestPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sketchBytes = freezed,
    Object? storyText = null,
    Object? generatedImagePath = freezed,
    Object? isLoading = null,
    Object? statusMessage = null,
  }) {
    return _then(
      _value.copyWith(
            sketchBytes: freezed == sketchBytes
                ? _value.sketchBytes
                : sketchBytes // ignore: cast_nullable_to_non_nullable
                      as Uint8List?,
            storyText: null == storyText
                ? _value.storyText
                : storyText // ignore: cast_nullable_to_non_nullable
                      as String,
            generatedImagePath: freezed == generatedImagePath
                ? _value.generatedImagePath
                : generatedImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            statusMessage: null == statusMessage
                ? _value.statusMessage
                : statusMessage // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SketchTestPageUiStateImplCopyWith<$Res>
    implements $SketchTestPageUiStateCopyWith<$Res> {
  factory _$$SketchTestPageUiStateImplCopyWith(
    _$SketchTestPageUiStateImpl value,
    $Res Function(_$SketchTestPageUiStateImpl) then,
  ) = __$$SketchTestPageUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Uint8List? sketchBytes,
    String storyText,
    String? generatedImagePath,
    bool isLoading,
    String statusMessage,
  });
}

/// @nodoc
class __$$SketchTestPageUiStateImplCopyWithImpl<$Res>
    extends
        _$SketchTestPageUiStateCopyWithImpl<$Res, _$SketchTestPageUiStateImpl>
    implements _$$SketchTestPageUiStateImplCopyWith<$Res> {
  __$$SketchTestPageUiStateImplCopyWithImpl(
    _$SketchTestPageUiStateImpl _value,
    $Res Function(_$SketchTestPageUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SketchTestPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sketchBytes = freezed,
    Object? storyText = null,
    Object? generatedImagePath = freezed,
    Object? isLoading = null,
    Object? statusMessage = null,
  }) {
    return _then(
      _$SketchTestPageUiStateImpl(
        sketchBytes: freezed == sketchBytes
            ? _value.sketchBytes
            : sketchBytes // ignore: cast_nullable_to_non_nullable
                  as Uint8List?,
        storyText: null == storyText
            ? _value.storyText
            : storyText // ignore: cast_nullable_to_non_nullable
                  as String,
        generatedImagePath: freezed == generatedImagePath
            ? _value.generatedImagePath
            : generatedImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        statusMessage: null == statusMessage
            ? _value.statusMessage
            : statusMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SketchTestPageUiStateImpl implements _SketchTestPageUiState {
  const _$SketchTestPageUiStateImpl({
    this.sketchBytes,
    this.storyText = '',
    this.generatedImagePath,
    this.isLoading = false,
    this.statusMessage = '스케치 이미지를 선택하세요',
  });

  /// 선택된 스케치 이미지 바이트
  @override
  final Uint8List? sketchBytes;

  /// 동화 텍스트 입력
  @override
  @JsonKey()
  final String storyText;

  /// 생성된 이미지 경로
  @override
  final String? generatedImagePath;

  /// 로딩 상태
  @override
  @JsonKey()
  final bool isLoading;

  /// 상태 메시지
  @override
  @JsonKey()
  final String statusMessage;

  @override
  String toString() {
    return 'SketchTestPageUiState(sketchBytes: $sketchBytes, storyText: $storyText, generatedImagePath: $generatedImagePath, isLoading: $isLoading, statusMessage: $statusMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SketchTestPageUiStateImpl &&
            const DeepCollectionEquality().equals(
              other.sketchBytes,
              sketchBytes,
            ) &&
            (identical(other.storyText, storyText) ||
                other.storyText == storyText) &&
            (identical(other.generatedImagePath, generatedImagePath) ||
                other.generatedImagePath == generatedImagePath) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.statusMessage, statusMessage) ||
                other.statusMessage == statusMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(sketchBytes),
    storyText,
    generatedImagePath,
    isLoading,
    statusMessage,
  );

  /// Create a copy of SketchTestPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SketchTestPageUiStateImplCopyWith<_$SketchTestPageUiStateImpl>
  get copyWith =>
      __$$SketchTestPageUiStateImplCopyWithImpl<_$SketchTestPageUiStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SketchTestPageUiState implements SketchTestPageUiState {
  const factory _SketchTestPageUiState({
    final Uint8List? sketchBytes,
    final String storyText,
    final String? generatedImagePath,
    final bool isLoading,
    final String statusMessage,
  }) = _$SketchTestPageUiStateImpl;

  /// 선택된 스케치 이미지 바이트
  @override
  Uint8List? get sketchBytes;

  /// 동화 텍스트 입력
  @override
  String get storyText;

  /// 생성된 이미지 경로
  @override
  String? get generatedImagePath;

  /// 로딩 상태
  @override
  bool get isLoading;

  /// 상태 메시지
  @override
  String get statusMessage;

  /// Create a copy of SketchTestPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SketchTestPageUiStateImplCopyWith<_$SketchTestPageUiStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SketchTestPageAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String message) showError,
    required TResult Function(String message) showSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String message)? showError,
    TResult? Function(String message)? showSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String message)? showError,
    TResult Function(String message)? showSuccess,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_ShowError value) showError,
    required TResult Function(_ShowSuccess value) showSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowError value)? showError,
    TResult? Function(_ShowSuccess value)? showSuccess,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowSuccess value)? showSuccess,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SketchTestPageActionCopyWith<$Res> {
  factory $SketchTestPageActionCopyWith(
    SketchTestPageAction value,
    $Res Function(SketchTestPageAction) then,
  ) = _$SketchTestPageActionCopyWithImpl<$Res, SketchTestPageAction>;
}

/// @nodoc
class _$SketchTestPageActionCopyWithImpl<
  $Res,
  $Val extends SketchTestPageAction
>
    implements $SketchTestPageActionCopyWith<$Res> {
  _$SketchTestPageActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SketchTestPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NoneImplCopyWith<$Res> {
  factory _$$NoneImplCopyWith(
    _$NoneImpl value,
    $Res Function(_$NoneImpl) then,
  ) = __$$NoneImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoneImplCopyWithImpl<$Res>
    extends _$SketchTestPageActionCopyWithImpl<$Res, _$NoneImpl>
    implements _$$NoneImplCopyWith<$Res> {
  __$$NoneImplCopyWithImpl(_$NoneImpl _value, $Res Function(_$NoneImpl) _then)
    : super(_value, _then);

  /// Create a copy of SketchTestPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoneImpl implements _None {
  const _$NoneImpl();

  @override
  String toString() {
    return 'SketchTestPageAction.none()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoneImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String message) showError,
    required TResult Function(String message) showSuccess,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String message)? showError,
    TResult? Function(String message)? showSuccess,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String message)? showError,
    TResult Function(String message)? showSuccess,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_ShowError value) showError,
    required TResult Function(_ShowSuccess value) showSuccess,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowError value)? showError,
    TResult? Function(_ShowSuccess value)? showSuccess,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowSuccess value)? showSuccess,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _None implements SketchTestPageAction {
  const factory _None() = _$NoneImpl;
}

/// @nodoc
abstract class _$$ShowErrorImplCopyWith<$Res> {
  factory _$$ShowErrorImplCopyWith(
    _$ShowErrorImpl value,
    $Res Function(_$ShowErrorImpl) then,
  ) = __$$ShowErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ShowErrorImplCopyWithImpl<$Res>
    extends _$SketchTestPageActionCopyWithImpl<$Res, _$ShowErrorImpl>
    implements _$$ShowErrorImplCopyWith<$Res> {
  __$$ShowErrorImplCopyWithImpl(
    _$ShowErrorImpl _value,
    $Res Function(_$ShowErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SketchTestPageAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ShowErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ShowErrorImpl implements _ShowError {
  const _$ShowErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SketchTestPageAction.showError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SketchTestPageAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowErrorImplCopyWith<_$ShowErrorImpl> get copyWith =>
      __$$ShowErrorImplCopyWithImpl<_$ShowErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String message) showError,
    required TResult Function(String message) showSuccess,
  }) {
    return showError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String message)? showError,
    TResult? Function(String message)? showSuccess,
  }) {
    return showError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String message)? showError,
    TResult Function(String message)? showSuccess,
    required TResult orElse(),
  }) {
    if (showError != null) {
      return showError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_ShowError value) showError,
    required TResult Function(_ShowSuccess value) showSuccess,
  }) {
    return showError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowError value)? showError,
    TResult? Function(_ShowSuccess value)? showSuccess,
  }) {
    return showError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowSuccess value)? showSuccess,
    required TResult orElse(),
  }) {
    if (showError != null) {
      return showError(this);
    }
    return orElse();
  }
}

abstract class _ShowError implements SketchTestPageAction {
  const factory _ShowError(final String message) = _$ShowErrorImpl;

  String get message;

  /// Create a copy of SketchTestPageAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowErrorImplCopyWith<_$ShowErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShowSuccessImplCopyWith<$Res> {
  factory _$$ShowSuccessImplCopyWith(
    _$ShowSuccessImpl value,
    $Res Function(_$ShowSuccessImpl) then,
  ) = __$$ShowSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ShowSuccessImplCopyWithImpl<$Res>
    extends _$SketchTestPageActionCopyWithImpl<$Res, _$ShowSuccessImpl>
    implements _$$ShowSuccessImplCopyWith<$Res> {
  __$$ShowSuccessImplCopyWithImpl(
    _$ShowSuccessImpl _value,
    $Res Function(_$ShowSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SketchTestPageAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ShowSuccessImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ShowSuccessImpl implements _ShowSuccess {
  const _$ShowSuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SketchTestPageAction.showSuccess(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SketchTestPageAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowSuccessImplCopyWith<_$ShowSuccessImpl> get copyWith =>
      __$$ShowSuccessImplCopyWithImpl<_$ShowSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String message) showError,
    required TResult Function(String message) showSuccess,
  }) {
    return showSuccess(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String message)? showError,
    TResult? Function(String message)? showSuccess,
  }) {
    return showSuccess?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String message)? showError,
    TResult Function(String message)? showSuccess,
    required TResult orElse(),
  }) {
    if (showSuccess != null) {
      return showSuccess(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_ShowError value) showError,
    required TResult Function(_ShowSuccess value) showSuccess,
  }) {
    return showSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowError value)? showError,
    TResult? Function(_ShowSuccess value)? showSuccess,
  }) {
    return showSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowSuccess value)? showSuccess,
    required TResult orElse(),
  }) {
    if (showSuccess != null) {
      return showSuccess(this);
    }
    return orElse();
  }
}

abstract class _ShowSuccess implements SketchTestPageAction {
  const factory _ShowSuccess(final String message) = _$ShowSuccessImpl;

  String get message;

  /// Create a copy of SketchTestPageAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowSuccessImplCopyWith<_$ShowSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
