import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../database/app_database.dart';

/// Карточка привычки на экране «Сегодня».
class HabitCard extends ConsumerWidget {
  const HabitCard({
    super.key,
    required this.habit,
    this.log,
    required this.onToggle,
    required this.onUpdate,
    required this.onSkip,
    required this.onTap,
  });

  final Habit habit;
  final HabitLog? log;
  final VoidCallback onToggle;
  final ValueChanged<int> onUpdate;
  final VoidCallback onSkip;
  final VoidCallback onTap;

  bool get _isCompleted =>
      log != null && log!.status == AppConstants.statusComplete;
  bool get _isPartial =>
      log != null && log!.status == AppConstants.statusPartial;
  bool get _isSkipped => log != null && log!.skipReasonId != null;

  double get _progress {
    if (habit.targetValue <= 0) return 0;
    return ((log?.actualValue ?? 0) / habit.targetValue).clamp(0.0, 1.0);
  }

  Color get _statusColor {
    if (_isSkipped) return AppColors.skip;
    if (_isCompleted) return AppColors.success;
    if (_isPartial) return AppColors.partial;
    return AppColors.surfaceVariant;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: _statusColor.withValues(alpha: _isCompleted ? 0.15 : 0.08),
      child: InkWell(
        onTap: () {
          if (habit.type == AppConstants.habitTypeBinary) {
            onToggle();
            HapticFeedback.lightImpact();
          } else {
            onTap();
          }
        },
        onLongPress: () => _showOptions(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildLeading(),
              const SizedBox(width: 12),
              Expanded(child: _buildContent(context)),
              if (habit.type != AppConstants.habitTypeBinary)
                _buildValueDisplay(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeading() {
    if (habit.type == AppConstants.habitTypeBinary) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isCompleted
              ? AppColors.success
              : _isSkipped
              ? AppColors.skip
              : Colors.transparent,
          border: Border.all(
            color: _isCompleted
                ? AppColors.success
                : _isSkipped
                ? AppColors.skip
                : AppColors.textSecondary,
            width: 2,
          ),
        ),
        child: _isCompleted
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : _isSkipped
            ? const Icon(Icons.remove, size: 18, color: Colors.white)
            : null,
      );
    }

    // Для counter/duration — прогресс-бар в виде круга
    return SizedBox(
      width: 28,
      height: 28,
      child: CircularProgressIndicator(
        value: _progress,
        strokeWidth: 3,
        backgroundColor: AppColors.surfaceVariant,
        color: _isCompleted ? AppColors.success : AppColors.partial,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          habit.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _isCompleted || _isSkipped
                ? AppColors.textSecondary
                : AppColors.textPrimary,
            decoration: _isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        if (habit.description != null && habit.description!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              habit.description!,
              style: const TextStyle(fontSize: 12, color: AppColors.textHint),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }

  Widget _buildValueDisplay(BuildContext context) {
    final actual = log?.actualValue ?? 0;
    final target = habit.targetValue;
    final unit = habit.unit ?? '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '$actual/$target $unit'.trim(),
          style: TextStyle(
            fontSize: 13,
            color: _isCompleted ? AppColors.success : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.skip_next, color: AppColors.skip),
              title: const Text('Пропустить сегодня'),
              subtitle: const Text('Не ломает серию'),
              onTap: () {
                Navigator.pop(ctx);
                onSkip();
              },
            ),
          ],
        ),
      ),
    );
  }
}
