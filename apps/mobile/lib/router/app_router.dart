import 'package:go_router/go_router.dart';
import 'package:presentation/debug/debug_list_page.dart';
import 'package:presentation/todo/todo_list_page.dart';

/// アプリ全体のルーター設定
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'debug',
      builder: (context, state) => const DebugListPage(),
    ),
    GoRoute(
      path: '/todo',
      name: 'todo',
      builder: (context, state) => const TodoListPage(),
    ),
  ],
);
