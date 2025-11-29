import 'package:go_router/go_router.dart';
import 'package:presentation/debug/debug_list_page.dart';
import 'package:presentation/hand_tracking/hand_tracking_page.dart';
import 'package:presentation/step1_home/home_page.dart';
import 'package:presentation/step2_scene_creation/scene_creation_page.dart';
import 'package:presentation/step3_scene_list/scene_list_page.dart';
import 'package:presentation/todo/todo_list_page.dart';
import 'package:presentation/step4_video_generation/video_generation_page.dart';
import 'package:presentation/step5_video_playback/video_playback_page.dart';
import 'package:presentation/step7_my_stories/my_stories_list_page.dart';

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
      builder: (context, state) {
        final slideshowIdStr = state.uri.queryParameters['slideshowId'];
        final slideshowId =
            slideshowIdStr != null ? int.tryParse(slideshowIdStr) : null;
        return VideoPlaybackPage(slideshowId: slideshowId);
      },
    ),
    GoRoute(
      path: '/my-stories',
      name: 'myStories',
      builder: (context, state) => const MyStoriesListPage(),
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
