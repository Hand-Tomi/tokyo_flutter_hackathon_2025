// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_list_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebugListPageUiState {

 List<DebugMenuItemUi> get menuItems; bool get isLoading; void Function(String id) get onMenuItemTap;
/// Create a copy of DebugListPageUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugListPageUiStateCopyWith<DebugListPageUiState> get copyWith => _$DebugListPageUiStateCopyWithImpl<DebugListPageUiState>(this as DebugListPageUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugListPageUiState&&const DeepCollectionEquality().equals(other.menuItems, menuItems)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.onMenuItemTap, onMenuItemTap) || other.onMenuItemTap == onMenuItemTap));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(menuItems),isLoading,onMenuItemTap);

@override
String toString() {
  return 'DebugListPageUiState(menuItems: $menuItems, isLoading: $isLoading, onMenuItemTap: $onMenuItemTap)';
}


}

/// @nodoc
abstract mixin class $DebugListPageUiStateCopyWith<$Res>  {
  factory $DebugListPageUiStateCopyWith(DebugListPageUiState value, $Res Function(DebugListPageUiState) _then) = _$DebugListPageUiStateCopyWithImpl;
@useResult
$Res call({
 List<DebugMenuItemUi> menuItems, bool isLoading, void Function(String id) onMenuItemTap
});




}
/// @nodoc
class _$DebugListPageUiStateCopyWithImpl<$Res>
    implements $DebugListPageUiStateCopyWith<$Res> {
  _$DebugListPageUiStateCopyWithImpl(this._self, this._then);

  final DebugListPageUiState _self;
  final $Res Function(DebugListPageUiState) _then;

/// Create a copy of DebugListPageUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? menuItems = null,Object? isLoading = null,Object? onMenuItemTap = null,}) {
  return _then(_self.copyWith(
menuItems: null == menuItems ? _self.menuItems : menuItems // ignore: cast_nullable_to_non_nullable
as List<DebugMenuItemUi>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,onMenuItemTap: null == onMenuItemTap ? _self.onMenuItemTap : onMenuItemTap // ignore: cast_nullable_to_non_nullable
as void Function(String id),
  ));
}

}


/// Adds pattern-matching-related methods to [DebugListPageUiState].
extension DebugListPageUiStatePatterns on DebugListPageUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebugListPageUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebugListPageUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebugListPageUiState value)  $default,){
final _that = this;
switch (_that) {
case _DebugListPageUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebugListPageUiState value)?  $default,){
final _that = this;
switch (_that) {
case _DebugListPageUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DebugMenuItemUi> menuItems,  bool isLoading,  void Function(String id) onMenuItemTap)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebugListPageUiState() when $default != null:
return $default(_that.menuItems,_that.isLoading,_that.onMenuItemTap);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DebugMenuItemUi> menuItems,  bool isLoading,  void Function(String id) onMenuItemTap)  $default,) {final _that = this;
switch (_that) {
case _DebugListPageUiState():
return $default(_that.menuItems,_that.isLoading,_that.onMenuItemTap);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DebugMenuItemUi> menuItems,  bool isLoading,  void Function(String id) onMenuItemTap)?  $default,) {final _that = this;
switch (_that) {
case _DebugListPageUiState() when $default != null:
return $default(_that.menuItems,_that.isLoading,_that.onMenuItemTap);case _:
  return null;

}
}

}

/// @nodoc


class _DebugListPageUiState implements DebugListPageUiState {
  const _DebugListPageUiState({final  List<DebugMenuItemUi> menuItems = const [], this.isLoading = false, required this.onMenuItemTap}): _menuItems = menuItems;
  

 final  List<DebugMenuItemUi> _menuItems;
@override@JsonKey() List<DebugMenuItemUi> get menuItems {
  if (_menuItems is EqualUnmodifiableListView) return _menuItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menuItems);
}

@override@JsonKey() final  bool isLoading;
@override final  void Function(String id) onMenuItemTap;

/// Create a copy of DebugListPageUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebugListPageUiStateCopyWith<_DebugListPageUiState> get copyWith => __$DebugListPageUiStateCopyWithImpl<_DebugListPageUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebugListPageUiState&&const DeepCollectionEquality().equals(other._menuItems, _menuItems)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.onMenuItemTap, onMenuItemTap) || other.onMenuItemTap == onMenuItemTap));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_menuItems),isLoading,onMenuItemTap);

@override
String toString() {
  return 'DebugListPageUiState(menuItems: $menuItems, isLoading: $isLoading, onMenuItemTap: $onMenuItemTap)';
}


}

/// @nodoc
abstract mixin class _$DebugListPageUiStateCopyWith<$Res> implements $DebugListPageUiStateCopyWith<$Res> {
  factory _$DebugListPageUiStateCopyWith(_DebugListPageUiState value, $Res Function(_DebugListPageUiState) _then) = __$DebugListPageUiStateCopyWithImpl;
@override @useResult
$Res call({
 List<DebugMenuItemUi> menuItems, bool isLoading, void Function(String id) onMenuItemTap
});




}
/// @nodoc
class __$DebugListPageUiStateCopyWithImpl<$Res>
    implements _$DebugListPageUiStateCopyWith<$Res> {
  __$DebugListPageUiStateCopyWithImpl(this._self, this._then);

  final _DebugListPageUiState _self;
  final $Res Function(_DebugListPageUiState) _then;

/// Create a copy of DebugListPageUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? menuItems = null,Object? isLoading = null,Object? onMenuItemTap = null,}) {
  return _then(_DebugListPageUiState(
menuItems: null == menuItems ? _self._menuItems : menuItems // ignore: cast_nullable_to_non_nullable
as List<DebugMenuItemUi>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,onMenuItemTap: null == onMenuItemTap ? _self.onMenuItemTap : onMenuItemTap // ignore: cast_nullable_to_non_nullable
as void Function(String id),
  ));
}


}

/// @nodoc
mixin _$DebugListPageAction {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugListPageAction);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DebugListPageAction()';
}


}

/// @nodoc
class $DebugListPageActionCopyWith<$Res>  {
$DebugListPageActionCopyWith(DebugListPageAction _, $Res Function(DebugListPageAction) __);
}


/// Adds pattern-matching-related methods to [DebugListPageAction].
extension DebugListPageActionPatterns on DebugListPageAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _None value)?  none,TResult Function( _NavigateToTodoList value)?  navigateToTodoList,TResult Function( _NavigateToHandTracking value)?  navigateToHandTracking,TResult Function( _NavigateToVoiceChat value)?  navigateToVoiceChat,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _None() when none != null:
return none(_that);case _NavigateToTodoList() when navigateToTodoList != null:
return navigateToTodoList(_that);case _NavigateToHandTracking() when navigateToHandTracking != null:
return navigateToHandTracking(_that);case _NavigateToVoiceChat() when navigateToVoiceChat != null:
return navigateToVoiceChat(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _None value)  none,required TResult Function( _NavigateToTodoList value)  navigateToTodoList,required TResult Function( _NavigateToHandTracking value)  navigateToHandTracking,required TResult Function( _NavigateToVoiceChat value)  navigateToVoiceChat,}){
final _that = this;
switch (_that) {
case _None():
return none(_that);case _NavigateToTodoList():
return navigateToTodoList(_that);case _NavigateToHandTracking():
return navigateToHandTracking(_that);case _NavigateToVoiceChat():
return navigateToVoiceChat(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _None value)?  none,TResult? Function( _NavigateToTodoList value)?  navigateToTodoList,TResult? Function( _NavigateToHandTracking value)?  navigateToHandTracking,TResult? Function( _NavigateToVoiceChat value)?  navigateToVoiceChat,}){
final _that = this;
switch (_that) {
case _None() when none != null:
return none(_that);case _NavigateToTodoList() when navigateToTodoList != null:
return navigateToTodoList(_that);case _NavigateToHandTracking() when navigateToHandTracking != null:
return navigateToHandTracking(_that);case _NavigateToVoiceChat() when navigateToVoiceChat != null:
return navigateToVoiceChat(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  none,TResult Function()?  navigateToTodoList,TResult Function()?  navigateToHandTracking,TResult Function()?  navigateToVoiceChat,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _None() when none != null:
return none();case _NavigateToTodoList() when navigateToTodoList != null:
return navigateToTodoList();case _NavigateToHandTracking() when navigateToHandTracking != null:
return navigateToHandTracking();case _NavigateToVoiceChat() when navigateToVoiceChat != null:
return navigateToVoiceChat();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  none,required TResult Function()  navigateToTodoList,required TResult Function()  navigateToHandTracking,required TResult Function()  navigateToVoiceChat,}) {final _that = this;
switch (_that) {
case _None():
return none();case _NavigateToTodoList():
return navigateToTodoList();case _NavigateToHandTracking():
return navigateToHandTracking();case _NavigateToVoiceChat():
return navigateToVoiceChat();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  none,TResult? Function()?  navigateToTodoList,TResult? Function()?  navigateToHandTracking,TResult? Function()?  navigateToVoiceChat,}) {final _that = this;
switch (_that) {
case _None() when none != null:
return none();case _NavigateToTodoList() when navigateToTodoList != null:
return navigateToTodoList();case _NavigateToHandTracking() when navigateToHandTracking != null:
return navigateToHandTracking();case _NavigateToVoiceChat() when navigateToVoiceChat != null:
return navigateToVoiceChat();case _:
  return null;

}
}

}

/// @nodoc


class _None implements DebugListPageAction {
   _None();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _None);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DebugListPageAction.none()';
}


}




/// @nodoc


class _NavigateToTodoList implements DebugListPageAction {
   _NavigateToTodoList();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigateToTodoList);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DebugListPageAction.navigateToTodoList()';
}


}




/// @nodoc


class _NavigateToHandTracking implements DebugListPageAction {
   _NavigateToHandTracking();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigateToHandTracking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DebugListPageAction.navigateToHandTracking()';
}


}




/// @nodoc


class _NavigateToVoiceChat implements DebugListPageAction {
   _NavigateToVoiceChat();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigateToVoiceChat);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DebugListPageAction.navigateToVoiceChat()';
}


}




// dart format on
