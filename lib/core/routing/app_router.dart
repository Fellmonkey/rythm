import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/backups/presentation/screens/backup_screen.dart';
import '../../features/habits/presentation/screens/habit_form_screen.dart';
import '../../features/habits/presentation/screens/habits_list_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/spheres/presentation/screens/spheres_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return _MainShell(navigationShell: navigationShell);
      },
      branches: [
        // Вкладка «Сегодня»
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          ],
        ),
        // Вкладка «Привычки»
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/habits',
              builder: (context, state) => const HabitsListScreen(),
              routes: [
                GoRoute(
                  path: 'create',
                  builder: (context, state) => const HabitFormScreen(),
                ),
                GoRoute(
                  path: ':id/edit',
                  builder: (context, state) {
                    final id = int.parse(state.pathParameters['id']!);
                    return HabitFormScreen(habitId: id);
                  },
                ),
              ],
            ),
          ],
        ),
        // Вкладка «Настройки»
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'spheres',
                  builder: (context, state) => const SpheresScreen(),
                ),
                GoRoute(
                  path: 'backup',
                  builder: (context, state) => const BackupScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class _MainShell extends StatelessWidget {
  const _MainShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.today_outlined),
            selectedIcon: Icon(Icons.today),
            label: 'Сегодня',
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: 'Привычки',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}
