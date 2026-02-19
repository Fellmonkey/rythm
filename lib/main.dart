import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/providers/app_providers.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/screens/onboarding_screen.dart';

/// Флаг первого запуска — проверяем shared_preferences.
final onboardingCompleteProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_complete') ?? false;
});

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: RythmApp()));
}

class RythmApp extends ConsumerWidget {
  const RythmApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final integrity = ref.watch(dbIntegrityProvider);
    final onboarding = ref.watch(onboardingCompleteProvider);

    final dbOk = integrity.value ?? false;
    final onboardingDone = onboarding.value ?? true;
    final isLoading = integrity.isLoading || onboarding.isLoading;

    if (isLoading) {
      return _buildApp(
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
      );
    }

    if (!dbOk) {
      return _buildApp(
        child: _DbErrorScreen(
          message: integrity.error?.toString(),
          onRetry: () => ref.invalidate(dbIntegrityProvider),
        ),
      );
    }

    if (!onboardingDone) {
      return _buildApp(
        child: OnboardingScreen(
          onComplete: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('onboarding_complete', true);
            ref.invalidate(onboardingCompleteProvider);
          },
        ),
      );
    }

    return MaterialApp.router(
      title: 'Ритм',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }

  Widget _buildApp({required Widget child}) {
    return MaterialApp(
      title: 'Ритм',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: child,
    );
  }
}

class _DbErrorScreen extends StatelessWidget {
  const _DbErrorScreen({this.message, required this.onRetry});
  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 64,
                color: AppColors.warning,
              ),
              const SizedBox(height: 16),
              Text(
                'Проблема с базой данных',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message ?? 'Проверка целостности не пройдена.',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Повторить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
