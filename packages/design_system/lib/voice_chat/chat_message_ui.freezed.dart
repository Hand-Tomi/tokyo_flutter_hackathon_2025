// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_ui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatMessageUi {

 String get id; ChatSenderUi get sender; String get content; String get formattedTime; bool get isStreaming;
/// Create a copy of ChatMessageUi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageUiCopyWith<ChatMessageUi> get copyWith => _$ChatMessageUiCopyWithImpl<ChatMessageUi>(this as ChatMessageUi, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageUi&&(identical(other.id, id) || other.id == id)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.content, content) || other.content == content)&&(identical(other.formattedTime, formattedTime) || other.formattedTime == formattedTime)&&(identical(other.isStreaming, isStreaming) || other.isStreaming == isStreaming));
}


@override
int get hashCode => Object.hash(runtimeType,id,sender,content,formattedTime,isStreaming);

@override
String toString() {
  return 'ChatMessageUi(id: $id, sender: $sender, content: $content, formattedTime: $formattedTime, isStreaming: $isStreaming)';
}


}

/// @nodoc
abstract mixin class $ChatMessageUiCopyWith<$Res>  {
  factory $ChatMessageUiCopyWith(ChatMessageUi value, $Res Function(ChatMessageUi) _then) = _$ChatMessageUiCopyWithImpl;
@useResult
$Res call({
 String id, ChatSenderUi sender, String content, String formattedTime, bool isStreaming
});




}
/// @nodoc
class _$ChatMessageUiCopyWithImpl<$Res>
    implements $ChatMessageUiCopyWith<$Res> {
  _$ChatMessageUiCopyWithImpl(this._self, this._then);

  final ChatMessageUi _self;
  final $Res Function(ChatMessageUi) _then;

/// Create a copy of ChatMessageUi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sender = null,Object? content = null,Object? formattedTime = null,Object? isStreaming = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as ChatSenderUi,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,formattedTime: null == formattedTime ? _self.formattedTime : formattedTime // ignore: cast_nullable_to_non_nullable
as String,isStreaming: null == isStreaming ? _self.isStreaming : isStreaming // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessageUi].
extension ChatMessageUiPatterns on ChatMessageUi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageUi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageUi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageUi value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageUi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageUi value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageUi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ChatSenderUi sender,  String content,  String formattedTime,  bool isStreaming)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageUi() when $default != null:
return $default(_that.id,_that.sender,_that.content,_that.formattedTime,_that.isStreaming);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ChatSenderUi sender,  String content,  String formattedTime,  bool isStreaming)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageUi():
return $default(_that.id,_that.sender,_that.content,_that.formattedTime,_that.isStreaming);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ChatSenderUi sender,  String content,  String formattedTime,  bool isStreaming)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageUi() when $default != null:
return $default(_that.id,_that.sender,_that.content,_that.formattedTime,_that.isStreaming);case _:
  return null;

}
}

}

/// @nodoc


class _ChatMessageUi implements ChatMessageUi {
  const _ChatMessageUi({required this.id, required this.sender, required this.content, required this.formattedTime, this.isStreaming = false});
  

@override final  String id;
@override final  ChatSenderUi sender;
@override final  String content;
@override final  String formattedTime;
@override@JsonKey() final  bool isStreaming;

/// Create a copy of ChatMessageUi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageUiCopyWith<_ChatMessageUi> get copyWith => __$ChatMessageUiCopyWithImpl<_ChatMessageUi>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageUi&&(identical(other.id, id) || other.id == id)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.content, content) || other.content == content)&&(identical(other.formattedTime, formattedTime) || other.formattedTime == formattedTime)&&(identical(other.isStreaming, isStreaming) || other.isStreaming == isStreaming));
}


@override
int get hashCode => Object.hash(runtimeType,id,sender,content,formattedTime,isStreaming);

@override
String toString() {
  return 'ChatMessageUi(id: $id, sender: $sender, content: $content, formattedTime: $formattedTime, isStreaming: $isStreaming)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageUiCopyWith<$Res> implements $ChatMessageUiCopyWith<$Res> {
  factory _$ChatMessageUiCopyWith(_ChatMessageUi value, $Res Function(_ChatMessageUi) _then) = __$ChatMessageUiCopyWithImpl;
@override @useResult
$Res call({
 String id, ChatSenderUi sender, String content, String formattedTime, bool isStreaming
});




}
/// @nodoc
class __$ChatMessageUiCopyWithImpl<$Res>
    implements _$ChatMessageUiCopyWith<$Res> {
  __$ChatMessageUiCopyWithImpl(this._self, this._then);

  final _ChatMessageUi _self;
  final $Res Function(_ChatMessageUi) _then;

/// Create a copy of ChatMessageUi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sender = null,Object? content = null,Object? formattedTime = null,Object? isStreaming = null,}) {
  return _then(_ChatMessageUi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as ChatSenderUi,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,formattedTime: null == formattedTime ? _self.formattedTime : formattedTime // ignore: cast_nullable_to_non_nullable
as String,isStreaming: null == isStreaming ? _self.isStreaming : isStreaming // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
