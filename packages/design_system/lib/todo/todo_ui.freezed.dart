// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_ui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TodoUi {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String get formattedDate => throw _privateConstructorUsedError;

  /// Create a copy of TodoUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoUiCopyWith<TodoUi> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoUiCopyWith<$Res> {
  factory $TodoUiCopyWith(TodoUi value, $Res Function(TodoUi) then) =
      _$TodoUiCopyWithImpl<$Res, TodoUi>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    bool isCompleted,
    String formattedDate,
  });
}

/// @nodoc
class _$TodoUiCopyWithImpl<$Res, $Val extends TodoUi>
    implements $TodoUiCopyWith<$Res> {
  _$TodoUiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? isCompleted = null,
    Object? formattedDate = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            formattedDate: null == formattedDate
                ? _value.formattedDate
                : formattedDate // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TodoUiImplCopyWith<$Res> implements $TodoUiCopyWith<$Res> {
  factory _$$TodoUiImplCopyWith(
    _$TodoUiImpl value,
    $Res Function(_$TodoUiImpl) then,
  ) = __$$TodoUiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    bool isCompleted,
    String formattedDate,
  });
}

/// @nodoc
class __$$TodoUiImplCopyWithImpl<$Res>
    extends _$TodoUiCopyWithImpl<$Res, _$TodoUiImpl>
    implements _$$TodoUiImplCopyWith<$Res> {
  __$$TodoUiImplCopyWithImpl(
    _$TodoUiImpl _value,
    $Res Function(_$TodoUiImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? isCompleted = null,
    Object? formattedDate = null,
  }) {
    return _then(
      _$TodoUiImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        formattedDate: null == formattedDate
            ? _value.formattedDate
            : formattedDate // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TodoUiImpl implements _TodoUi {
  const _$TodoUiImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.formattedDate,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final bool isCompleted;
  @override
  final String formattedDate;

  @override
  String toString() {
    return 'TodoUi(id: $id, title: $title, description: $description, isCompleted: $isCompleted, formattedDate: $formattedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoUiImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.formattedDate, formattedDate) ||
                other.formattedDate == formattedDate));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    isCompleted,
    formattedDate,
  );

  /// Create a copy of TodoUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoUiImplCopyWith<_$TodoUiImpl> get copyWith =>
      __$$TodoUiImplCopyWithImpl<_$TodoUiImpl>(this, _$identity);
}

abstract class _TodoUi implements TodoUi {
  const factory _TodoUi({
    required final String id,
    required final String title,
    required final String description,
    required final bool isCompleted,
    required final String formattedDate,
  }) = _$TodoUiImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  bool get isCompleted;
  @override
  String get formattedDate;

  /// Create a copy of TodoUi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoUiImplCopyWith<_$TodoUiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
