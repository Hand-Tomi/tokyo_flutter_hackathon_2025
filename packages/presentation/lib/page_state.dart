import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_state.freezed.dart';

/// ページ状態の汎用ラッパー
///
/// [uiState]: 継続的なUI状態（画面に表示するデータ）
/// [action]: 一度だけ実行されるアクション（ダイアログ表示、画面遷移など）
@freezed
class PageState<TUiState, TAction> with _$PageState<TUiState, TAction> {
  const factory PageState({
    required TUiState uiState,
    required TAction action,
  }) = _PageState<TUiState, TAction>;
}
