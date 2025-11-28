// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_list_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoListPageUiState {

 List<TodoUi> get todos; bool get isLoading;
/// Create a copy of TodoListPageUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoListPageUiStateCopyWith<TodoListPageUiState> get copyWith => _$TodoListPageUiStateCopyWithImpl<TodoListPageUiState>(this as TodoListPageUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoListPageUiState&&const DeepCollectionEquality().equals(other.todos, todos)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(todos),isLoading);

@override
String toString() {
  return 'TodoListPageUiState(todos: $todos, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $TodoListPageUiStateCopyWith<$Res>  {
  factory $TodoListPageUiStateCopyWith(TodoListPageUiState value, $Res Function(TodoListPageUiState) _then) = _$TodoListPageUiStateCopyWithImpl;
@useResult
$Res call({
 List<TodoUi> todos, bool isLoading
});




}
/// @nodoc
class _$TodoListPageUiStateCopyWithImpl<$Res>
    implements $TodoListPageUiStateCopyWith<$Res> {
  _$TodoListPageUiStateCopyWithImpl(this._self, this._then);

  final TodoListPageUiState _self;
  final $Res Function(TodoListPageUiState) _then;

/// Create a copy of TodoListPageUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todos = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
todos: null == todos ? _self.todos : todos // ignore: cast_nullable_to_non_nullable
as List<TodoUi>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoListPageUiState].
extension TodoListPageUiStatePatterns on TodoListPageUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoListPageUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoListPageUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoListPageUiState value)  $default,){
final _that = this;
switch (_that) {
case _TodoListPageUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoListPageUiState value)?  $default,){
final _that = this;
switch (_that) {
case _TodoListPageUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TodoUi> todos,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoListPageUiState() when $default != null:
return $default(_that.todos,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TodoUi> todos,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _TodoListPageUiState():
return $default(_that.todos,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TodoUi> todos,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _TodoListPageUiState() when $default != null:
return $default(_that.todos,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _TodoListPageUiState implements TodoListPageUiState {
  const _TodoListPageUiState({final  List<TodoUi> todos = const [], this.isLoading = false}): _todos = todos;
  

 final  List<TodoUi> _todos;
@override@JsonKey() List<TodoUi> get todos {
  if (_todos is EqualUnmodifiableListView) return _todos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todos);
}

@override@JsonKey() final  bool isLoading;

/// Create a copy of TodoListPageUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoListPageUiStateCopyWith<_TodoListPageUiState> get copyWith => __$TodoListPageUiStateCopyWithImpl<_TodoListPageUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoListPageUiState&&const DeepCollectionEquality().equals(other._todos, _todos)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_todos),isLoading);

@override
String toString() {
  return 'TodoListPageUiState(todos: $todos, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$TodoListPageUiStateCopyWith<$Res> implements $TodoListPageUiStateCopyWith<$Res> {
  factory _$TodoListPageUiStateCopyWith(_TodoListPageUiState value, $Res Function(_TodoListPageUiState) _then) = __$TodoListPageUiStateCopyWithImpl;
@override @useResult
$Res call({
 List<TodoUi> todos, bool isLoading
});




}
/// @nodoc
class __$TodoListPageUiStateCopyWithImpl<$Res>
    implements _$TodoListPageUiStateCopyWith<$Res> {
  __$TodoListPageUiStateCopyWithImpl(this._self, this._then);

  final _TodoListPageUiState _self;
  final $Res Function(_TodoListPageUiState) _then;

/// Create a copy of TodoListPageUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todos = null,Object? isLoading = null,}) {
  return _then(_TodoListPageUiState(
todos: null == todos ? _self._todos : todos // ignore: cast_nullable_to_non_nullable
as List<TodoUi>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$TodoListPageAction {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoListPageAction);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoListPageAction()';
}


}

/// @nodoc
class $TodoListPageActionCopyWith<$Res>  {
$TodoListPageActionCopyWith(TodoListPageAction _, $Res Function(TodoListPageAction) __);
}


/// Adds pattern-matching-related methods to [TodoListPageAction].
extension TodoListPageActionPatterns on TodoListPageAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _None value)?  none,TResult Function( _ShowAddDialog value)?  showAddDialog,TResult Function( _ShowError value)?  showError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _None() when none != null:
return none(_that);case _ShowAddDialog() when showAddDialog != null:
return showAddDialog(_that);case _ShowError() when showError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _None value)  none,required TResult Function( _ShowAddDialog value)  showAddDialog,required TResult Function( _ShowError value)  showError,}){
final _that = this;
switch (_that) {
case _None():
return none(_that);case _ShowAddDialog():
return showAddDialog(_that);case _ShowError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _None value)?  none,TResult? Function( _ShowAddDialog value)?  showAddDialog,TResult? Function( _ShowError value)?  showError,}){
final _that = this;
switch (_that) {
case _None() when none != null:
return none(_that);case _ShowAddDialog() when showAddDialog != null:
return showAddDialog(_that);case _ShowError() when showError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  none,TResult Function()?  showAddDialog,TResult Function( String message)?  showError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _None() when none != null:
return none();case _ShowAddDialog() when showAddDialog != null:
return showAddDialog();case _ShowError() when showError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  none,required TResult Function()  showAddDialog,required TResult Function( String message)  showError,}) {final _that = this;
switch (_that) {
case _None():
return none();case _ShowAddDialog():
return showAddDialog();case _ShowError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  none,TResult? Function()?  showAddDialog,TResult? Function( String message)?  showError,}) {final _that = this;
switch (_that) {
case _None() when none != null:
return none();case _ShowAddDialog() when showAddDialog != null:
return showAddDialog();case _ShowError() when showError != null:
return showError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _None implements TodoListPageAction {
   _None();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _None);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoListPageAction.none()';
}


}




/// @nodoc


class _ShowAddDialog implements TodoListPageAction {
   _ShowAddDialog();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShowAddDialog);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoListPageAction.showAddDialog()';
}


}




/// @nodoc


class _ShowError implements TodoListPageAction {
   _ShowError(this.message);
  

 final  String message;

/// Create a copy of TodoListPageAction
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
  return 'TodoListPageAction.showError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ShowErrorCopyWith<$Res> implements $TodoListPageActionCopyWith<$Res> {
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

/// Create a copy of TodoListPageAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_ShowError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
