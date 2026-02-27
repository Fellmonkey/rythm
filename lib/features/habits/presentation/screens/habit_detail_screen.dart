import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Habit detail screen — shows stats, heatmap, streak info.
/// Placeholder; full implementation in Phase 3.
class HabitDetailScreen extends ConsumerWidget {
  const HabitDetailScreen({required this.habitId, super.key});

  final int habitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Привычка #$habitId'),
      ),
      body: Center(
        child: Text('Детали привычки $habitId'),
      ),
    );
  }
}
