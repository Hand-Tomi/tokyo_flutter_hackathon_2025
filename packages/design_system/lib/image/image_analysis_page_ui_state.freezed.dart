// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_analysis_page_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ImageAnalysisPageUiState {
  String? get selectedImagePath => throw _privateConstructorUsedError;
  bool get isAnalyzing => throw _privateConstructorUsedError;
  ImageAnalysisUi? get currentAnalysis => throw _privateConstructorUsedError;

  /// Create a copy of ImageAnalysisPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageAnalysisPageUiStateCopyWith<ImageAnalysisPageUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageAnalysisPageUiStateCopyWith<$Res> {
  factory $ImageAnalysisPageUiStateCopyWith(
    ImageAnalysisPageUiState value,
    $Res Function(ImageAnalysisPageUiState) then,
  ) = _$ImageAnalysisPageUiStateCopyWithImpl<$Res, ImageAnalysisPageUiState>;
  @useResult
  $Res call({
    String? selectedImagePath,
    bool isAnalyzing,
    ImageAnalysisUi? currentAnalysis,
  });

  $ImageAnalysisUiCopyWith<$Res>? get currentAnalysis;
}

/// @nodoc
class _$ImageAnalysisPageUiStateCopyWithImpl<
  $Res,
  $Val extends ImageAnalysisPageUiState
>
    implements $ImageAnalysisPageUiStateCopyWith<$Res> {
  _$ImageAnalysisPageUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageAnalysisPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedImagePath = freezed,
    Object? isAnalyzing = null,
    Object? currentAnalysis = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedImagePath: freezed == selectedImagePath
                ? _value.selectedImagePath
                : selectedImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAnalyzing: null == isAnalyzing
                ? _value.isAnalyzing
                : isAnalyzing // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentAnalysis: freezed == currentAnalysis
                ? _value.currentAnalysis
                : currentAnalysis // ignore: cast_nullable_to_non_nullable
                      as ImageAnalysisUi?,
          )
          as $Val,
    );
  }

  /// Create a copy of ImageAnalysisPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageAnalysisUiCopyWith<$Res>? get currentAnalysis {
    if (_value.currentAnalysis == null) {
      return null;
    }

    return $ImageAnalysisUiCopyWith<$Res>(_value.currentAnalysis!, (value) {
      return _then(_value.copyWith(currentAnalysis: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImageAnalysisPageUiStateImplCopyWith<$Res>
    implements $ImageAnalysisPageUiStateCopyWith<$Res> {
  factory _$$ImageAnalysisPageUiStateImplCopyWith(
    _$ImageAnalysisPageUiStateImpl value,
    $Res Function(_$ImageAnalysisPageUiStateImpl) then,
  ) = __$$ImageAnalysisPageUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? selectedImagePath,
    bool isAnalyzing,
    ImageAnalysisUi? currentAnalysis,
  });

  @override
  $ImageAnalysisUiCopyWith<$Res>? get currentAnalysis;
}

/// @nodoc
class __$$ImageAnalysisPageUiStateImplCopyWithImpl<$Res>
    extends
        _$ImageAnalysisPageUiStateCopyWithImpl<
          $Res,
          _$ImageAnalysisPageUiStateImpl
        >
    implements _$$ImageAnalysisPageUiStateImplCopyWith<$Res> {
  __$$ImageAnalysisPageUiStateImplCopyWithImpl(
    _$ImageAnalysisPageUiStateImpl _value,
    $Res Function(_$ImageAnalysisPageUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageAnalysisPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedImagePath = freezed,
    Object? isAnalyzing = null,
    Object? currentAnalysis = freezed,
  }) {
    return _then(
      _$ImageAnalysisPageUiStateImpl(
        selectedImagePath: freezed == selectedImagePath
            ? _value.selectedImagePath
            : selectedImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAnalyzing: null == isAnalyzing
            ? _value.isAnalyzing
            : isAnalyzing // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentAnalysis: freezed == currentAnalysis
            ? _value.currentAnalysis
            : currentAnalysis // ignore: cast_nullable_to_non_nullable
                  as ImageAnalysisUi?,
      ),
    );
  }
}

/// @nodoc

class _$ImageAnalysisPageUiStateImpl implements _ImageAnalysisPageUiState {
  const _$ImageAnalysisPageUiStateImpl({
    this.selectedImagePath = null,
    this.isAnalyzing = false,
    this.currentAnalysis = null,
  });

  @override
  @JsonKey()
  final String? selectedImagePath;
  @override
  @JsonKey()
  final bool isAnalyzing;
  @override
  @JsonKey()
  final ImageAnalysisUi? currentAnalysis;

  @override
  String toString() {
    return 'ImageAnalysisPageUiState(selectedImagePath: $selectedImagePath, isAnalyzing: $isAnalyzing, currentAnalysis: $currentAnalysis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageAnalysisPageUiStateImpl &&
            (identical(other.selectedImagePath, selectedImagePath) ||
                other.selectedImagePath == selectedImagePath) &&
            (identical(other.isAnalyzing, isAnalyzing) ||
                other.isAnalyzing == isAnalyzing) &&
            (identical(other.currentAnalysis, currentAnalysis) ||
                other.currentAnalysis == currentAnalysis));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedImagePath, isAnalyzing, currentAnalysis);

  /// Create a copy of ImageAnalysisPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageAnalysisPageUiStateImplCopyWith<_$ImageAnalysisPageUiStateImpl>
  get copyWith =>
      __$$ImageAnalysisPageUiStateImplCopyWithImpl<
        _$ImageAnalysisPageUiStateImpl
      >(this, _$identity);
}

abstract class _ImageAnalysisPageUiState implements ImageAnalysisPageUiState {
  const factory _ImageAnalysisPageUiState({
    final String? selectedImagePath,
    final bool isAnalyzing,
    final ImageAnalysisUi? currentAnalysis,
  }) = _$ImageAnalysisPageUiStateImpl;

  @override
  String? get selectedImagePath;
  @override
  bool get isAnalyzing;
  @override
  ImageAnalysisUi? get currentAnalysis;

  /// Create a copy of ImageAnalysisPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageAnalysisPageUiStateImplCopyWith<_$ImageAnalysisPageUiStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ImageAnalysisPageAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() pickImage,
    required TResult Function(ImageAnalysisUi analysis) showAnalysisResult,
    required TResult Function(String message) showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? pickImage,
    TResult? Function(ImageAnalysisUi analysis)? showAnalysisResult,
    TResult? Function(String message)? showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? pickImage,
    TResult Function(ImageAnalysisUi analysis)? showAnalysisResult,
    TResult Function(String message)? showError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_PickImage value) pickImage,
    required TResult Function(_ShowAnalysisResult value) showAnalysisResult,
    required TResult Function(_ShowError value) showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_PickImage value)? pickImage,
    TResult? Function(_ShowAnalysisResult value)? showAnalysisResult,
    TResult? Function(_ShowError value)? showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_PickImage value)? pickImage,
    TResult Function(_ShowAnalysisResult value)? showAnalysisResult,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageAnalysisPageActionCopyWith<$Res> {
  factory $ImageAnalysisPageActionCopyWith(
    ImageAnalysisPageAction value,
    $Res Function(ImageAnalysisPageAction) then,
  ) = _$ImageAnalysisPageActionCopyWithImpl<$Res, ImageAnalysisPageAction>;
}

/// @nodoc
class _$ImageAnalysisPageActionCopyWithImpl<
  $Res,
  $Val extends ImageAnalysisPageAction
>
    implements $ImageAnalysisPageActionCopyWith<$Res> {
  _$ImageAnalysisPageActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageAnalysisPageAction
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
    extends _$ImageAnalysisPageActionCopyWithImpl<$Res, _$NoneImpl>
    implements _$$NoneImplCopyWith<$Res> {
  __$$NoneImplCopyWithImpl(_$NoneImpl _value, $Res Function(_$NoneImpl) _then)
    : super(_value, _then);

  /// Create a copy of ImageAnalysisPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoneImpl implements _None {
  _$NoneImpl();

  @override
  String toString() {
    return 'ImageAnalysisPageAction.none()';
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
    required TResult Function() pickImage,
    required TResult Function(ImageAnalysisUi analysis) showAnalysisResult,
    required TResult Function(String message) showError,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? pickImage,
    TResult? Function(ImageAnalysisUi analysis)? showAnalysisResult,
    TResult? Function(String message)? showError,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? pickImage,
    TResult Function(ImageAnalysisUi analysis)? showAnalysisResult,
    TResult Function(String message)? showError,
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
    required TResult Function(_PickImage value) pickImage,
    required TResult Function(_ShowAnalysisResult value) showAnalysisResult,
    required TResult Function(_ShowError value) showError,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_PickImage value)? pickImage,
    TResult? Function(_ShowAnalysisResult value)? showAnalysisResult,
    TResult? Function(_ShowError value)? showError,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_PickImage value)? pickImage,
    TResult Function(_ShowAnalysisResult value)? showAnalysisResult,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _None implements ImageAnalysisPageAction {
  factory _None() = _$NoneImpl;
}

/// @nodoc
abstract class _$$PickImageImplCopyWith<$Res> {
  factory _$$PickImageImplCopyWith(
    _$PickImageImpl value,
    $Res Function(_$PickImageImpl) then,
  ) = __$$PickImageImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PickImageImplCopyWithImpl<$Res>
    extends _$ImageAnalysisPageActionCopyWithImpl<$Res, _$PickImageImpl>
    implements _$$PickImageImplCopyWith<$Res> {
  __$$PickImageImplCopyWithImpl(
    _$PickImageImpl _value,
    $Res Function(_$PickImageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageAnalysisPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PickImageImpl implements _PickImage {
  _$PickImageImpl();

  @override
  String toString() {
    return 'ImageAnalysisPageAction.pickImage()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PickImageImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() pickImage,
    required TResult Function(ImageAnalysisUi analysis) showAnalysisResult,
    required TResult Function(String message) showError,
  }) {
    return pickImage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? pickImage,
    TResult? Function(ImageAnalysisUi analysis)? showAnalysisResult,
    TResult? Function(String message)? showError,
  }) {
    return pickImage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? pickImage,
    TResult Function(ImageAnalysisUi analysis)? showAnalysisResult,
    TResult Function(String message)? showError,
    required TResult orElse(),
  }) {
    if (pickImage != null) {
      return pickImage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_PickImage value) pickImage,
    required TResult Function(_ShowAnalysisResult value) showAnalysisResult,
    required TResult Function(_ShowError value) showError,
  }) {
    return pickImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_PickImage value)? pickImage,
    TResult? Function(_ShowAnalysisResult value)? showAnalysisResult,
    TResult? Function(_ShowError value)? showError,
  }) {
    return pickImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_PickImage value)? pickImage,
    TResult Function(_ShowAnalysisResult value)? showAnalysisResult,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) {
    if (pickImage != null) {
      return pickImage(this);
    }
    return orElse();
  }
}

abstract class _PickImage implements ImageAnalysisPageAction {
  factory _PickImage() = _$PickImageImpl;
}

/// @nodoc
abstract class _$$ShowAnalysisResultImplCopyWith<$Res> {
  factory _$$ShowAnalysisResultImplCopyWith(
    _$ShowAnalysisResultImpl value,
    $Res Function(_$ShowAnalysisResultImpl) then,
  ) = __$$ShowAnalysisResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ImageAnalysisUi analysis});

  $ImageAnalysisUiCopyWith<$Res> get analysis;
}

/// @nodoc
class __$$ShowAnalysisResultImplCopyWithImpl<$Res>
    extends
        _$ImageAnalysisPageActionCopyWithImpl<$Res, _$ShowAnalysisResultImpl>
    implements _$$ShowAnalysisResultImplCopyWith<$Res> {
  __$$ShowAnalysisResultImplCopyWithImpl(
    _$ShowAnalysisResultImpl _value,
    $Res Function(_$ShowAnalysisResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageAnalysisPageAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? analysis = null}) {
    return _then(
      _$ShowAnalysisResultImpl(
        null == analysis
            ? _value.analysis
            : analysis // ignore: cast_nullable_to_non_nullable
                  as ImageAnalysisUi,
      ),
    );
  }

  /// Create a copy of ImageAnalysisPageAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageAnalysisUiCopyWith<$Res> get analysis {
    return $ImageAnalysisUiCopyWith<$Res>(_value.analysis, (value) {
      return _then(_value.copyWith(analysis: value));
    });
  }
}

/// @nodoc

class _$ShowAnalysisResultImpl implements _ShowAnalysisResult {
  _$ShowAnalysisResultImpl(this.analysis);

  @override
  final ImageAnalysisUi analysis;

  @override
  String toString() {
    return 'ImageAnalysisPageAction.showAnalysisResult(analysis: $analysis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowAnalysisResultImpl &&
            (identical(other.analysis, analysis) ||
                other.analysis == analysis));
  }

  @override
  int get hashCode => Object.hash(runtimeType, analysis);

  /// Create a copy of ImageAnalysisPageAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowAnalysisResultImplCopyWith<_$ShowAnalysisResultImpl> get copyWith =>
      __$$ShowAnalysisResultImplCopyWithImpl<_$ShowAnalysisResultImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() pickImage,
    required TResult Function(ImageAnalysisUi analysis) showAnalysisResult,
    required TResult Function(String message) showError,
  }) {
    return showAnalysisResult(analysis);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? pickImage,
    TResult? Function(ImageAnalysisUi analysis)? showAnalysisResult,
    TResult? Function(String message)? showError,
  }) {
    return showAnalysisResult?.call(analysis);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? pickImage,
    TResult Function(ImageAnalysisUi analysis)? showAnalysisResult,
    TResult Function(String message)? showError,
    required TResult orElse(),
  }) {
    if (showAnalysisResult != null) {
      return showAnalysisResult(analysis);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_PickImage value) pickImage,
    required TResult Function(_ShowAnalysisResult value) showAnalysisResult,
    required TResult Function(_ShowError value) showError,
  }) {
    return showAnalysisResult(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_PickImage value)? pickImage,
    TResult? Function(_ShowAnalysisResult value)? showAnalysisResult,
    TResult? Function(_ShowError value)? showError,
  }) {
    return showAnalysisResult?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_PickImage value)? pickImage,
    TResult Function(_ShowAnalysisResult value)? showAnalysisResult,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) {
    if (showAnalysisResult != null) {
      return showAnalysisResult(this);
    }
    return orElse();
  }
}

abstract class _ShowAnalysisResult implements ImageAnalysisPageAction {
  factory _ShowAnalysisResult(final ImageAnalysisUi analysis) =
      _$ShowAnalysisResultImpl;

  ImageAnalysisUi get analysis;

  /// Create a copy of ImageAnalysisPageAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowAnalysisResultImplCopyWith<_$ShowAnalysisResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$ImageAnalysisPageActionCopyWithImpl<$Res, _$ShowErrorImpl>
    implements _$$ShowErrorImplCopyWith<$Res> {
  __$$ShowErrorImplCopyWithImpl(
    _$ShowErrorImpl _value,
    $Res Function(_$ShowErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageAnalysisPageAction
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
  _$ShowErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ImageAnalysisPageAction.showError(message: $message)';
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

  /// Create a copy of ImageAnalysisPageAction
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
    required TResult Function() pickImage,
    required TResult Function(ImageAnalysisUi analysis) showAnalysisResult,
    required TResult Function(String message) showError,
  }) {
    return showError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? pickImage,
    TResult? Function(ImageAnalysisUi analysis)? showAnalysisResult,
    TResult? Function(String message)? showError,
  }) {
    return showError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? pickImage,
    TResult Function(ImageAnalysisUi analysis)? showAnalysisResult,
    TResult Function(String message)? showError,
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
    required TResult Function(_PickImage value) pickImage,
    required TResult Function(_ShowAnalysisResult value) showAnalysisResult,
    required TResult Function(_ShowError value) showError,
  }) {
    return showError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_PickImage value)? pickImage,
    TResult? Function(_ShowAnalysisResult value)? showAnalysisResult,
    TResult? Function(_ShowError value)? showError,
  }) {
    return showError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_PickImage value)? pickImage,
    TResult Function(_ShowAnalysisResult value)? showAnalysisResult,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) {
    if (showError != null) {
      return showError(this);
    }
    return orElse();
  }
}

abstract class _ShowError implements ImageAnalysisPageAction {
  factory _ShowError(final String message) = _$ShowErrorImpl;

  String get message;

  /// Create a copy of ImageAnalysisPageAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowErrorImplCopyWith<_$ShowErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
