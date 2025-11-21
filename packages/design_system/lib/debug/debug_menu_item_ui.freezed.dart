// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_menu_item_ui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DebugMenuItemUi {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Create a copy of DebugMenuItemUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DebugMenuItemUiCopyWith<DebugMenuItemUi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebugMenuItemUiCopyWith<$Res> {
  factory $DebugMenuItemUiCopyWith(
    DebugMenuItemUi value,
    $Res Function(DebugMenuItemUi) then,
  ) = _$DebugMenuItemUiCopyWithImpl<$Res, DebugMenuItemUi>;
  @useResult
  $Res call({String id, String title, String description});
}

/// @nodoc
class _$DebugMenuItemUiCopyWithImpl<$Res, $Val extends DebugMenuItemUi>
    implements $DebugMenuItemUiCopyWith<$Res> {
  _$DebugMenuItemUiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DebugMenuItemUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DebugMenuItemUiImplCopyWith<$Res>
    implements $DebugMenuItemUiCopyWith<$Res> {
  factory _$$DebugMenuItemUiImplCopyWith(
    _$DebugMenuItemUiImpl value,
    $Res Function(_$DebugMenuItemUiImpl) then,
  ) = __$$DebugMenuItemUiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String description});
}

/// @nodoc
class __$$DebugMenuItemUiImplCopyWithImpl<$Res>
    extends _$DebugMenuItemUiCopyWithImpl<$Res, _$DebugMenuItemUiImpl>
    implements _$$DebugMenuItemUiImplCopyWith<$Res> {
  __$$DebugMenuItemUiImplCopyWithImpl(
    _$DebugMenuItemUiImpl _value,
    $Res Function(_$DebugMenuItemUiImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugMenuItemUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(
      _$DebugMenuItemUiImpl(
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
      ),
    );
  }
}

/// @nodoc

class _$DebugMenuItemUiImpl implements _DebugMenuItemUi {
  const _$DebugMenuItemUiImpl({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;

  @override
  String toString() {
    return 'DebugMenuItemUi(id: $id, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebugMenuItemUiImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description);

  /// Create a copy of DebugMenuItemUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DebugMenuItemUiImplCopyWith<_$DebugMenuItemUiImpl> get copyWith =>
      __$$DebugMenuItemUiImplCopyWithImpl<_$DebugMenuItemUiImpl>(
        this,
        _$identity,
      );
}

abstract class _DebugMenuItemUi implements DebugMenuItemUi {
  const factory _DebugMenuItemUi({
    required final String id,
    required final String title,
    required final String description,
  }) = _$DebugMenuItemUiImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;

  /// Create a copy of DebugMenuItemUi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DebugMenuItemUiImplCopyWith<_$DebugMenuItemUiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
