import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/settings/shared_prefs.dart';

/// Names of the one-time onboarding tours.
abstract final class OnboardingTours {
  static const greenhouse = 'greenhouse';
  static const spread = 'spread';
  static const settings = 'settings';
}

/// Tours already shown, persisted in SharedPreferences under `onboarding_seen`.
final onboardingFlagsProvider =
    AsyncNotifierProvider<OnboardingFlags, Set<String>>(OnboardingFlags.new);

class OnboardingFlags extends AsyncNotifier<Set<String>> {
  static const _key = 'onboarding_seen';
  static const _habitPendingKey = 'greenhouse_habit_pending';

  /// True when a first habit was created after the main tour already ran
  /// (its habit-card step was skipped — there was no card yet).
  bool _habitTutorialPending = false;
  bool get habitTutorialPending => _habitTutorialPending;

  @override
  Future<Set<String>> build() async {
    final prefs = await ref.watch(sharedPrefsProvider.future);
    _habitTutorialPending = prefs.getBool(_habitPendingKey) ?? false;
    return prefs.getStringList(_key)?.toSet() ?? <String>{};
  }

  bool isSeen(String tour) => state.value?.contains(tour) ?? false;

  /// Marks [tour] as seen and persists the flag.
  Future<void> markSeen(String tour) async {
    if (isSeen(tour)) return;
    state = AsyncData({...?state.value, tour});
    final prefs = await ref.read(sharedPrefsProvider.future);
    await prefs.setStringList(_key, state.value?.toList() ?? const []);
  }

  /// Arms the first-habit mini-tour (greenhouse shows it on the next card).
  Future<void> setHabitTutorialPending() async {
    _habitTutorialPending = true;
    final prefs = await ref.read(sharedPrefsProvider.future);
    await prefs.setBool(_habitPendingKey, true);
  }

  /// Consumes the pending first-habit tutorial.
  Future<void> clearHabitTutorialPending() async {
    _habitTutorialPending = false;
    final prefs = await ref.read(sharedPrefsProvider.future);
    await prefs.remove(_habitPendingKey);
  }

  /// Clears all tour flags — debug menu and Settings.
  Future<void> resetAll() async {
    state = const AsyncData(<String>{});
    _habitTutorialPending = false;
    final prefs = await ref.read(sharedPrefsProvider.future);
    await prefs.remove(_key);
    await prefs.remove(_habitPendingKey);
  }
}
