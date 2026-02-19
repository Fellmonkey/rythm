import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/app_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../../database/app_database.dart';
import '../../../energy_tracker/presentation/widgets/energy_selector.dart';
import '../../../habit_logs/di/habit_log_providers.dart';
import '../../../habits/presentation/widgets/habit_card.dart';
import '../providers/home_providers.dart';
import 'end_of_day_screen.dart';

/// Обёртка: показывает End of Day Review или обычный HomeScreen.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _endOfDayDismissed = false;

  @override
  Widget build(BuildContext context) {
    final endOfDay = ref.watch(shouldShowEndOfDayProvider);
    final showReview = endOfDay.value == true && !_endOfDayDismissed;

    if (showReview) {
      return EndOfDayScreen(
        onDismiss: () => setState(() => _endOfDayDismissed = true),
      );
    }

    return const _HomeContent();
  }
}

/// Основной контент экрана «Сегодня».
class _HomeContent extends ConsumerWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusMode = ref.watch(focusModeProvider);
    final todayData = focusMode
        ? ref.watch(focusHabitsProvider)
        : ref.watch(todayHabitsWithStatusProvider);
    final (completed, total) = ref.watch(todayProgressProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              focusMode ? 'Фокус' : 'Сегодня',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              DateHelper.formatDate(DateTime.now()),
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          // Focus Mode toggle
          IconButton(
            icon: Icon(
              focusMode ? Icons.filter_alt : Icons.filter_alt_outlined,
              color: focusMode ? AppColors.accent : AppColors.textHint,
            ),
            tooltip: focusMode ? 'Выключить фокус' : 'Режим фокус',
            onPressed: () => ref.read(focusModeProvider.notifier).toggle(),
          ),
          if (total > 0)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '$completed/$total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: completed == total && total > 0
                        ? AppColors.success
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: todayData.when(
        data: (habits) {
          if (habits.isEmpty) {
            return _EmptyState();
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 80),
            children: [
              const EnergySelector(),
              const SizedBox(height: 8),
              ...habits.map(
                (item) => HabitCard(
                  habit: item.habit,
                  log: item.log,
                  onToggle: () => _toggleBinary(ref, item),
                  onUpdate: (value) => _updateValue(ref, item, value),
                  onSkip: () => _skipHabit(context, ref, item),
                  onTap: () {
                    if (item.habit.type != AppConstants.habitTypeBinary) {
                      _showValueInput(context, ref, item);
                    }
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            'Ошибка: $e',
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/habits/create'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _toggleBinary(WidgetRef ref, HabitWithStatus item) async {
    final repo = ref.read(habitLogRepositoryProvider);
    final now = DateTime.now().toUtc();

    if (item.log == null) {
      await repo.log(
        HabitLogsCompanion.insert(
          habitId: item.habit.id,
          status: AppConstants.statusComplete,
          actualValue: Value(item.habit.targetValue),
          timestamp: now,
          createdAt: now,
          updatedAt: now,
        ),
      );
    } else if (item.isCompleted) {
      // Убрать выполнение
      await repo.updateLog(
        item.log!.id,
        HabitLogsCompanion(
          status: const Value(AppConstants.statusMissed),
          actualValue: const Value(0),
        ),
      );
    } else {
      await repo.updateLog(
        item.log!.id,
        HabitLogsCompanion(
          status: const Value(AppConstants.statusComplete),
          actualValue: Value(item.habit.targetValue),
        ),
      );
    }
  }

  Future<void> _updateValue(
    WidgetRef ref,
    HabitWithStatus item,
    int value,
  ) async {
    final repo = ref.read(habitLogRepositoryProvider);
    final newValue = (item.log?.actualValue ?? 0) + value;
    final status = newValue >= item.habit.targetValue
        ? AppConstants.statusComplete
        : newValue >= item.habit.minValue
        ? AppConstants.statusPartial
        : AppConstants.statusMissed;

    final now = DateTime.now().toUtc();
    if (item.log == null) {
      await repo.log(
        HabitLogsCompanion.insert(
          habitId: item.habit.id,
          status: status,
          actualValue: Value(newValue),
          timestamp: now,
          createdAt: now,
          updatedAt: now,
        ),
      );
    } else {
      await repo.updateLog(
        item.log!.id,
        HabitLogsCompanion(status: Value(status), actualValue: Value(newValue)),
      );
    }
  }

  void _showValueInput(
    BuildContext context,
    WidgetRef ref,
    HabitWithStatus item,
  ) {
    final controller = TextEditingController();
    final unit = item.habit.unit ?? '';
    final isDuration = item.habit.type == AppConstants.habitTypeDuration;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.habit.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              isDuration
                  ? 'Сколько минут? (${item.log?.actualValue ?? 0}/${item.habit.targetValue} $unit)'
                  : 'Сколько сделали? (${item.log?.actualValue ?? 0}/${item.habit.targetValue} $unit)',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: isDuration ? 'Минуты' : 'Количество',
                suffixText: unit,
              ),
              onSubmitted: (val) {
                final v = int.tryParse(val);
                if (v != null && v > 0) {
                  _updateValue(ref, item, v);
                  HapticFeedback.lightImpact();
                  Navigator.pop(ctx);
                }
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final v = int.tryParse(controller.text);
                  if (v != null && v > 0) {
                    _updateValue(ref, item, v);
                    HapticFeedback.lightImpact();
                    Navigator.pop(ctx);
                  }
                },
                child: const Text('Записать'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _skipHabit(BuildContext context, WidgetRef ref, HabitWithStatus item) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Причина пропуска',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            ...AppConstants.skipReasonLabels.entries.map(
              (e) => ListTile(
                leading: const Icon(Icons.skip_next, color: AppColors.skip),
                title: Text(e.value),
                onTap: () async {
                  Navigator.pop(ctx);
                  await _doSkip(ref, item, e.key);
                  if (context.mounted) {
                    HapticFeedback.mediumImpact();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _doSkip(
    WidgetRef ref,
    HabitWithStatus item,
    String reason,
  ) async {
    final db = ref.read(habitLogRepositoryProvider);

    // Создать skip_day запись
    final dbInstance = ref.read(databaseProvider);
    final now = DateTime.now().toUtc();
    final skipId = await dbInstance
        .into(dbInstance.skipDays)
        .insert(
          SkipDaysCompanion.insert(reason: reason, date: now, createdAt: now),
        );

    if (item.log == null) {
      await db.log(
        HabitLogsCompanion.insert(
          habitId: item.habit.id,
          status: AppConstants.statusMissed,
          skipReasonId: Value(skipId),
          timestamp: now,
          createdAt: now,
          updatedAt: now,
        ),
      );
    } else {
      await db.updateLog(
        item.log!.id,
        HabitLogsCompanion(skipReasonId: Value(skipId)),
      );
    }
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.eco_outlined,
            size: 80,
            color: AppColors.accent.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Начните свой ритм',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Создайте первую привычку\nи сделайте первый шаг',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.go('/habits/create'),
            icon: const Icon(Icons.add),
            label: const Text('Создать привычку'),
          ),
        ],
      ),
    );
  }
}
