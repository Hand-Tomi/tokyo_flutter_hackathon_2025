// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PageState<TUiState, TAction> {
  TUiState get uiState => throw _privateConstructorUsedError;
  TAction get action => throw _privateConstructorUsedError;

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageStateCopyWith<TUiState, TAction, PageState<TUiState, TAction>>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageStateCopyWith<TUiState, TAction, $Res> {
  factory $PageStateCopyWith(
    PageState<TUiState, TAction> value,
    $Res Function(PageState<TUiState, TAction>) then,
  ) =
      _$PageStateCopyWithImpl<
        TUiState,
        TAction,
        $Res,
        PageState<TUiState, TAction>
      >;
  @useResult
  $Res call({TUiState uiState, TAction action});
}

/// @nodoc
class _$PageStateCopyWithImpl<
  TUiState,
  TAction,
  $Res,
  $Val extends PageState<TUiState, TAction>
>
    implements $PageStateCopyWith<TUiState, TAction, $Res> {
  _$PageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? uiState = freezed, Object? action = freezed}) {
    return _then(
      _value.copyWith(
            uiState: freezed == uiState
                ? _value.uiState
                : uiState // ignore: cast_nullable_to_non_nullable
                      as TUiState,
            action: freezed == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as TAction,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PageStateImplCopyWith<TUiState, TAction, $Res>
    implements $PageStateCopyWith<TUiState, TAction, $Res> {
  factory _$$PageStateImplCopyWith(
    _$PageStateImpl<TUiState, TAction> value,
    $Res Function(_$PageStateImpl<TUiState, TAction>) then,
  ) = __$$PageStateImplCopyWithImpl<TUiState, TAction, $Res>;
  @override
  @useResult
  $Res call({TUiState uiState, TAction action});
}

/// @nodoc
class __$$PageStateImplCopyWithImpl<TUiState, TAction, $Res>
    extends
        _$PageStateCopyWithImpl<
          TUiState,
          TAction,
          $Res,
          _$PageStateImpl<TUiState, TAction>
        >
    implements _$$PageStateImplCopyWith<TUiState, TAction, $Res> {
  __$$PageStateImplCopyWithImpl(
    _$PageStateImpl<TUiState, TAction> _value,
    $Res Function(_$PageStateImpl<TUiState, TAction>) _then,
  ) : super(_value, _then);

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? uiState = freezed, Object? action = freezed}) {
    return _then(
      _$PageStateImpl<TUiState, TAction>(
        uiState: freezed == uiState
            ? _value.uiState
            : uiState // ignore: cast_nullable_to_non_nullable
                  as TUiState,
        action: freezed == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as TAction,
      ),
    );
  }
}

/// @nodoc

class _$PageStateImpl<TUiState, TAction>
    implements _PageState<TUiState, TAction> {
  const _$PageStateImpl({required this.uiState, required this.action});

  @override
  final TUiState uiState;
  @override
  final TAction action;

  @override
  String toString() {
    return 'PageState<$TUiState, $TAction>(uiState: $uiState, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageStateImpl<TUiState, TAction> &&
            const DeepCollectionEquality().equals(other.uiState, uiState) &&
            const DeepCollectionEquality().equals(other.action, action));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(uiState),
    const DeepCollectionEquality().hash(action),
  );

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageStateImplCopyWith<
    TUiState,
    TAction,
    _$PageStateImpl<TUiState, TAction>
  >
  get copyWith =>
      __$$PageStateImplCopyWithImpl<
        TUiState,
        TAction,
        _$PageStateImpl<TUiState, TAction>
      >(this, _$identity);
}

abstract class _PageState<TUiState, TAction>
    implements PageState<TUiState, TAction> {
  const factory _PageState({
    required final TUiState uiState,
    required final TAction action,
  }) = _$PageStateImpl<TUiState, TAction>;

  @override
  TUiState get uiState;
  @override
  TAction get action;

  /// Create a copy of PageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageStateImplCopyWith<
    TUiState,
    TAction,
    _$PageStateImpl<TUiState, TAction>
  >
  get copyWith => throw _privateConstructorUsedError;
}
