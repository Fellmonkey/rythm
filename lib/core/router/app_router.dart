import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/garden/presentation/screens/time_path_screen.dart';
import '../../features/habits/presentation/screens/greenhouse_screen.dart';
import '../../features/habits/presentation/screens/habit_detail_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import 'shell_scaffold.dart';

/// Root navigator key — used by the debug overlay to access the Navigator.
final rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => ShellScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: GreenhouseScreen(),
          ),
        ),
        GoRoute(
          path: '/garden',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TimePathScreen(),
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/habit/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return HabitDetailScreen(habitId: id);
      },
    ),
  ],
);
