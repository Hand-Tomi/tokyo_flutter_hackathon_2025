// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PageState<TUiState,TAction> {

 TUiState get uiState; TAction get action;
/// Create a copy of PageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageStateCopyWith<TUiState, TAction, PageState<TUiState, TAction>> get copyWith => _$PageStateCopyWithImpl<TUiState, TAction, PageState<TUiState, TAction>>(this as PageState<TUiState, TAction>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageState<TUiState, TAction>&&const DeepCollectionEquality().equals(other.uiState, uiState)&&const DeepCollectionEquality().equals(other.action, action));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(uiState),const DeepCollectionEquality().hash(action));

@override
String toString() {
  return 'PageState<$TUiState, $TAction>(uiState: $uiState, action: $action)';
}


}

/// @nodoc
abstract mixin class $PageStateCopyWith<TUiState,TAction,$Res>  {
  factory $PageStateCopyWith(PageState<TUiState, TAction> value, $Res Function(PageState<TUiState, TAction>) _then) = _$PageStateCopyWithImpl;
@useResult
$Res call({
 TUiState uiState, TAction action
});




}
/// @nodoc
class _$PageStateCopyWithImpl<TUiState,TAction,$Res>
    implements $PageStateCopyWith<TUiState, TAction, $Res> {
  _$PageStateCopyWithImpl(this._self, this._then);

  final PageState<TUiState, TAction> _self;
  final $Res Function(PageState<TUiState, TAction>) _then;

/// Create a copy of PageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uiState = freezed,Object? action = freezed,}) {
  return _then(_self.copyWith(
uiState: freezed == uiState ? _self.uiState : uiState // ignore: cast_nullable_to_non_nullable
as TUiState,action: freezed == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as TAction,
  ));
}

}


/// Adds pattern-matching-related methods to [PageState].
extension PageStatePatterns<TUiState,TAction> on PageState<TUiState, TAction> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageState<TUiState, TAction> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageState<TUiState, TAction> value)  $default,){
final _that = this;
switch (_that) {
case _PageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageState<TUiState, TAction> value)?  $default,){
final _that = this;
switch (_that) {
case _PageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TUiState uiState,  TAction action)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageState() when $default != null:
return $default(_that.uiState,_that.action);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TUiState uiState,  TAction action)  $default,) {final _that = this;
switch (_that) {
case _PageState():
return $default(_that.uiState,_that.action);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TUiState uiState,  TAction action)?  $default,) {final _that = this;
switch (_that) {
case _PageState() when $default != null:
return $default(_that.uiState,_that.action);case _:
  return null;

}
}

}

/// @nodoc


class _PageState<TUiState,TAction> implements PageState<TUiState, TAction> {
  const _PageState({required this.uiState, required this.action});
  

@override final  TUiState uiState;
@override final  TAction action;

/// Create a copy of PageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageStateCopyWith<TUiState, TAction, _PageState<TUiState, TAction>> get copyWith => __$PageStateCopyWithImpl<TUiState, TAction, _PageState<TUiState, TAction>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageState<TUiState, TAction>&&const DeepCollectionEquality().equals(other.uiState, uiState)&&const DeepCollectionEquality().equals(other.action, action));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(uiState),const DeepCollectionEquality().hash(action));

@override
String toString() {
  return 'PageState<$TUiState, $TAction>(uiState: $uiState, action: $action)';
}


}

/// @nodoc
abstract mixin class _$PageStateCopyWith<TUiState,TAction,$Res> implements $PageStateCopyWith<TUiState, TAction, $Res> {
  factory _$PageStateCopyWith(_PageState<TUiState, TAction> value, $Res Function(_PageState<TUiState, TAction>) _then) = __$PageStateCopyWithImpl;
@override @useResult
$Res call({
 TUiState uiState, TAction action
});




}
/// @nodoc
class __$PageStateCopyWithImpl<TUiState,TAction,$Res>
    implements _$PageStateCopyWith<TUiState, TAction, $Res> {
  __$PageStateCopyWithImpl(this._self, this._then);

  final _PageState<TUiState, TAction> _self;
  final $Res Function(_PageState<TUiState, TAction>) _then;

/// Create a copy of PageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uiState = freezed,Object? action = freezed,}) {
  return _then(_PageState<TUiState, TAction>(
uiState: freezed == uiState ? _self.uiState : uiState // ignore: cast_nullable_to_non_nullable
as TUiState,action: freezed == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as TAction,
  ));
}


}

// dart format on
