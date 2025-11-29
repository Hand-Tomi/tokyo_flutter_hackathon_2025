import 'package:design_system/home/home_page_ui_state.dart';
import 'package:flutter/material.dart';

/// Home 페이지 Template
/// 순수한 UI 레이아웃 (상태 관리 없음)
class HomePageTemplate extends StatelessWidget {
  const HomePageTemplate({super.key, required this.uiState});

  final HomePageUiState uiState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const SizedBox.shrink(),
    );
  }
}
