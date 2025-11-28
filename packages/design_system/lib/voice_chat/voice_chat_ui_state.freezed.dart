// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_chat_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoiceChatPageUiState {

 ConnectionStatusUi get connectionStatus; List<ChatMessageUi> get messages; bool get isRecording; bool get isAiSpeaking; String get statusMessage; bool get hasMicPermission; String? get currentTranscript;
/// Create a copy of VoiceChatPageUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceChatPageUiStateCopyWith<VoiceChatPageUiState> get copyWith => _$VoiceChatPageUiStateCopyWithImpl<VoiceChatPageUiState>(this as VoiceChatPageUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceChatPageUiState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.isRecording, isRecording) || other.isRecording == isRecording)&&(identical(other.isAiSpeaking, isAiSpeaking) || other.isAiSpeaking == isAiSpeaking)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&(identical(other.hasMicPermission, hasMicPermission) || other.hasMicPermission == hasMicPermission)&&(identical(other.currentTranscript, currentTranscript) || other.currentTranscript == currentTranscript));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,const DeepCollectionEquality().hash(messages),isRecording,isAiSpeaking,statusMessage,hasMicPermission,currentTranscript);

@override
String toString() {
  return 'VoiceChatPageUiState(connectionStatus: $connectionStatus, messages: $messages, isRecording: $isRecording, isAiSpeaking: $isAiSpeaking, statusMessage: $statusMessage, hasMicPermission: $hasMicPermission, currentTranscript: $currentTranscript)';
}


}

/// @nodoc
abstract mixin class $VoiceChatPageUiStateCopyWith<$Res>  {
  factory $VoiceChatPageUiStateCopyWith(VoiceChatPageUiState value, $Res Function(VoiceChatPageUiState) _then) = _$VoiceChatPageUiStateCopyWithImpl;
@useResult
$Res call({
 ConnectionStatusUi connectionStatus, List<ChatMessageUi> messages, bool isRecording, bool isAiSpeaking, String statusMessage, bool hasMicPermission, String? currentTranscript
});




}
/// @nodoc
class _$VoiceChatPageUiStateCopyWithImpl<$Res>
    implements $VoiceChatPageUiStateCopyWith<$Res> {
  _$VoiceChatPageUiStateCopyWithImpl(this._self, this._then);

  final VoiceChatPageUiState _self;
  final $Res Function(VoiceChatPageUiState) _then;

/// Create a copy of VoiceChatPageUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connectionStatus = null,Object? messages = null,Object? isRecording = null,Object? isAiSpeaking = null,Object? statusMessage = null,Object? hasMicPermission = null,Object? currentTranscript = freezed,}) {
  return _then(_self.copyWith(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as ConnectionStatusUi,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageUi>,isRecording: null == isRecording ? _self.isRecording : isRecording // ignore: cast_nullable_to_non_nullable
as bool,isAiSpeaking: null == isAiSpeaking ? _self.isAiSpeaking : isAiSpeaking // ignore: cast_nullable_to_non_nullable
as bool,statusMessage: null == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String,hasMicPermission: null == hasMicPermission ? _self.hasMicPermission : hasMicPermission // ignore: cast_nullable_to_non_nullable
as bool,currentTranscript: freezed == currentTranscript ? _self.currentTranscript : currentTranscript // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoiceChatPageUiState].
extension VoiceChatPageUiStatePatterns on VoiceChatPageUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoiceChatPageUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoiceChatPageUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoiceChatPageUiState value)  $default,){
final _that = this;
switch (_that) {
case _VoiceChatPageUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoiceChatPageUiState value)?  $default,){
final _that = this;
switch (_that) {
case _VoiceChatPageUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ConnectionStatusUi connectionStatus,  List<ChatMessageUi> messages,  bool isRecording,  bool isAiSpeaking,  String statusMessage,  bool hasMicPermission,  String? currentTranscript)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoiceChatPageUiState() when $default != null:
return $default(_that.connectionStatus,_that.messages,_that.isRecording,_that.isAiSpeaking,_that.statusMessage,_that.hasMicPermission,_that.currentTranscript);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ConnectionStatusUi connectionStatus,  List<ChatMessageUi> messages,  bool isRecording,  bool isAiSpeaking,  String statusMessage,  bool hasMicPermission,  String? currentTranscript)  $default,) {final _that = this;
switch (_that) {
case _VoiceChatPageUiState():
return $default(_that.connectionStatus,_that.messages,_that.isRecording,_that.isAiSpeaking,_that.statusMessage,_that.hasMicPermission,_that.currentTranscript);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ConnectionStatusUi connectionStatus,  List<ChatMessageUi> messages,  bool isRecording,  bool isAiSpeaking,  String statusMessage,  bool hasMicPermission,  String? currentTranscript)?  $default,) {final _that = this;
switch (_that) {
case _VoiceChatPageUiState() when $default != null:
return $default(_that.connectionStatus,_that.messages,_that.isRecording,_that.isAiSpeaking,_that.statusMessage,_that.hasMicPermission,_that.currentTranscript);case _:
  return null;

}
}

}

/// @nodoc


class _VoiceChatPageUiState implements VoiceChatPageUiState {
  const _VoiceChatPageUiState({this.connectionStatus = ConnectionStatusUi.disconnected, final  List<ChatMessageUi> messages = const [], this.isRecording = false, this.isAiSpeaking = false, this.statusMessage = '', this.hasMicPermission = false, this.currentTranscript}): _messages = messages;
  

@override@JsonKey() final  ConnectionStatusUi connectionStatus;
 final  List<ChatMessageUi> _messages;
@override@JsonKey() List<ChatMessageUi> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool isRecording;
@override@JsonKey() final  bool isAiSpeaking;
@override@JsonKey() final  String statusMessage;
@override@JsonKey() final  bool hasMicPermission;
@override final  String? currentTranscript;

/// Create a copy of VoiceChatPageUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoiceChatPageUiStateCopyWith<_VoiceChatPageUiState> get copyWith => __$VoiceChatPageUiStateCopyWithImpl<_VoiceChatPageUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoiceChatPageUiState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.isRecording, isRecording) || other.isRecording == isRecording)&&(identical(other.isAiSpeaking, isAiSpeaking) || other.isAiSpeaking == isAiSpeaking)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&(identical(other.hasMicPermission, hasMicPermission) || other.hasMicPermission == hasMicPermission)&&(identical(other.currentTranscript, currentTranscript) || other.currentTranscript == currentTranscript));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,const DeepCollectionEquality().hash(_messages),isRecording,isAiSpeaking,statusMessage,hasMicPermission,currentTranscript);

@override
String toString() {
  return 'VoiceChatPageUiState(connectionStatus: $connectionStatus, messages: $messages, isRecording: $isRecording, isAiSpeaking: $isAiSpeaking, statusMessage: $statusMessage, hasMicPermission: $hasMicPermission, currentTranscript: $currentTranscript)';
}


}

/// @nodoc
abstract mixin class _$VoiceChatPageUiStateCopyWith<$Res> implements $VoiceChatPageUiStateCopyWith<$Res> {
  factory _$VoiceChatPageUiStateCopyWith(_VoiceChatPageUiState value, $Res Function(_VoiceChatPageUiState) _then) = __$VoiceChatPageUiStateCopyWithImpl;
@override @useResult
$Res call({
 ConnectionStatusUi connectionStatus, List<ChatMessageUi> messages, bool isRecording, bool isAiSpeaking, String statusMessage, bool hasMicPermission, String? currentTranscript
});




}
/// @nodoc
class __$VoiceChatPageUiStateCopyWithImpl<$Res>
    implements _$VoiceChatPageUiStateCopyWith<$Res> {
  __$VoiceChatPageUiStateCopyWithImpl(this._self, this._then);

  final _VoiceChatPageUiState _self;
  final $Res Function(_VoiceChatPageUiState) _then;

/// Create a copy of VoiceChatPageUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connectionStatus = null,Object? messages = null,Object? isRecording = null,Object? isAiSpeaking = null,Object? statusMessage = null,Object? hasMicPermission = null,Object? currentTranscript = freezed,}) {
  return _then(_VoiceChatPageUiState(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as ConnectionStatusUi,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageUi>,isRecording: null == isRecording ? _self.isRecording : isRecording // ignore: cast_nullable_to_non_nullable
as bool,isAiSpeaking: null == isAiSpeaking ? _self.isAiSpeaking : isAiSpeaking // ignore: cast_nullable_to_non_nullable
as bool,statusMessage: null == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String,hasMicPermission: null == hasMicPermission ? _self.hasMicPermission : hasMicPermission // ignore: cast_nullable_to_non_nullable
as bool,currentTranscript: freezed == currentTranscript ? _self.currentTranscript : currentTranscript // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$VoiceChatPageAction {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceChatPageAction);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceChatPageAction()';
}


}

/// @nodoc
class $VoiceChatPageActionCopyWith<$Res>  {
$VoiceChatPageActionCopyWith(VoiceChatPageAction _, $Res Function(VoiceChatPageAction) __);
}


/// Adds pattern-matching-related methods to [VoiceChatPageAction].
extension VoiceChatPageActionPatterns on VoiceChatPageAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _None value)?  none,TResult Function( _ShowError value)?  showError,TResult Function( _RequestMicPermission value)?  requestMicPermission,TResult Function( _ScrollToBottom value)?  scrollToBottom,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _None() when none != null:
return none(_that);case _ShowError() when showError != null:
return showError(_that);case _RequestMicPermission() when requestMicPermission != null:
return requestMicPermission(_that);case _ScrollToBottom() when scrollToBottom != null:
return scrollToBottom(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _None value)  none,required TResult Function( _ShowError value)  showError,required TResult Function( _RequestMicPermission value)  requestMicPermission,required TResult Function( _ScrollToBottom value)  scrollToBottom,}){
final _that = this;
switch (_that) {
case _None():
return none(_that);case _ShowError():
return showError(_that);case _RequestMicPermission():
return requestMicPermission(_that);case _ScrollToBottom():
return scrollToBottom(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _None value)?  none,TResult? Function( _ShowError value)?  showError,TResult? Function( _RequestMicPermission value)?  requestMicPermission,TResult? Function( _ScrollToBottom value)?  scrollToBottom,}){
final _that = this;
switch (_that) {
case _None() when none != null:
return none(_that);case _ShowError() when showError != null:
return showError(_that);case _RequestMicPermission() when requestMicPermission != null:
return requestMicPermission(_that);case _ScrollToBottom() when scrollToBottom != null:
return scrollToBottom(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  none,TResult Function( String message)?  showError,TResult Function()?  requestMicPermission,TResult Function()?  scrollToBottom,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _None() when none != null:
return none();case _ShowError() when showError != null:
return showError(_that.message);case _RequestMicPermission() when requestMicPermission != null:
return requestMicPermission();case _ScrollToBottom() when scrollToBottom != null:
return scrollToBottom();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  none,required TResult Function( String message)  showError,required TResult Function()  requestMicPermission,required TResult Function()  scrollToBottom,}) {final _that = this;
switch (_that) {
case _None():
return none();case _ShowError():
return showError(_that.message);case _RequestMicPermission():
return requestMicPermission();case _ScrollToBottom():
return scrollToBottom();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  none,TResult? Function( String message)?  showError,TResult? Function()?  requestMicPermission,TResult? Function()?  scrollToBottom,}) {final _that = this;
switch (_that) {
case _None() when none != null:
return none();case _ShowError() when showError != null:
return showError(_that.message);case _RequestMicPermission() when requestMicPermission != null:
return requestMicPermission();case _ScrollToBottom() when scrollToBottom != null:
return scrollToBottom();case _:
  return null;

}
}

}

/// @nodoc


class _None implements VoiceChatPageAction {
   _None();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _None);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceChatPageAction.none()';
}


}




/// @nodoc


class _ShowError implements VoiceChatPageAction {
   _ShowError(this.message);
  

 final  String message;

/// Create a copy of VoiceChatPageAction
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
  return 'VoiceChatPageAction.showError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ShowErrorCopyWith<$Res> implements $VoiceChatPageActionCopyWith<$Res> {
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

/// Create a copy of VoiceChatPageAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_ShowError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RequestMicPermission implements VoiceChatPageAction {
   _RequestMicPermission();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestMicPermission);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceChatPageAction.requestMicPermission()';
}


}




/// @nodoc


class _ScrollToBottom implements VoiceChatPageAction {
   _ScrollToBottom();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrollToBottom);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceChatPageAction.scrollToBottom()';
}


}




// dart format on
