import 'package:go_router/go_router.dart';
import 'package:presentation/debug/debug_list_page.dart';
import 'package:presentation/hand_tracking/hand_tracking_page.dart';
import 'package:presentation/home/home_page.dart';
import 'package:presentation/save_share/save_share_page.dart';
import 'package:presentation/scene_creation/scene_creation_page.dart';
import 'package:presentation/scene_list/scene_list_page.dart';
import 'package:presentation/todo/todo_list_page.dart';
import 'package:presentation/video_generation/video_generation_page.dart';
import 'package:presentation/video_playback/video_playback_page.dart';

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
    // StorySpark 화면들
    GoRoute(
      path: '/scene-creation',
      name: 'sceneCreation',
      builder: (context, state) => const SceneCreationPage(),
    ),
    GoRoute(
      path: '/scene-list',
      name: 'sceneList',
      builder: (context, state) => const SceneListPage(),
    ),
    GoRoute(
      path: '/video-generation',
      name: 'videoGeneration',
      builder: (context, state) => const VideoGenerationPage(),
    ),
    GoRoute(
      path: '/video-playback',
      name: 'videoPlayback',
      builder: (context, state) => const VideoPlaybackPage(),
    ),
    GoRoute(
      path: '/save-share',
      name: 'saveShare',
      builder: (context, state) => const SaveSharePage(),
    ),
    // 기존 화면들
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
  ],
);
