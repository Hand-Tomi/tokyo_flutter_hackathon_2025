// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_page_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoListPageViewModelHash() =>
    r'5bb1ad99b2c377af1b18e2ecb3fd0123f0281e5c';

/// Todo リストページの ViewModel
///
/// ビジネスロジックと状態管理を担当
///
/// Copied from [TodoListPageViewModel].
@ProviderFor(TodoListPageViewModel)
final todoListPageViewModelProvider =
    AutoDisposeNotifierProvider<
      TodoListPageViewModel,
      PageState<TodoListPageUiState, TodoListPageAction>
    >.internal(
      TodoListPageViewModel.new,
      name: r'todoListPageViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todoListPageViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodoListPageViewModel =
    AutoDisposeNotifier<PageState<TodoListPageUiState, TodoListPageAction>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
