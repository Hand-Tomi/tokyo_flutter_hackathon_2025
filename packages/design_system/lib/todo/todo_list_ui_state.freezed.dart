// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_list_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TodoListPageUiState {
  List<TodoUi> get todos => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of TodoListPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoListPageUiStateCopyWith<TodoListPageUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoListPageUiStateCopyWith<$Res> {
  factory $TodoListPageUiStateCopyWith(
    TodoListPageUiState value,
    $Res Function(TodoListPageUiState) then,
  ) = _$TodoListPageUiStateCopyWithImpl<$Res, TodoListPageUiState>;
  @useResult
  $Res call({List<TodoUi> todos, bool isLoading});
}

/// @nodoc
class _$TodoListPageUiStateCopyWithImpl<$Res, $Val extends TodoListPageUiState>
    implements $TodoListPageUiStateCopyWith<$Res> {
  _$TodoListPageUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoListPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? todos = null, Object? isLoading = null}) {
    return _then(
      _value.copyWith(
            todos: null == todos
                ? _value.todos
                : todos // ignore: cast_nullable_to_non_nullable
                      as List<TodoUi>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TodoListPageUiStateImplCopyWith<$Res>
    implements $TodoListPageUiStateCopyWith<$Res> {
  factory _$$TodoListPageUiStateImplCopyWith(
    _$TodoListPageUiStateImpl value,
    $Res Function(_$TodoListPageUiStateImpl) then,
  ) = __$$TodoListPageUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TodoUi> todos, bool isLoading});
}

/// @nodoc
class __$$TodoListPageUiStateImplCopyWithImpl<$Res>
    extends _$TodoListPageUiStateCopyWithImpl<$Res, _$TodoListPageUiStateImpl>
    implements _$$TodoListPageUiStateImplCopyWith<$Res> {
  __$$TodoListPageUiStateImplCopyWithImpl(
    _$TodoListPageUiStateImpl _value,
    $Res Function(_$TodoListPageUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoListPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? todos = null, Object? isLoading = null}) {
    return _then(
      _$TodoListPageUiStateImpl(
        todos: null == todos
            ? _value._todos
            : todos // ignore: cast_nullable_to_non_nullable
                  as List<TodoUi>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$TodoListPageUiStateImpl implements _TodoListPageUiState {
  const _$TodoListPageUiStateImpl({
    final List<TodoUi> todos = const [],
    this.isLoading = false,
  }) : _todos = todos;

  final List<TodoUi> _todos;
  @override
  @JsonKey()
  List<TodoUi> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'TodoListPageUiState(todos: $todos, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoListPageUiStateImpl &&
            const DeepCollectionEquality().equals(other._todos, _todos) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_todos),
    isLoading,
  );

  /// Create a copy of TodoListPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoListPageUiStateImplCopyWith<_$TodoListPageUiStateImpl> get copyWith =>
      __$$TodoListPageUiStateImplCopyWithImpl<_$TodoListPageUiStateImpl>(
        this,
        _$identity,
      );
}

abstract class _TodoListPageUiState implements TodoListPageUiState {
  const factory _TodoListPageUiState({
    final List<TodoUi> todos,
    final bool isLoading,
  }) = _$TodoListPageUiStateImpl;

  @override
  List<TodoUi> get todos;
  @override
  bool get isLoading;

  /// Create a copy of TodoListPageUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoListPageUiStateImplCopyWith<_$TodoListPageUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TodoListPageAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() showAddDialog,
    required TResult Function(String message) showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? showAddDialog,
    TResult? Function(String message)? showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? showAddDialog,
    TResult Function(String message)? showError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_ShowAddDialog value) showAddDialog,
    required TResult Function(_ShowError value) showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowAddDialog value)? showAddDialog,
    TResult? Function(_ShowError value)? showError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowAddDialog value)? showAddDialog,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoListPageActionCopyWith<$Res> {
  factory $TodoListPageActionCopyWith(
    TodoListPageAction value,
    $Res Function(TodoListPageAction) then,
  ) = _$TodoListPageActionCopyWithImpl<$Res, TodoListPageAction>;
}

/// @nodoc
class _$TodoListPageActionCopyWithImpl<$Res, $Val extends TodoListPageAction>
    implements $TodoListPageActionCopyWith<$Res> {
  _$TodoListPageActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoListPageAction
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
    extends _$TodoListPageActionCopyWithImpl<$Res, _$NoneImpl>
    implements _$$NoneImplCopyWith<$Res> {
  __$$NoneImplCopyWithImpl(_$NoneImpl _value, $Res Function(_$NoneImpl) _then)
    : super(_value, _then);

  /// Create a copy of TodoListPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoneImpl implements _None {
  _$NoneImpl();

  @override
  String toString() {
    return 'TodoListPageAction.none()';
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
    required TResult Function() showAddDialog,
    required TResult Function(String message) showError,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? showAddDialog,
    TResult? Function(String message)? showError,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? showAddDialog,
    TResult Function(String message)? showError,
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
    required TResult Function(_ShowAddDialog value) showAddDialog,
    required TResult Function(_ShowError value) showError,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowAddDialog value)? showAddDialog,
    TResult? Function(_ShowError value)? showError,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowAddDialog value)? showAddDialog,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _None implements TodoListPageAction {
  factory _None() = _$NoneImpl;
}

/// @nodoc
abstract class _$$ShowAddDialogImplCopyWith<$Res> {
  factory _$$ShowAddDialogImplCopyWith(
    _$ShowAddDialogImpl value,
    $Res Function(_$ShowAddDialogImpl) then,
  ) = __$$ShowAddDialogImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShowAddDialogImplCopyWithImpl<$Res>
    extends _$TodoListPageActionCopyWithImpl<$Res, _$ShowAddDialogImpl>
    implements _$$ShowAddDialogImplCopyWith<$Res> {
  __$$ShowAddDialogImplCopyWithImpl(
    _$ShowAddDialogImpl _value,
    $Res Function(_$ShowAddDialogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoListPageAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShowAddDialogImpl implements _ShowAddDialog {
  _$ShowAddDialogImpl();

  @override
  String toString() {
    return 'TodoListPageAction.showAddDialog()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShowAddDialogImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() showAddDialog,
    required TResult Function(String message) showError,
  }) {
    return showAddDialog();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? showAddDialog,
    TResult? Function(String message)? showError,
  }) {
    return showAddDialog?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? showAddDialog,
    TResult Function(String message)? showError,
    required TResult orElse(),
  }) {
    if (showAddDialog != null) {
      return showAddDialog();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_ShowAddDialog value) showAddDialog,
    required TResult Function(_ShowError value) showError,
  }) {
    return showAddDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowAddDialog value)? showAddDialog,
    TResult? Function(_ShowError value)? showError,
  }) {
    return showAddDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowAddDialog value)? showAddDialog,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) {
    if (showAddDialog != null) {
      return showAddDialog(this);
    }
    return orElse();
  }
}

abstract class _ShowAddDialog implements TodoListPageAction {
  factory _ShowAddDialog() = _$ShowAddDialogImpl;
}

/// @nodoc
abstract class _$$ShowErrorImplCopyWith<$Res> {
  factory _$$ShowErrorImplCopyWith(
    _$ShowErrorImpl value,
    $Res Function(_$ShowErrorImpl) then,
  ) = __$$ShowErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ShowErrorImplCopyWithImpl<$Res>
    extends _$TodoListPageActionCopyWithImpl<$Res, _$ShowErrorImpl>
    implements _$$ShowErrorImplCopyWith<$Res> {
  __$$ShowErrorImplCopyWithImpl(
    _$ShowErrorImpl _value,
    $Res Function(_$ShowErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoListPageAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ShowErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ShowErrorImpl implements _ShowError {
  _$ShowErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TodoListPageAction.showError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TodoListPageAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowErrorImplCopyWith<_$ShowErrorImpl> get copyWith =>
      __$$ShowErrorImplCopyWithImpl<_$ShowErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() showAddDialog,
    required TResult Function(String message) showError,
  }) {
    return showError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? showAddDialog,
    TResult? Function(String message)? showError,
  }) {
    return showError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? showAddDialog,
    TResult Function(String message)? showError,
    required TResult orElse(),
  }) {
    if (showError != null) {
      return showError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_None value) none,
    required TResult Function(_ShowAddDialog value) showAddDialog,
    required TResult Function(_ShowError value) showError,
  }) {
    return showError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_None value)? none,
    TResult? Function(_ShowAddDialog value)? showAddDialog,
    TResult? Function(_ShowError value)? showError,
  }) {
    return showError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_None value)? none,
    TResult Function(_ShowAddDialog value)? showAddDialog,
    TResult Function(_ShowError value)? showError,
    required TResult orElse(),
  }) {
    if (showError != null) {
      return showError(this);
    }
    return orElse();
  }
}

abstract class _ShowError implements TodoListPageAction {
  factory _ShowError(final String message) = _$ShowErrorImpl;

  String get message;

  /// Create a copy of TodoListPageAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowErrorImplCopyWith<_$ShowErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
