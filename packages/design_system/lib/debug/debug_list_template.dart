import 'package:design_system/debug/debug_list_ui_state.dart';
import 'package:flutter/material.dart';

/// 디버그 리스트 페이지 Template
/// 순수한 UI 레이아웃 (상태 관리 없음)
class DebugListPageTemplate extends StatelessWidget {
  const DebugListPageTemplate({
    super.key,
    required this.uiState,
  });

  final DebugListPageUiState uiState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('디버그 메뉴'),
      ),
      body: uiState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : uiState.menuItems.isEmpty
              ? const Center(
                  child: Text(
                    '메뉴 항목이 없습니다',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: uiState.menuItems.length,
                  itemBuilder: (context, index) {
                    final item = uiState.menuItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.arrow_forward_ios),
                        title: Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(item.description),
                        onTap: () => uiState.onMenuItemTap(item.id),
                      ),
                    );
                  },
                ),
    );
  }
}
