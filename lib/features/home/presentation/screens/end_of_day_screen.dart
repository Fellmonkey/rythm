import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/home_providers.dart';

/// Ключ shared_preferences — дата последнего завершённого End of Day.
const _lastEndOfDayKey = 'last_end_of_day';

/// Провайдер — нужно ли показать End of Day Review.
final shouldShowEndOfDayProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final last = prefs.getString(_lastEndOfDayKey);
  final today = DateTime.now();
  final todayStr =
      '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

  if (last == todayStr) return false; // уже показывали сегодня

  // Показывать после 21:00 (или позже — зависит от dayStartHour)
  final hour = today.hour;
  return hour >= 21;
});

/// Вечерний Review — подведение итогов дня.
class EndOfDayScreen extends ConsumerWidget {
  const EndOfDayScreen({super.key, required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressData = ref.watch(todayProgressProvider);
    final (completed, total) = progressData;
    final habitsAsync = ref.watch(todayHabitsWithStatusProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const Spacer(),
              // Иконка
              Icon(
                completed == total && total > 0
                    ? Icons.auto_awesome
                    : Icons.nights_stay_outlined,
                size: 72,
                color: AppColors.accent,
              ),
              const SizedBox(height: 24),

              // Заголовок
              Text(
                completed == total && total > 0
                    ? 'Отличный день!'
                    : 'День подходит к концу',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Подзаголовок с философией
              const Text(
                'Каждый шаг — это прогресс.\nОтдых тоже часть ритма.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Прогресс
              _ProgressRing(completed: completed, total: total),
              const SizedBox(height: 16),
              Text(
                '$completed из $total',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                total > 0
                    ? '${(completed / total * 100).toStringAsFixed(0)}% выполнено'
                    : 'Нет привычек на сегодня',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),

              // Мини-список результатов
              const SizedBox(height: 24),
              habitsAsync.when(
                data: (habits) => _MiniSummary(habits: habits),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),

              const Spacer(),

              // Кнопка «Завершить день»
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _finish(context, ref),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Завершить день',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: onDismiss,
                child: const Text(
                  'Пропустить',
                  style: TextStyle(color: AppColors.textHint),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _finish(BuildContext context, WidgetRef ref) async {
    HapticFeedback.heavyImpact();
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final todayStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    await prefs.setString(_lastEndOfDayKey, todayStr);
    onDismiss();
  }
}

/// Мини-кольцо прогресса.
class _ProgressRing extends StatelessWidget {
  const _ProgressRing({required this.completed, required this.total});
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? completed / total : 0.0;
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 8,
              backgroundColor: AppColors.surfaceVariant,
              color: AppColors.accent,
            ),
          ),
          Icon(
            Icons.eco,
            size: 40,
            color: AppColors.accent.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}

/// Компактный список результатов дня.
class _MiniSummary extends StatelessWidget {
  const _MiniSummary({required this.habits});
  final List<HabitWithStatus> habits;

  @override
  Widget build(BuildContext context) {
    if (habits.isEmpty) return const SizedBox.shrink();

    // Показываем максимум 5
    final display = habits.take(5).toList();
    return Column(
      children: display.map((h) {
        IconData icon;
        Color iconColor;
        if (h.isCompleted) {
          icon = Icons.check_circle;
          iconColor = AppColors.success;
        } else if (h.isPartial) {
          icon = Icons.radio_button_checked;
          iconColor = AppColors.accent.withValues(alpha: 0.6);
        } else if (h.isSkipped) {
          icon = Icons.pause_circle_outline;
          iconColor = AppColors.skip;
        } else {
          icon = Icons.circle_outlined;
          iconColor = AppColors.textHint;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  h.habit.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
