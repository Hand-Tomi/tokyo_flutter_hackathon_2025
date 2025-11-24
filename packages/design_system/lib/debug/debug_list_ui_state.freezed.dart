// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_list_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DebugListPageUiState {
  List<DebugMenuItemUi> get menuItems => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  void Function(String) get onMenuItemTap => throw _privateConstructorUsedError;

  /// Create a copy of DebugListPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DebugListPageUiStateCopyWith<DebugListPageUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebugListPageUiStateCopyWith<$Res> {
  factory $DebugListPageUiStateCopyWith(
    DebugListPageUiState value,
    $Res Function(DebugListPageUiState) then,
  ) = _$DebugListPageUiStateCopyWithImpl<$Res, DebugListPageUiState>;
  @useResult
  $Res call({
    List<DebugMenuItemUi> menuItems,
    bool isLoading,
    void Function(String) onMenuItemTap,
  });
}

/// @nodoc
class _$DebugListPageUiStateCopyWithImpl<
  $Res,
  $Val extends DebugListPageUiState
>
    implements $DebugListPageUiStateCopyWith<$Res> {
  _$DebugListPageUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DebugListPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItems = null,
    Object? isLoading = null,
    Object? onMenuItemTap = null,
  }) {
    return _then(
      _value.copyWith(
            menuItems: null == menuItems
                ? _value.menuItems
                : menuItems // ignore: cast_nullable_to_non_nullable
                      as List<DebugMenuItemUi>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            onMenuItemTap: null == onMenuItemTap
                ? _value.onMenuItemTap
                : onMenuItemTap // ignore: cast_nullable_to_non_nullable
                      as void Function(String),
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DebugListPageUiStateImplCopyWith<$Res>
    implements $DebugListPageUiStateCopyWith<$Res> {
  factory _$$DebugListPageUiStateImplCopyWith(
    _$DebugListPageUiStateImpl value,
    $Res Function(_$DebugListPageUiStateImpl) then,
  ) = __$$DebugListPageUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<DebugMenuItemUi> menuItems,
    bool isLoading,
    void Function(String) onMenuItemTap,
  });
}

/// @nodoc
class __$$DebugListPageUiStateImplCopyWithImpl<$Res>
    extends _$DebugListPageUiStateCopyWithImpl<$Res, _$DebugListPageUiStateImpl>
    implements _$$DebugListPageUiStateImplCopyWith<$Res> {
  __$$DebugListPageUiStateImplCopyWithImpl(
    _$DebugListPageUiStateImpl _value,
    $Res Function(_$DebugListPageUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugListPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItems = null,
    Object? isLoading = null,
    Object? onMenuItemTap = null,
  }) {
    return _then(
      _$DebugListPageUiStateImpl(
        menuItems: null == menuItems
            ? _value._menuItems
            : menuItems // ignore: cast_nullable_to_non_nullable
                  as List<DebugMenuItemUi>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        onMenuItemTap: null == onMenuItemTap
            ? _value.onMenuItemTap
            : onMenuItemTap // ignore: cast_nullable_to_non_nullable
                  as void Function(String),
      ),
    );
  }
}

/// @nodoc

class _$DebugListPageUiStateImpl implements _DebugListPageUiState {
  const _$DebugListPageUiStateImpl({
    final List<DebugMenuItemUi> menuItems = const [],
    this.isLoading = false,
    required this.onMenuItemTap,
  }) : _menuItems = menuItems;

  final List<DebugMenuItemUi> _menuItems;
  @override
  @JsonKey()
  List<DebugMenuItemUi> get menuItems {
    if (_menuItems is EqualUnmodifiableListView) return _menuItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menuItems);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final void Function(String) onMenuItemTap;

  @override
  String toString() {
    return 'DebugListPageUiState(menuItems: $menuItems, isLoading: $isLoading, onMenuItemTap: $onMenuItemTap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebugListPageUiStateImpl &&
            const DeepCollectionEquality().equals(
              other._menuItems,
              _menuItems,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.onMenuItemTap, onMenuItemTap) ||
                other.onMenuItemTap == onMenuItemTap));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_menuItems),
    isLoading,
    onMenuItemTap,
  );

  /// Create a copy of DebugListPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DebugListPageUiStateImplCopyWith<_$DebugListPageUiStateImpl>
  get copyWith =>
      __$$DebugListPageUiStateImplCopyWithImpl<_$DebugListPageUiStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DebugListPageUiState implements DebugListPageUiState {
  const factory _DebugListPageUiState({
    final List<DebugMenuItemUi> menuItems,
    final bool isLoading,
    required final void Function(String) onMenuItemTap,
  }) = _$DebugListPageUiStateImpl;

  @override
  List<DebugMenuItemUi> get menuItems;
  @override
  bool get isLoading;
  @override
  void Function(String) get onMenuItemTap;

  /// Create a copy of DebugListPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DebugListPageUiStateImplCopyWith<_$DebugListPageUiStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DebugListPageAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() navigateToTodoList,
    required TResult Function() navigateToHandTracking,
    required TResult Function() navigateToImageAnalysis,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? navigateToTodoList,
    TResult? Function()? navigateToHandTracking,
    TResult? Function()? navigateToImageAnalysis,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? navigateToTodoList,
    TResult Function()? navigateToHandTracking,
    TResult Function()? navigateToImageAnalysis,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_NavigateToTodoList value) navigateToTodoList,
    required TResult Function(_NavigateToHandTracking value)
    navigateToHandTracking,
    required TResult Function(_NavigateToImageAnalysis value)
    navigateToImageAnalysis,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_NavigateToTodoList value)? navigateToTodoList,
    TResult? Function(_NavigateToHandTracking value)? navigateToHandTracking,
    TResult? Function(_NavigateToImageAnalysis value)? navigateToImageAnalysis,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_NavigateToTodoList value)? navigateToTodoList,
    TResult Function(_NavigateToHandTracking value)? navigateToHandTracking,
    TResult Function(_NavigateToImageAnalysis value)? navigateToImageAnalysis,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebugListPageActionCopyWith<$Res> {
  factory $DebugListPageActionCopyWith(
    DebugListPageAction value,
    $Res Function(DebugListPageAction) then,
  ) = _$DebugListPageActionCopyWithImpl<$Res, DebugListPageAction>;
}

/// @nodoc
class _$DebugListPageActionCopyWithImpl<$Res, $Val extends DebugListPageAction>
    implements $DebugListPageActionCopyWith<$Res> {
  _$DebugListPageActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DebugListPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NoneImplCopyWith<$Res> {
  factory _$$NoneImplCopyWith(
    _$NoneImpl value,
    $Res Function(_$NoneImpl) then,
  ) = __$$NoneImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoneImplCopyWithImpl<$Res>
    extends _$DebugListPageActionCopyWithImpl<$Res, _$NoneImpl>
    implements _$$NoneImplCopyWith<$Res> {
  __$$NoneImplCopyWithImpl(_$NoneImpl _value, $Res Function(_$NoneImpl) _then)
    : super(_value, _then);

  /// Create a copy of DebugListPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoneImpl implements _None {
  _$NoneImpl();

  @override
  String toString() {
    return 'DebugListPageAction.none()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoneImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() navigateToTodoList,
    required TResult Function() navigateToHandTracking,
    required TResult Function() navigateToImageAnalysis,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? navigateToTodoList,
    TResult? Function()? navigateToHandTracking,
    TResult? Function()? navigateToImageAnalysis,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? navigateToTodoList,
    TResult Function()? navigateToHandTracking,
    TResult Function()? navigateToImageAnalysis,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_NavigateToTodoList value) navigateToTodoList,
    required TResult Function(_NavigateToHandTracking value)
    navigateToHandTracking,
    required TResult Function(_NavigateToImageAnalysis value)
    navigateToImageAnalysis,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_NavigateToTodoList value)? navigateToTodoList,
    TResult? Function(_NavigateToHandTracking value)? navigateToHandTracking,
    TResult? Function(_NavigateToImageAnalysis value)? navigateToImageAnalysis,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_NavigateToTodoList value)? navigateToTodoList,
    TResult Function(_NavigateToHandTracking value)? navigateToHandTracking,
    TResult Function(_NavigateToImageAnalysis value)? navigateToImageAnalysis,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _None implements DebugListPageAction {
  factory _None() = _$NoneImpl;
}

/// @nodoc
abstract class _$$NavigateToTodoListImplCopyWith<$Res> {
  factory _$$NavigateToTodoListImplCopyWith(
    _$NavigateToTodoListImpl value,
    $Res Function(_$NavigateToTodoListImpl) then,
  ) = __$$NavigateToTodoListImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NavigateToTodoListImplCopyWithImpl<$Res>
    extends _$DebugListPageActionCopyWithImpl<$Res, _$NavigateToTodoListImpl>
    implements _$$NavigateToTodoListImplCopyWith<$Res> {
  __$$NavigateToTodoListImplCopyWithImpl(
    _$NavigateToTodoListImpl _value,
    $Res Function(_$NavigateToTodoListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugListPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NavigateToTodoListImpl implements _NavigateToTodoList {
  _$NavigateToTodoListImpl();

  @override
  String toString() {
    return 'DebugListPageAction.navigateToTodoList()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NavigateToTodoListImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() navigateToTodoList,
    required TResult Function() navigateToHandTracking,
    required TResult Function() navigateToImageAnalysis,
  }) {
    return navigateToTodoList();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? navigateToTodoList,
    TResult? Function()? navigateToHandTracking,
    TResult? Function()? navigateToImageAnalysis,
  }) {
    return navigateToTodoList?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? navigateToTodoList,
    TResult Function()? navigateToHandTracking,
    TResult Function()? navigateToImageAnalysis,
    required TResult orElse(),
  }) {
    if (navigateToTodoList != null) {
      return navigateToTodoList();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_NavigateToTodoList value) navigateToTodoList,
    required TResult Function(_NavigateToHandTracking value)
    navigateToHandTracking,
    required TResult Function(_NavigateToImageAnalysis value)
    navigateToImageAnalysis,
  }) {
    return navigateToTodoList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_NavigateToTodoList value)? navigateToTodoList,
    TResult? Function(_NavigateToHandTracking value)? navigateToHandTracking,
    TResult? Function(_NavigateToImageAnalysis value)? navigateToImageAnalysis,
  }) {
    return navigateToTodoList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_NavigateToTodoList value)? navigateToTodoList,
    TResult Function(_NavigateToHandTracking value)? navigateToHandTracking,
    TResult Function(_NavigateToImageAnalysis value)? navigateToImageAnalysis,
    required TResult orElse(),
  }) {
    if (navigateToTodoList != null) {
      return navigateToTodoList(this);
    }
    return orElse();
  }
}

abstract class _NavigateToTodoList implements DebugListPageAction {
  factory _NavigateToTodoList() = _$NavigateToTodoListImpl;
}

/// @nodoc
abstract class _$$NavigateToHandTrackingImplCopyWith<$Res> {
  factory _$$NavigateToHandTrackingImplCopyWith(
    _$NavigateToHandTrackingImpl value,
    $Res Function(_$NavigateToHandTrackingImpl) then,
  ) = __$$NavigateToHandTrackingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NavigateToHandTrackingImplCopyWithImpl<$Res>
    extends
        _$DebugListPageActionCopyWithImpl<$Res, _$NavigateToHandTrackingImpl>
    implements _$$NavigateToHandTrackingImplCopyWith<$Res> {
  __$$NavigateToHandTrackingImplCopyWithImpl(
    _$NavigateToHandTrackingImpl _value,
    $Res Function(_$NavigateToHandTrackingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugListPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NavigateToHandTrackingImpl implements _NavigateToHandTracking {
  _$NavigateToHandTrackingImpl();

  @override
  String toString() {
    return 'DebugListPageAction.navigateToHandTracking()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigateToHandTrackingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() navigateToTodoList,
    required TResult Function() navigateToHandTracking,
    required TResult Function() navigateToImageAnalysis,
  }) {
    return navigateToHandTracking();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? navigateToTodoList,
    TResult? Function()? navigateToHandTracking,
    TResult? Function()? navigateToImageAnalysis,
  }) {
    return navigateToHandTracking?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? navigateToTodoList,
    TResult Function()? navigateToHandTracking,
    TResult Function()? navigateToImageAnalysis,
    required TResult orElse(),
  }) {
    if (navigateToHandTracking != null) {
      return navigateToHandTracking();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_NavigateToTodoList value) navigateToTodoList,
    required TResult Function(_NavigateToHandTracking value)
    navigateToHandTracking,
    required TResult Function(_NavigateToImageAnalysis value)
    navigateToImageAnalysis,
  }) {
    return navigateToHandTracking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_NavigateToTodoList value)? navigateToTodoList,
    TResult? Function(_NavigateToHandTracking value)? navigateToHandTracking,
    TResult? Function(_NavigateToImageAnalysis value)? navigateToImageAnalysis,
  }) {
    return navigateToHandTracking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_NavigateToTodoList value)? navigateToTodoList,
    TResult Function(_NavigateToHandTracking value)? navigateToHandTracking,
    TResult Function(_NavigateToImageAnalysis value)? navigateToImageAnalysis,
    required TResult orElse(),
  }) {
    if (navigateToHandTracking != null) {
      return navigateToHandTracking(this);
    }
    return orElse();
  }
}

abstract class _NavigateToHandTracking implements DebugListPageAction {
  factory _NavigateToHandTracking() = _$NavigateToHandTrackingImpl;
}

/// @nodoc
abstract class _$$NavigateToImageAnalysisImplCopyWith<$Res> {
  factory _$$NavigateToImageAnalysisImplCopyWith(
    _$NavigateToImageAnalysisImpl value,
    $Res Function(_$NavigateToImageAnalysisImpl) then,
  ) = __$$NavigateToImageAnalysisImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NavigateToImageAnalysisImplCopyWithImpl<$Res>
    extends
        _$DebugListPageActionCopyWithImpl<$Res, _$NavigateToImageAnalysisImpl>
    implements _$$NavigateToImageAnalysisImplCopyWith<$Res> {
  __$$NavigateToImageAnalysisImplCopyWithImpl(
    _$NavigateToImageAnalysisImpl _value,
    $Res Function(_$NavigateToImageAnalysisImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugListPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NavigateToImageAnalysisImpl implements _NavigateToImageAnalysis {
  _$NavigateToImageAnalysisImpl();

  @override
  String toString() {
    return 'DebugListPageAction.navigateToImageAnalysis()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigateToImageAnalysisImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() navigateToTodoList,
    required TResult Function() navigateToHandTracking,
    required TResult Function() navigateToImageAnalysis,
  }) {
    return navigateToImageAnalysis();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? navigateToTodoList,
    TResult? Function()? navigateToHandTracking,
    TResult? Function()? navigateToImageAnalysis,
  }) {
    return navigateToImageAnalysis?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? navigateToTodoList,
    TResult Function()? navigateToHandTracking,
    TResult Function()? navigateToImageAnalysis,
    required TResult orElse(),
  }) {
    if (navigateToImageAnalysis != null) {
      return navigateToImageAnalysis();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_NavigateToTodoList value) navigateToTodoList,
    required TResult Function(_NavigateToHandTracking value)
    navigateToHandTracking,
    required TResult Function(_NavigateToImageAnalysis value)
    navigateToImageAnalysis,
  }) {
    return navigateToImageAnalysis(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_NavigateToTodoList value)? navigateToTodoList,
    TResult? Function(_NavigateToHandTracking value)? navigateToHandTracking,
    TResult? Function(_NavigateToImageAnalysis value)? navigateToImageAnalysis,
  }) {
    return navigateToImageAnalysis?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_NavigateToTodoList value)? navigateToTodoList,
    TResult Function(_NavigateToHandTracking value)? navigateToHandTracking,
    TResult Function(_NavigateToImageAnalysis value)? navigateToImageAnalysis,
    required TResult orElse(),
  }) {
    if (navigateToImageAnalysis != null) {
      return navigateToImageAnalysis(this);
    }
    return orElse();
  }
}

abstract class _NavigateToImageAnalysis implements DebugListPageAction {
  factory _NavigateToImageAnalysis() = _$NavigateToImageAnalysisImpl;
}
