import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../di/energy_providers.dart';

/// Неблокирующий виджет выбора уровня энергии (1-3).
///
/// Отображается в верхней части экрана «Сегодня»,
/// если энергия ещё не выбрана.
class EnergySelector extends ConsumerWidget {
  const EnergySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final energyAsync = ref.watch(todayEnergyProvider);

    return energyAsync.when(
      data: (energy) {
        if (energy != null) {
          return _EnergyDisplay(level: energy.energyLevel);
        }
        return _EnergyPicker(
          onSelected: (level) async {
            await ref.read(energyRepositoryProvider).log(level);
            if (context.mounted) {
              HapticFeedback.lightImpact();
            }
          },
        );
      },
      loading: () => const SizedBox(height: 64),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _EnergyPicker extends StatelessWidget {
  const _EnergyPicker({required this.onSelected});

  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Как ваша энергия сегодня?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _EnergyButton(
                  level: 1,
                  label: 'Низкая',
                  color: AppColors.energyLow,
                  icon: Icons.battery_1_bar,
                  onTap: () => onSelected(1),
                ),
                const SizedBox(width: 8),
                _EnergyButton(
                  level: 2,
                  label: 'Средняя',
                  color: AppColors.energyMedium,
                  icon: Icons.battery_4_bar,
                  onTap: () => onSelected(2),
                ),
                const SizedBox(width: 8),
                _EnergyButton(
                  level: 3,
                  label: 'Высокая',
                  color: AppColors.energyHigh,
                  icon: Icons.battery_full,
                  onTap: () => onSelected(3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EnergyButton extends StatelessWidget {
  const _EnergyButton({
    required this.level,
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final int level;
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(height: 4),
                Text(label, style: TextStyle(color: color, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EnergyDisplay extends StatelessWidget {
  const _EnergyDisplay({required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = switch (level) {
      1 => ('Низкая энергия', AppColors.energyLow, Icons.battery_1_bar),
      2 => ('Средняя энергия', AppColors.energyMedium, Icons.battery_4_bar),
      _ => ('Высокая энергия', AppColors.energyHigh, Icons.battery_full),
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: color, fontSize: 14)),
        ],
      ),
    );
  }
}
