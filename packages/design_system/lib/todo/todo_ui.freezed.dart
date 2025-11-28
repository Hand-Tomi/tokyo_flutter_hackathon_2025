// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_ui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoUi {

 String get id; String get title; String get description; bool get isCompleted; String get formattedDate;
/// Create a copy of TodoUi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoUiCopyWith<TodoUi> get copyWith => _$TodoUiCopyWithImpl<TodoUi>(this as TodoUi, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoUi&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.formattedDate, formattedDate) || other.formattedDate == formattedDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,isCompleted,formattedDate);

@override
String toString() {
  return 'TodoUi(id: $id, title: $title, description: $description, isCompleted: $isCompleted, formattedDate: $formattedDate)';
}


}

/// @nodoc
abstract mixin class $TodoUiCopyWith<$Res>  {
  factory $TodoUiCopyWith(TodoUi value, $Res Function(TodoUi) _then) = _$TodoUiCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, bool isCompleted, String formattedDate
});




}
/// @nodoc
class _$TodoUiCopyWithImpl<$Res>
    implements $TodoUiCopyWith<$Res> {
  _$TodoUiCopyWithImpl(this._self, this._then);

  final TodoUi _self;
  final $Res Function(TodoUi) _then;

/// Create a copy of TodoUi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? isCompleted = null,Object? formattedDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,formattedDate: null == formattedDate ? _self.formattedDate : formattedDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoUi].
extension TodoUiPatterns on TodoUi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoUi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoUi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoUi value)  $default,){
final _that = this;
switch (_that) {
case _TodoUi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoUi value)?  $default,){
final _that = this;
switch (_that) {
case _TodoUi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  bool isCompleted,  String formattedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoUi() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.isCompleted,_that.formattedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  bool isCompleted,  String formattedDate)  $default,) {final _that = this;
switch (_that) {
case _TodoUi():
return $default(_that.id,_that.title,_that.description,_that.isCompleted,_that.formattedDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  bool isCompleted,  String formattedDate)?  $default,) {final _that = this;
switch (_that) {
case _TodoUi() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.isCompleted,_that.formattedDate);case _:
  return null;

}
}

}

/// @nodoc


class _TodoUi implements TodoUi {
  const _TodoUi({required this.id, required this.title, required this.description, required this.isCompleted, required this.formattedDate});
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  bool isCompleted;
@override final  String formattedDate;

/// Create a copy of TodoUi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoUiCopyWith<_TodoUi> get copyWith => __$TodoUiCopyWithImpl<_TodoUi>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoUi&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.formattedDate, formattedDate) || other.formattedDate == formattedDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,isCompleted,formattedDate);

@override
String toString() {
  return 'TodoUi(id: $id, title: $title, description: $description, isCompleted: $isCompleted, formattedDate: $formattedDate)';
}


}

/// @nodoc
abstract mixin class _$TodoUiCopyWith<$Res> implements $TodoUiCopyWith<$Res> {
  factory _$TodoUiCopyWith(_TodoUi value, $Res Function(_TodoUi) _then) = __$TodoUiCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, bool isCompleted, String formattedDate
});




}
/// @nodoc
class __$TodoUiCopyWithImpl<$Res>
    implements _$TodoUiCopyWith<$Res> {
  __$TodoUiCopyWithImpl(this._self, this._then);

  final _TodoUi _self;
  final $Res Function(_TodoUi) _then;

/// Create a copy of TodoUi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? isCompleted = null,Object? formattedDate = null,}) {
  return _then(_TodoUi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,formattedDate: null == formattedDate ? _self.formattedDate : formattedDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
