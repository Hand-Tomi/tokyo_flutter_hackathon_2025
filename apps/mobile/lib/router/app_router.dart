import 'package:go_router/go_router.dart';
import 'package:presentation/debug/debug_list_page.dart';
import 'package:presentation/hand_tracking/hand_tracking_page.dart';
import 'package:presentation/todo/todo_list_page.dart';
import 'package:presentation/voice_chat/voice_chat_page.dart';

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
    GoRoute(
      path: '/hand-tracking',
      name: 'handTracking',
      builder: (context, state) => const HandTrackingPage(),
    ),
    GoRoute(
      path: '/voice-chat',
      name: 'voiceChat',
      builder: (context, state) => const VoiceChatPage(),
    ),
  ],
);
