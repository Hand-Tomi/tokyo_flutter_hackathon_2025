// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hand_tracking_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HandTrackingPageUiState {

 String get statusMessage; String get gestureInfo; List<HandLandmarkUi> get landmarks; bool get isInitialized; bool get showSettings; int get frameSkip; ResolutionPresetUi get resolution; Size? get previewSize; int? get sensorOrientation;
/// Create a copy of HandTrackingPageUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandTrackingPageUiStateCopyWith<HandTrackingPageUiState> get copyWith => _$HandTrackingPageUiStateCopyWithImpl<HandTrackingPageUiState>(this as HandTrackingPageUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandTrackingPageUiState&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&(identical(other.gestureInfo, gestureInfo) || other.gestureInfo == gestureInfo)&&const DeepCollectionEquality().equals(other.landmarks, landmarks)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.showSettings, showSettings) || other.showSettings == showSettings)&&(identical(other.frameSkip, frameSkip) || other.frameSkip == frameSkip)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.previewSize, previewSize) || other.previewSize == previewSize)&&(identical(other.sensorOrientation, sensorOrientation) || other.sensorOrientation == sensorOrientation));
}


@override
int get hashCode => Object.hash(runtimeType,statusMessage,gestureInfo,const DeepCollectionEquality().hash(landmarks),isInitialized,showSettings,frameSkip,resolution,previewSize,sensorOrientation);

@override
String toString() {
  return 'HandTrackingPageUiState(statusMessage: $statusMessage, gestureInfo: $gestureInfo, landmarks: $landmarks, isInitialized: $isInitialized, showSettings: $showSettings, frameSkip: $frameSkip, resolution: $resolution, previewSize: $previewSize, sensorOrientation: $sensorOrientation)';
}


}

/// @nodoc
abstract mixin class $HandTrackingPageUiStateCopyWith<$Res>  {
  factory $HandTrackingPageUiStateCopyWith(HandTrackingPageUiState value, $Res Function(HandTrackingPageUiState) _then) = _$HandTrackingPageUiStateCopyWithImpl;
@useResult
$Res call({
 String statusMessage, String gestureInfo, List<HandLandmarkUi> landmarks, bool isInitialized, bool showSettings, int frameSkip, ResolutionPresetUi resolution, Size? previewSize, int? sensorOrientation
});




}
/// @nodoc
class _$HandTrackingPageUiStateCopyWithImpl<$Res>
    implements $HandTrackingPageUiStateCopyWith<$Res> {
  _$HandTrackingPageUiStateCopyWithImpl(this._self, this._then);

  final HandTrackingPageUiState _self;
  final $Res Function(HandTrackingPageUiState) _then;

/// Create a copy of HandTrackingPageUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusMessage = null,Object? gestureInfo = null,Object? landmarks = null,Object? isInitialized = null,Object? showSettings = null,Object? frameSkip = null,Object? resolution = null,Object? previewSize = freezed,Object? sensorOrientation = freezed,}) {
  return _then(_self.copyWith(
statusMessage: null == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String,gestureInfo: null == gestureInfo ? _self.gestureInfo : gestureInfo // ignore: cast_nullable_to_non_nullable
as String,landmarks: null == landmarks ? _self.landmarks : landmarks // ignore: cast_nullable_to_non_nullable
as List<HandLandmarkUi>,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,showSettings: null == showSettings ? _self.showSettings : showSettings // ignore: cast_nullable_to_non_nullable
as bool,frameSkip: null == frameSkip ? _self.frameSkip : frameSkip // ignore: cast_nullable_to_non_nullable
as int,resolution: null == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as ResolutionPresetUi,previewSize: freezed == previewSize ? _self.previewSize : previewSize // ignore: cast_nullable_to_non_nullable
as Size?,sensorOrientation: freezed == sensorOrientation ? _self.sensorOrientation : sensorOrientation // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [HandTrackingPageUiState].
extension HandTrackingPageUiStatePatterns on HandTrackingPageUiState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HandTrackingPageUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HandTrackingPageUiState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HandTrackingPageUiState value)  $default,){
final _that = this;
switch (_that) {
case _HandTrackingPageUiState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HandTrackingPageUiState value)?  $default,){
final _that = this;
switch (_that) {
case _HandTrackingPageUiState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String statusMessage,  String gestureInfo,  List<HandLandmarkUi> landmarks,  bool isInitialized,  bool showSettings,  int frameSkip,  ResolutionPresetUi resolution,  Size? previewSize,  int? sensorOrientation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HandTrackingPageUiState() when $default != null:
return $default(_that.statusMessage,_that.gestureInfo,_that.landmarks,_that.isInitialized,_that.showSettings,_that.frameSkip,_that.resolution,_that.previewSize,_that.sensorOrientation);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String statusMessage,  String gestureInfo,  List<HandLandmarkUi> landmarks,  bool isInitialized,  bool showSettings,  int frameSkip,  ResolutionPresetUi resolution,  Size? previewSize,  int? sensorOrientation)  $default,) {final _that = this;
switch (_that) {
case _HandTrackingPageUiState():
return $default(_that.statusMessage,_that.gestureInfo,_that.landmarks,_that.isInitialized,_that.showSettings,_that.frameSkip,_that.resolution,_that.previewSize,_that.sensorOrientation);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String statusMessage,  String gestureInfo,  List<HandLandmarkUi> landmarks,  bool isInitialized,  bool showSettings,  int frameSkip,  ResolutionPresetUi resolution,  Size? previewSize,  int? sensorOrientation)?  $default,) {final _that = this;
switch (_that) {
case _HandTrackingPageUiState() when $default != null:
return $default(_that.statusMessage,_that.gestureInfo,_that.landmarks,_that.isInitialized,_that.showSettings,_that.frameSkip,_that.resolution,_that.previewSize,_that.sensorOrientation);case _:
  return null;

}
}

}

/// @nodoc


class _HandTrackingPageUiState implements HandTrackingPageUiState {
  const _HandTrackingPageUiState({this.statusMessage = 'Initializing...', this.gestureInfo = '', final  List<HandLandmarkUi> landmarks = const [], this.isInitialized = false, this.showSettings = false, this.frameSkip = 2, this.resolution = ResolutionPresetUi.medium, this.previewSize, this.sensorOrientation}): _landmarks = landmarks;
  

@override@JsonKey() final  String statusMessage;
@override@JsonKey() final  String gestureInfo;
 final  List<HandLandmarkUi> _landmarks;
@override@JsonKey() List<HandLandmarkUi> get landmarks {
  if (_landmarks is EqualUnmodifiableListView) return _landmarks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_landmarks);
}

@override@JsonKey() final  bool isInitialized;
@override@JsonKey() final  bool showSettings;
@override@JsonKey() final  int frameSkip;
@override@JsonKey() final  ResolutionPresetUi resolution;
@override final  Size? previewSize;
@override final  int? sensorOrientation;

/// Create a copy of HandTrackingPageUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HandTrackingPageUiStateCopyWith<_HandTrackingPageUiState> get copyWith => __$HandTrackingPageUiStateCopyWithImpl<_HandTrackingPageUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HandTrackingPageUiState&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&(identical(other.gestureInfo, gestureInfo) || other.gestureInfo == gestureInfo)&&const DeepCollectionEquality().equals(other._landmarks, _landmarks)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.showSettings, showSettings) || other.showSettings == showSettings)&&(identical(other.frameSkip, frameSkip) || other.frameSkip == frameSkip)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.previewSize, previewSize) || other.previewSize == previewSize)&&(identical(other.sensorOrientation, sensorOrientation) || other.sensorOrientation == sensorOrientation));
}


@override
int get hashCode => Object.hash(runtimeType,statusMessage,gestureInfo,const DeepCollectionEquality().hash(_landmarks),isInitialized,showSettings,frameSkip,resolution,previewSize,sensorOrientation);

@override
String toString() {
  return 'HandTrackingPageUiState(statusMessage: $statusMessage, gestureInfo: $gestureInfo, landmarks: $landmarks, isInitialized: $isInitialized, showSettings: $showSettings, frameSkip: $frameSkip, resolution: $resolution, previewSize: $previewSize, sensorOrientation: $sensorOrientation)';
}


}

/// @nodoc
abstract mixin class _$HandTrackingPageUiStateCopyWith<$Res> implements $HandTrackingPageUiStateCopyWith<$Res> {
  factory _$HandTrackingPageUiStateCopyWith(_HandTrackingPageUiState value, $Res Function(_HandTrackingPageUiState) _then) = __$HandTrackingPageUiStateCopyWithImpl;
@override @useResult
$Res call({
 String statusMessage, String gestureInfo, List<HandLandmarkUi> landmarks, bool isInitialized, bool showSettings, int frameSkip, ResolutionPresetUi resolution, Size? previewSize, int? sensorOrientation
});




}
/// @nodoc
class __$HandTrackingPageUiStateCopyWithImpl<$Res>
    implements _$HandTrackingPageUiStateCopyWith<$Res> {
  __$HandTrackingPageUiStateCopyWithImpl(this._self, this._then);

  final _HandTrackingPageUiState _self;
  final $Res Function(_HandTrackingPageUiState) _then;

/// Create a copy of HandTrackingPageUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusMessage = null,Object? gestureInfo = null,Object? landmarks = null,Object? isInitialized = null,Object? showSettings = null,Object? frameSkip = null,Object? resolution = null,Object? previewSize = freezed,Object? sensorOrientation = freezed,}) {
  return _then(_HandTrackingPageUiState(
statusMessage: null == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String,gestureInfo: null == gestureInfo ? _self.gestureInfo : gestureInfo // ignore: cast_nullable_to_non_nullable
as String,landmarks: null == landmarks ? _self._landmarks : landmarks // ignore: cast_nullable_to_non_nullable
as List<HandLandmarkUi>,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,showSettings: null == showSettings ? _self.showSettings : showSettings // ignore: cast_nullable_to_non_nullable
as bool,frameSkip: null == frameSkip ? _self.frameSkip : frameSkip // ignore: cast_nullable_to_non_nullable
as int,resolution: null == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as ResolutionPresetUi,previewSize: freezed == previewSize ? _self.previewSize : previewSize // ignore: cast_nullable_to_non_nullable
as Size?,sensorOrientation: freezed == sensorOrientation ? _self.sensorOrientation : sensorOrientation // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$HandTrackingPageAction {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandTrackingPageAction);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HandTrackingPageAction()';
}


}

/// @nodoc
class $HandTrackingPageActionCopyWith<$Res>  {
$HandTrackingPageActionCopyWith(HandTrackingPageAction _, $Res Function(HandTrackingPageAction) __);
}


/// Adds pattern-matching-related methods to [HandTrackingPageAction].
extension HandTrackingPageActionPatterns on HandTrackingPageAction {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _None value)?  none,TResult Function( _ShowError value)?  showError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _None() when none != null:
return none(_that);case _ShowError() when showError != null:
return showError(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _None value)  none,required TResult Function( _ShowError value)  showError,}){
final _that = this;
switch (_that) {
case _None():
return none(_that);case _ShowError():
return showError(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _None value)?  none,TResult? Function( _ShowError value)?  showError,}){
final _that = this;
switch (_that) {
case _None() when none != null:
return none(_that);case _ShowError() when showError != null:
return showError(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  none,TResult Function( String message)?  showError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _None() when none != null:
return none();case _ShowError() when showError != null:
return showError(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  none,required TResult Function( String message)  showError,}) {final _that = this;
switch (_that) {
case _None():
return none();case _ShowError():
return showError(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  none,TResult? Function( String message)?  showError,}) {final _that = this;
switch (_that) {
case _None() when none != null:
return none();case _ShowError() when showError != null:
return showError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _None implements HandTrackingPageAction {
   _None();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _None);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HandTrackingPageAction.none()';
}


}




/// @nodoc


class _ShowError implements HandTrackingPageAction {
   _ShowError(this.message);
  

 final  String message;

/// Create a copy of HandTrackingPageAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShowErrorCopyWith<_ShowError> get copyWith => __$ShowErrorCopyWithImpl<_ShowError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShowError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HandTrackingPageAction.showError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ShowErrorCopyWith<$Res> implements $HandTrackingPageActionCopyWith<$Res> {
  factory _$ShowErrorCopyWith(_ShowError value, $Res Function(_ShowError) _then) = __$ShowErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ShowErrorCopyWithImpl<$Res>
    implements _$ShowErrorCopyWith<$Res> {
  __$ShowErrorCopyWithImpl(this._self, this._then);

  final _ShowError _self;
  final $Res Function(_ShowError) _then;

/// Create a copy of HandTrackingPageAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_ShowError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$HandLandmarkUi {

 List<LandmarkPointUi> get points;
/// Create a copy of HandLandmarkUi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandLandmarkUiCopyWith<HandLandmarkUi> get copyWith => _$HandLandmarkUiCopyWithImpl<HandLandmarkUi>(this as HandLandmarkUi, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandLandmarkUi&&const DeepCollectionEquality().equals(other.points, points));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(points));

@override
String toString() {
  return 'HandLandmarkUi(points: $points)';
}


}

/// @nodoc
abstract mixin class $HandLandmarkUiCopyWith<$Res>  {
  factory $HandLandmarkUiCopyWith(HandLandmarkUi value, $Res Function(HandLandmarkUi) _then) = _$HandLandmarkUiCopyWithImpl;
@useResult
$Res call({
 List<LandmarkPointUi> points
});




}
/// @nodoc
class _$HandLandmarkUiCopyWithImpl<$Res>
    implements $HandLandmarkUiCopyWith<$Res> {
  _$HandLandmarkUiCopyWithImpl(this._self, this._then);

  final HandLandmarkUi _self;
  final $Res Function(HandLandmarkUi) _then;

/// Create a copy of HandLandmarkUi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,}) {
  return _then(_self.copyWith(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<LandmarkPointUi>,
  ));
}

}


/// Adds pattern-matching-related methods to [HandLandmarkUi].
extension HandLandmarkUiPatterns on HandLandmarkUi {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HandLandmarkUi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HandLandmarkUi() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HandLandmarkUi value)  $default,){
final _that = this;
switch (_that) {
case _HandLandmarkUi():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HandLandmarkUi value)?  $default,){
final _that = this;
switch (_that) {
case _HandLandmarkUi() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LandmarkPointUi> points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HandLandmarkUi() when $default != null:
return $default(_that.points);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LandmarkPointUi> points)  $default,) {final _that = this;
switch (_that) {
case _HandLandmarkUi():
return $default(_that.points);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LandmarkPointUi> points)?  $default,) {final _that = this;
switch (_that) {
case _HandLandmarkUi() when $default != null:
return $default(_that.points);case _:
  return null;

}
}

}

/// @nodoc


class _HandLandmarkUi implements HandLandmarkUi {
  const _HandLandmarkUi({required final  List<LandmarkPointUi> points}): _points = points;
  

 final  List<LandmarkPointUi> _points;
@override List<LandmarkPointUi> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of HandLandmarkUi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HandLandmarkUiCopyWith<_HandLandmarkUi> get copyWith => __$HandLandmarkUiCopyWithImpl<_HandLandmarkUi>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HandLandmarkUi&&const DeepCollectionEquality().equals(other._points, _points));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'HandLandmarkUi(points: $points)';
}


}

/// @nodoc
abstract mixin class _$HandLandmarkUiCopyWith<$Res> implements $HandLandmarkUiCopyWith<$Res> {
  factory _$HandLandmarkUiCopyWith(_HandLandmarkUi value, $Res Function(_HandLandmarkUi) _then) = __$HandLandmarkUiCopyWithImpl;
@override @useResult
$Res call({
 List<LandmarkPointUi> points
});




}
/// @nodoc
class __$HandLandmarkUiCopyWithImpl<$Res>
    implements _$HandLandmarkUiCopyWith<$Res> {
  __$HandLandmarkUiCopyWithImpl(this._self, this._then);

  final _HandLandmarkUi _self;
  final $Res Function(_HandLandmarkUi) _then;

/// Create a copy of HandLandmarkUi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,}) {
  return _then(_HandLandmarkUi(
points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<LandmarkPointUi>,
  ));
}


}

/// @nodoc
mixin _$LandmarkPointUi {

 double get x; double get y; double get z;
/// Create a copy of LandmarkPointUi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LandmarkPointUiCopyWith<LandmarkPointUi> get copyWith => _$LandmarkPointUiCopyWithImpl<LandmarkPointUi>(this as LandmarkPointUi, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LandmarkPointUi&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.z, z) || other.z == z));
}


@override
int get hashCode => Object.hash(runtimeType,x,y,z);

@override
String toString() {
  return 'LandmarkPointUi(x: $x, y: $y, z: $z)';
}


}

/// @nodoc
abstract mixin class $LandmarkPointUiCopyWith<$Res>  {
  factory $LandmarkPointUiCopyWith(LandmarkPointUi value, $Res Function(LandmarkPointUi) _then) = _$LandmarkPointUiCopyWithImpl;
@useResult
$Res call({
 double x, double y, double z
});




}
/// @nodoc
class _$LandmarkPointUiCopyWithImpl<$Res>
    implements $LandmarkPointUiCopyWith<$Res> {
  _$LandmarkPointUiCopyWithImpl(this._self, this._then);

  final LandmarkPointUi _self;
  final $Res Function(LandmarkPointUi) _then;

/// Create a copy of LandmarkPointUi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,Object? z = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,z: null == z ? _self.z : z // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LandmarkPointUi].
extension LandmarkPointUiPatterns on LandmarkPointUi {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LandmarkPointUi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LandmarkPointUi() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LandmarkPointUi value)  $default,){
final _that = this;
switch (_that) {
case _LandmarkPointUi():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LandmarkPointUi value)?  $default,){
final _that = this;
switch (_that) {
case _LandmarkPointUi() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double x,  double y,  double z)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LandmarkPointUi() when $default != null:
return $default(_that.x,_that.y,_that.z);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double x,  double y,  double z)  $default,) {final _that = this;
switch (_that) {
case _LandmarkPointUi():
return $default(_that.x,_that.y,_that.z);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double x,  double y,  double z)?  $default,) {final _that = this;
switch (_that) {
case _LandmarkPointUi() when $default != null:
return $default(_that.x,_that.y,_that.z);case _:
  return null;

}
}

}

/// @nodoc


class _LandmarkPointUi implements LandmarkPointUi {
  const _LandmarkPointUi({required this.x, required this.y, required this.z});
  

@override final  double x;
@override final  double y;
@override final  double z;

/// Create a copy of LandmarkPointUi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LandmarkPointUiCopyWith<_LandmarkPointUi> get copyWith => __$LandmarkPointUiCopyWithImpl<_LandmarkPointUi>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LandmarkPointUi&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.z, z) || other.z == z));
}


@override
int get hashCode => Object.hash(runtimeType,x,y,z);

@override
String toString() {
  return 'LandmarkPointUi(x: $x, y: $y, z: $z)';
}


}

/// @nodoc
abstract mixin class _$LandmarkPointUiCopyWith<$Res> implements $LandmarkPointUiCopyWith<$Res> {
  factory _$LandmarkPointUiCopyWith(_LandmarkPointUi value, $Res Function(_LandmarkPointUi) _then) = __$LandmarkPointUiCopyWithImpl;
@override @useResult
$Res call({
 double x, double y, double z
});




}
/// @nodoc
class __$LandmarkPointUiCopyWithImpl<$Res>
    implements _$LandmarkPointUiCopyWith<$Res> {
  __$LandmarkPointUiCopyWithImpl(this._self, this._then);

  final _LandmarkPointUi _self;
  final $Res Function(_LandmarkPointUi) _then;

/// Create a copy of LandmarkPointUi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,Object? z = null,}) {
  return _then(_LandmarkPointUi(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,z: null == z ? _self.z : z // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
