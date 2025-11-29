import 'package:go_router/go_router.dart';
import 'package:presentation/debug/debug_list_page.dart';
import 'package:presentation/hand_tracking/hand_tracking_page.dart';
import 'package:presentation/home/home_page.dart';
import 'package:presentation/todo/todo_list_page.dart';
import 'package:presentation/video_generation/video_generation_page.dart';

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
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
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
      path: '/video-generation',
      name: 'videoGeneration',
      builder: (context, state) => const VideoGenerationPage(),
    ),
  ],
);
