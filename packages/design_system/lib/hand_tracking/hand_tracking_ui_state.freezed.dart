// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hand_tracking_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HandTrackingPageUiState {
  String get statusMessage => throw _privateConstructorUsedError;
  String get gestureInfo => throw _privateConstructorUsedError;
  List<HandLandmarkUi> get landmarks => throw _privateConstructorUsedError;
  bool get isInitialized => throw _privateConstructorUsedError;
  bool get showSettings => throw _privateConstructorUsedError;
  int get frameSkip => throw _privateConstructorUsedError;
  ResolutionPresetUi get resolution => throw _privateConstructorUsedError;
  Size? get previewSize => throw _privateConstructorUsedError;
  int? get sensorOrientation =>
      throw _privateConstructorUsedError; // Drawing mode state
  bool get isDrawingMode => throw _privateConstructorUsedError;
  List<DrawingPathUi> get drawingPaths => throw _privateConstructorUsedError;
  List<Offset> get currentPath => throw _privateConstructorUsedError;
  bool get isFingerDown => throw _privateConstructorUsedError;

  /// Create a copy of HandTrackingPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HandTrackingPageUiStateCopyWith<HandTrackingPageUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HandTrackingPageUiStateCopyWith<$Res> {
  factory $HandTrackingPageUiStateCopyWith(
    HandTrackingPageUiState value,
    $Res Function(HandTrackingPageUiState) then,
  ) = _$HandTrackingPageUiStateCopyWithImpl<$Res, HandTrackingPageUiState>;
  @useResult
  $Res call({
    String statusMessage,
    String gestureInfo,
    List<HandLandmarkUi> landmarks,
    bool isInitialized,
    bool showSettings,
    int frameSkip,
    ResolutionPresetUi resolution,
    Size? previewSize,
    int? sensorOrientation,
    bool isDrawingMode,
    List<DrawingPathUi> drawingPaths,
    List<Offset> currentPath,
    bool isFingerDown,
  });
}

/// @nodoc
class _$HandTrackingPageUiStateCopyWithImpl<
  $Res,
  $Val extends HandTrackingPageUiState
>
    implements $HandTrackingPageUiStateCopyWith<$Res> {
  _$HandTrackingPageUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HandTrackingPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusMessage = null,
    Object? gestureInfo = null,
    Object? landmarks = null,
    Object? isInitialized = null,
    Object? showSettings = null,
    Object? frameSkip = null,
    Object? resolution = null,
    Object? previewSize = freezed,
    Object? sensorOrientation = freezed,
    Object? isDrawingMode = null,
    Object? drawingPaths = null,
    Object? currentPath = null,
    Object? isFingerDown = null,
  }) {
    return _then(
      _value.copyWith(
            statusMessage: null == statusMessage
                ? _value.statusMessage
                : statusMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            gestureInfo: null == gestureInfo
                ? _value.gestureInfo
                : gestureInfo // ignore: cast_nullable_to_non_nullable
                      as String,
            landmarks: null == landmarks
                ? _value.landmarks
                : landmarks // ignore: cast_nullable_to_non_nullable
                      as List<HandLandmarkUi>,
            isInitialized: null == isInitialized
                ? _value.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                      as bool,
            showSettings: null == showSettings
                ? _value.showSettings
                : showSettings // ignore: cast_nullable_to_non_nullable
                      as bool,
            frameSkip: null == frameSkip
                ? _value.frameSkip
                : frameSkip // ignore: cast_nullable_to_non_nullable
                      as int,
            resolution: null == resolution
                ? _value.resolution
                : resolution // ignore: cast_nullable_to_non_nullable
                      as ResolutionPresetUi,
            previewSize: freezed == previewSize
                ? _value.previewSize
                : previewSize // ignore: cast_nullable_to_non_nullable
                      as Size?,
            sensorOrientation: freezed == sensorOrientation
                ? _value.sensorOrientation
                : sensorOrientation // ignore: cast_nullable_to_non_nullable
                      as int?,
            isDrawingMode: null == isDrawingMode
                ? _value.isDrawingMode
                : isDrawingMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            drawingPaths: null == drawingPaths
                ? _value.drawingPaths
                : drawingPaths // ignore: cast_nullable_to_non_nullable
                      as List<DrawingPathUi>,
            currentPath: null == currentPath
                ? _value.currentPath
                : currentPath // ignore: cast_nullable_to_non_nullable
                      as List<Offset>,
            isFingerDown: null == isFingerDown
                ? _value.isFingerDown
                : isFingerDown // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HandTrackingPageUiStateImplCopyWith<$Res>
    implements $HandTrackingPageUiStateCopyWith<$Res> {
  factory _$$HandTrackingPageUiStateImplCopyWith(
    _$HandTrackingPageUiStateImpl value,
    $Res Function(_$HandTrackingPageUiStateImpl) then,
  ) = __$$HandTrackingPageUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String statusMessage,
    String gestureInfo,
    List<HandLandmarkUi> landmarks,
    bool isInitialized,
    bool showSettings,
    int frameSkip,
    ResolutionPresetUi resolution,
    Size? previewSize,
    int? sensorOrientation,
    bool isDrawingMode,
    List<DrawingPathUi> drawingPaths,
    List<Offset> currentPath,
    bool isFingerDown,
  });
}

/// @nodoc
class __$$HandTrackingPageUiStateImplCopyWithImpl<$Res>
    extends
        _$HandTrackingPageUiStateCopyWithImpl<
          $Res,
          _$HandTrackingPageUiStateImpl
        >
    implements _$$HandTrackingPageUiStateImplCopyWith<$Res> {
  __$$HandTrackingPageUiStateImplCopyWithImpl(
    _$HandTrackingPageUiStateImpl _value,
    $Res Function(_$HandTrackingPageUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HandTrackingPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusMessage = null,
    Object? gestureInfo = null,
    Object? landmarks = null,
    Object? isInitialized = null,
    Object? showSettings = null,
    Object? frameSkip = null,
    Object? resolution = null,
    Object? previewSize = freezed,
    Object? sensorOrientation = freezed,
    Object? isDrawingMode = null,
    Object? drawingPaths = null,
    Object? currentPath = null,
    Object? isFingerDown = null,
  }) {
    return _then(
      _$HandTrackingPageUiStateImpl(
        statusMessage: null == statusMessage
            ? _value.statusMessage
            : statusMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        gestureInfo: null == gestureInfo
            ? _value.gestureInfo
            : gestureInfo // ignore: cast_nullable_to_non_nullable
                  as String,
        landmarks: null == landmarks
            ? _value._landmarks
            : landmarks // ignore: cast_nullable_to_non_nullable
                  as List<HandLandmarkUi>,
        isInitialized: null == isInitialized
            ? _value.isInitialized
            : isInitialized // ignore: cast_nullable_to_non_nullable
                  as bool,
        showSettings: null == showSettings
            ? _value.showSettings
            : showSettings // ignore: cast_nullable_to_non_nullable
                  as bool,
        frameSkip: null == frameSkip
            ? _value.frameSkip
            : frameSkip // ignore: cast_nullable_to_non_nullable
                  as int,
        resolution: null == resolution
            ? _value.resolution
            : resolution // ignore: cast_nullable_to_non_nullable
                  as ResolutionPresetUi,
        previewSize: freezed == previewSize
            ? _value.previewSize
            : previewSize // ignore: cast_nullable_to_non_nullable
                  as Size?,
        sensorOrientation: freezed == sensorOrientation
            ? _value.sensorOrientation
            : sensorOrientation // ignore: cast_nullable_to_non_nullable
                  as int?,
        isDrawingMode: null == isDrawingMode
            ? _value.isDrawingMode
            : isDrawingMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        drawingPaths: null == drawingPaths
            ? _value._drawingPaths
            : drawingPaths // ignore: cast_nullable_to_non_nullable
                  as List<DrawingPathUi>,
        currentPath: null == currentPath
            ? _value._currentPath
            : currentPath // ignore: cast_nullable_to_non_nullable
                  as List<Offset>,
        isFingerDown: null == isFingerDown
            ? _value.isFingerDown
            : isFingerDown // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$HandTrackingPageUiStateImpl implements _HandTrackingPageUiState {
  const _$HandTrackingPageUiStateImpl({
    this.statusMessage = 'Initializing...',
    this.gestureInfo = '',
    final List<HandLandmarkUi> landmarks = const [],
    this.isInitialized = false,
    this.showSettings = false,
    this.frameSkip = 2,
    this.resolution = ResolutionPresetUi.medium,
    this.previewSize,
    this.sensorOrientation,
    this.isDrawingMode = false,
    final List<DrawingPathUi> drawingPaths = const [],
    final List<Offset> currentPath = const [],
    this.isFingerDown = false,
  }) : _landmarks = landmarks,
       _drawingPaths = drawingPaths,
       _currentPath = currentPath;

  @override
  @JsonKey()
  final String statusMessage;
  @override
  @JsonKey()
  final String gestureInfo;
  final List<HandLandmarkUi> _landmarks;
  @override
  @JsonKey()
  List<HandLandmarkUi> get landmarks {
    if (_landmarks is EqualUnmodifiableListView) return _landmarks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_landmarks);
  }

  @override
  @JsonKey()
  final bool isInitialized;
  @override
  @JsonKey()
  final bool showSettings;
  @override
  @JsonKey()
  final int frameSkip;
  @override
  @JsonKey()
  final ResolutionPresetUi resolution;
  @override
  final Size? previewSize;
  @override
  final int? sensorOrientation;
  // Drawing mode state
  @override
  @JsonKey()
  final bool isDrawingMode;
  final List<DrawingPathUi> _drawingPaths;
  @override
  @JsonKey()
  List<DrawingPathUi> get drawingPaths {
    if (_drawingPaths is EqualUnmodifiableListView) return _drawingPaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_drawingPaths);
  }

  final List<Offset> _currentPath;
  @override
  @JsonKey()
  List<Offset> get currentPath {
    if (_currentPath is EqualUnmodifiableListView) return _currentPath;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentPath);
  }

  @override
  @JsonKey()
  final bool isFingerDown;

  @override
  String toString() {
    return 'HandTrackingPageUiState(statusMessage: $statusMessage, gestureInfo: $gestureInfo, landmarks: $landmarks, isInitialized: $isInitialized, showSettings: $showSettings, frameSkip: $frameSkip, resolution: $resolution, previewSize: $previewSize, sensorOrientation: $sensorOrientation, isDrawingMode: $isDrawingMode, drawingPaths: $drawingPaths, currentPath: $currentPath, isFingerDown: $isFingerDown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HandTrackingPageUiStateImpl &&
            (identical(other.statusMessage, statusMessage) ||
                other.statusMessage == statusMessage) &&
            (identical(other.gestureInfo, gestureInfo) ||
                other.gestureInfo == gestureInfo) &&
            const DeepCollectionEquality().equals(
              other._landmarks,
              _landmarks,
            ) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.showSettings, showSettings) ||
                other.showSettings == showSettings) &&
            (identical(other.frameSkip, frameSkip) ||
                other.frameSkip == frameSkip) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.previewSize, previewSize) ||
                other.previewSize == previewSize) &&
            (identical(other.sensorOrientation, sensorOrientation) ||
                other.sensorOrientation == sensorOrientation) &&
            (identical(other.isDrawingMode, isDrawingMode) ||
                other.isDrawingMode == isDrawingMode) &&
            const DeepCollectionEquality().equals(
              other._drawingPaths,
              _drawingPaths,
            ) &&
            const DeepCollectionEquality().equals(
              other._currentPath,
              _currentPath,
            ) &&
            (identical(other.isFingerDown, isFingerDown) ||
                other.isFingerDown == isFingerDown));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    statusMessage,
    gestureInfo,
    const DeepCollectionEquality().hash(_landmarks),
    isInitialized,
    showSettings,
    frameSkip,
    resolution,
    previewSize,
    sensorOrientation,
    isDrawingMode,
    const DeepCollectionEquality().hash(_drawingPaths),
    const DeepCollectionEquality().hash(_currentPath),
    isFingerDown,
  );

  /// Create a copy of HandTrackingPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HandTrackingPageUiStateImplCopyWith<_$HandTrackingPageUiStateImpl>
  get copyWith =>
      __$$HandTrackingPageUiStateImplCopyWithImpl<
        _$HandTrackingPageUiStateImpl
      >(this, _$identity);
}

abstract class _HandTrackingPageUiState implements HandTrackingPageUiState {
  const factory _HandTrackingPageUiState({
    final String statusMessage,
    final String gestureInfo,
    final List<HandLandmarkUi> landmarks,
    final bool isInitialized,
    final bool showSettings,
    final int frameSkip,
    final ResolutionPresetUi resolution,
    final Size? previewSize,
    final int? sensorOrientation,
    final bool isDrawingMode,
    final List<DrawingPathUi> drawingPaths,
    final List<Offset> currentPath,
    final bool isFingerDown,
  }) = _$HandTrackingPageUiStateImpl;

  @override
  String get statusMessage;
  @override
  String get gestureInfo;
  @override
  List<HandLandmarkUi> get landmarks;
  @override
  bool get isInitialized;
  @override
  bool get showSettings;
  @override
  int get frameSkip;
  @override
  ResolutionPresetUi get resolution;
  @override
  Size? get previewSize;
  @override
  int? get sensorOrientation; // Drawing mode state
  @override
  bool get isDrawingMode;
  @override
  List<DrawingPathUi> get drawingPaths;
  @override
  List<Offset> get currentPath;
  @override
  bool get isFingerDown;

  /// Create a copy of HandTrackingPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HandTrackingPageUiStateImplCopyWith<_$HandTrackingPageUiStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DrawingPathUi {
  List<Offset> get points => throw _privateConstructorUsedError;
  double get strokeWidth => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;

  /// Create a copy of DrawingPathUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrawingPathUiCopyWith<DrawingPathUi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawingPathUiCopyWith<$Res> {
  factory $DrawingPathUiCopyWith(
    DrawingPathUi value,
    $Res Function(DrawingPathUi) then,
  ) = _$DrawingPathUiCopyWithImpl<$Res, DrawingPathUi>;
  @useResult
  $Res call({List<Offset> points, double strokeWidth, Color color});
}

/// @nodoc
class _$DrawingPathUiCopyWithImpl<$Res, $Val extends DrawingPathUi>
    implements $DrawingPathUiCopyWith<$Res> {
  _$DrawingPathUiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrawingPathUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? points = null,
    Object? strokeWidth = null,
    Object? color = null,
  }) {
    return _then(
      _value.copyWith(
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as List<Offset>,
            strokeWidth: null == strokeWidth
                ? _value.strokeWidth
                : strokeWidth // ignore: cast_nullable_to_non_nullable
                      as double,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as Color,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DrawingPathUiImplCopyWith<$Res>
    implements $DrawingPathUiCopyWith<$Res> {
  factory _$$DrawingPathUiImplCopyWith(
    _$DrawingPathUiImpl value,
    $Res Function(_$DrawingPathUiImpl) then,
  ) = __$$DrawingPathUiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Offset> points, double strokeWidth, Color color});
}

/// @nodoc
class __$$DrawingPathUiImplCopyWithImpl<$Res>
    extends _$DrawingPathUiCopyWithImpl<$Res, _$DrawingPathUiImpl>
    implements _$$DrawingPathUiImplCopyWith<$Res> {
  __$$DrawingPathUiImplCopyWithImpl(
    _$DrawingPathUiImpl _value,
    $Res Function(_$DrawingPathUiImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrawingPathUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? points = null,
    Object? strokeWidth = null,
    Object? color = null,
  }) {
    return _then(
      _$DrawingPathUiImpl(
        points: null == points
            ? _value._points
            : points // ignore: cast_nullable_to_non_nullable
                  as List<Offset>,
        strokeWidth: null == strokeWidth
            ? _value.strokeWidth
            : strokeWidth // ignore: cast_nullable_to_non_nullable
                  as double,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as Color,
      ),
    );
  }
}

/// @nodoc

class _$DrawingPathUiImpl implements _DrawingPathUi {
  const _$DrawingPathUiImpl({
    required final List<Offset> points,
    this.strokeWidth = 3.0,
    this.color = const Color(0xFF000000),
  }) : _points = points;

  final List<Offset> _points;
  @override
  List<Offset> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final Color color;

  @override
  String toString() {
    return 'DrawingPathUi(points: $points, strokeWidth: $strokeWidth, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawingPathUiImpl &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_points),
    strokeWidth,
    color,
  );

  /// Create a copy of DrawingPathUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawingPathUiImplCopyWith<_$DrawingPathUiImpl> get copyWith =>
      __$$DrawingPathUiImplCopyWithImpl<_$DrawingPathUiImpl>(this, _$identity);
}

abstract class _DrawingPathUi implements DrawingPathUi {
  const factory _DrawingPathUi({
    required final List<Offset> points,
    final double strokeWidth,
    final Color color,
  }) = _$DrawingPathUiImpl;

  @override
  List<Offset> get points;
  @override
  double get strokeWidth;
  @override
  Color get color;

  /// Create a copy of DrawingPathUi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrawingPathUiImplCopyWith<_$DrawingPathUiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HandTrackingPageAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String message) showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String message)? showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String message)? showError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_ShowError value) showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowError value)? showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HandTrackingPageActionCopyWith<$Res> {
  factory $HandTrackingPageActionCopyWith(
    HandTrackingPageAction value,
    $Res Function(HandTrackingPageAction) then,
  ) = _$HandTrackingPageActionCopyWithImpl<$Res, HandTrackingPageAction>;
}

/// @nodoc
class _$HandTrackingPageActionCopyWithImpl<
  $Res,
  $Val extends HandTrackingPageAction
>
    implements $HandTrackingPageActionCopyWith<$Res> {
  _$HandTrackingPageActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HandTrackingPageAction
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
    extends _$HandTrackingPageActionCopyWithImpl<$Res, _$NoneImpl>
    implements _$$NoneImplCopyWith<$Res> {
  __$$NoneImplCopyWithImpl(_$NoneImpl _value, $Res Function(_$NoneImpl) _then)
    : super(_value, _then);

  /// Create a copy of HandTrackingPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoneImpl implements _None {
  _$NoneImpl();

  @override
  String toString() {
    return 'HandTrackingPageAction.none()';
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
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String message)? showError,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
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
    required TResult Function(_ShowError value) showError,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowError value)? showError,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _None implements HandTrackingPageAction {
  factory _None() = _$NoneImpl;
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
    extends _$HandTrackingPageActionCopyWithImpl<$Res, _$ShowErrorImpl>
    implements _$$ShowErrorImplCopyWith<$Res> {
  __$$ShowErrorImplCopyWithImpl(
    _$ShowErrorImpl _value,
    $Res Function(_$ShowErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HandTrackingPageAction
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
    return 'HandTrackingPageAction.showError(message: $message)';
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

  /// Create a copy of HandTrackingPageAction
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
  }) {
    return showError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String message)? showError,
  }) {
    return showError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
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
    required TResult Function(_ShowError value) showError,
  }) {
    return showError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowError value)? showError,
  }) {
    return showError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) {
    if (showError != null) {
      return showError(this);
    }
    return orElse();
  }
}

abstract class _ShowError implements HandTrackingPageAction {
  factory _ShowError(final String message) = _$ShowErrorImpl;

  String get message;

  /// Create a copy of HandTrackingPageAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowErrorImplCopyWith<_$ShowErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HandLandmarkUi {
  List<LandmarkPointUi> get points => throw _privateConstructorUsedError;

  /// Create a copy of HandLandmarkUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HandLandmarkUiCopyWith<HandLandmarkUi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HandLandmarkUiCopyWith<$Res> {
  factory $HandLandmarkUiCopyWith(
    HandLandmarkUi value,
    $Res Function(HandLandmarkUi) then,
  ) = _$HandLandmarkUiCopyWithImpl<$Res, HandLandmarkUi>;
  @useResult
  $Res call({List<LandmarkPointUi> points});
}

/// @nodoc
class _$HandLandmarkUiCopyWithImpl<$Res, $Val extends HandLandmarkUi>
    implements $HandLandmarkUiCopyWith<$Res> {
  _$HandLandmarkUiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HandLandmarkUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? points = null}) {
    return _then(
      _value.copyWith(
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as List<LandmarkPointUi>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HandLandmarkUiImplCopyWith<$Res>
    implements $HandLandmarkUiCopyWith<$Res> {
  factory _$$HandLandmarkUiImplCopyWith(
    _$HandLandmarkUiImpl value,
    $Res Function(_$HandLandmarkUiImpl) then,
  ) = __$$HandLandmarkUiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LandmarkPointUi> points});
}

/// @nodoc
class __$$HandLandmarkUiImplCopyWithImpl<$Res>
    extends _$HandLandmarkUiCopyWithImpl<$Res, _$HandLandmarkUiImpl>
    implements _$$HandLandmarkUiImplCopyWith<$Res> {
  __$$HandLandmarkUiImplCopyWithImpl(
    _$HandLandmarkUiImpl _value,
    $Res Function(_$HandLandmarkUiImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HandLandmarkUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? points = null}) {
    return _then(
      _$HandLandmarkUiImpl(
        points: null == points
            ? _value._points
            : points // ignore: cast_nullable_to_non_nullable
                  as List<LandmarkPointUi>,
      ),
    );
  }
}

/// @nodoc

class _$HandLandmarkUiImpl implements _HandLandmarkUi {
  const _$HandLandmarkUiImpl({required final List<LandmarkPointUi> points})
    : _points = points;

  final List<LandmarkPointUi> _points;
  @override
  List<LandmarkPointUi> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  String toString() {
    return 'HandLandmarkUi(points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HandLandmarkUiImpl &&
            const DeepCollectionEquality().equals(other._points, _points));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_points));

  /// Create a copy of HandLandmarkUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HandLandmarkUiImplCopyWith<_$HandLandmarkUiImpl> get copyWith =>
      __$$HandLandmarkUiImplCopyWithImpl<_$HandLandmarkUiImpl>(
        this,
        _$identity,
      );
}

abstract class _HandLandmarkUi implements HandLandmarkUi {
  const factory _HandLandmarkUi({required final List<LandmarkPointUi> points}) =
      _$HandLandmarkUiImpl;

  @override
  List<LandmarkPointUi> get points;

  /// Create a copy of HandLandmarkUi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HandLandmarkUiImplCopyWith<_$HandLandmarkUiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LandmarkPointUi {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get z => throw _privateConstructorUsedError;

  /// Create a copy of LandmarkPointUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LandmarkPointUiCopyWith<LandmarkPointUi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LandmarkPointUiCopyWith<$Res> {
  factory $LandmarkPointUiCopyWith(
    LandmarkPointUi value,
    $Res Function(LandmarkPointUi) then,
  ) = _$LandmarkPointUiCopyWithImpl<$Res, LandmarkPointUi>;
  @useResult
  $Res call({double x, double y, double z});
}

/// @nodoc
class _$LandmarkPointUiCopyWithImpl<$Res, $Val extends LandmarkPointUi>
    implements $LandmarkPointUiCopyWith<$Res> {
  _$LandmarkPointUiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LandmarkPointUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? x = null, Object? y = null, Object? z = null}) {
    return _then(
      _value.copyWith(
            x: null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                      as double,
            y: null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                      as double,
            z: null == z
                ? _value.z
                : z // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LandmarkPointUiImplCopyWith<$Res>
    implements $LandmarkPointUiCopyWith<$Res> {
  factory _$$LandmarkPointUiImplCopyWith(
    _$LandmarkPointUiImpl value,
    $Res Function(_$LandmarkPointUiImpl) then,
  ) = __$$LandmarkPointUiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y, double z});
}

/// @nodoc
class __$$LandmarkPointUiImplCopyWithImpl<$Res>
    extends _$LandmarkPointUiCopyWithImpl<$Res, _$LandmarkPointUiImpl>
    implements _$$LandmarkPointUiImplCopyWith<$Res> {
  __$$LandmarkPointUiImplCopyWithImpl(
    _$LandmarkPointUiImpl _value,
    $Res Function(_$LandmarkPointUiImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LandmarkPointUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? x = null, Object? y = null, Object? z = null}) {
    return _then(
      _$LandmarkPointUiImpl(
        x: null == x
            ? _value.x
            : x // ignore: cast_nullable_to_non_nullable
                  as double,
        y: null == y
            ? _value.y
            : y // ignore: cast_nullable_to_non_nullable
                  as double,
        z: null == z
            ? _value.z
            : z // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$LandmarkPointUiImpl implements _LandmarkPointUi {
  const _$LandmarkPointUiImpl({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  final double x;
  @override
  final double y;
  @override
  final double z;

  @override
  String toString() {
    return 'LandmarkPointUi(x: $x, y: $y, z: $z)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LandmarkPointUiImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.z, z) || other.z == z));
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, y, z);

  /// Create a copy of LandmarkPointUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LandmarkPointUiImplCopyWith<_$LandmarkPointUiImpl> get copyWith =>
      __$$LandmarkPointUiImplCopyWithImpl<_$LandmarkPointUiImpl>(
        this,
        _$identity,
      );
}

abstract class _LandmarkPointUi implements LandmarkPointUi {
  const factory _LandmarkPointUi({
    required final double x,
    required final double y,
    required final double z,
  }) = _$LandmarkPointUiImpl;

  @override
  double get x;
  @override
  double get y;
  @override
  double get z;

  /// Create a copy of LandmarkPointUi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LandmarkPointUiImplCopyWith<_$LandmarkPointUiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
