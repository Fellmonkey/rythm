import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Time Path (Тропа Времени) — scrollable garden of crystallized plants.
/// Placeholder; full implementation in Phase 6.
class TimePathScreen extends ConsumerWidget {
  const TimePathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тропа Времени'),
      ),
      body: const Center(
        child: Text('Здесь будет сад'),
      ),
    );
  }
}
