import 'package:flutter/foundation.dart';

/// Semantic keys shared between production code and integration tests.
///
/// Using a single source of truth prevents typo-induced flaky tests.
abstract final class K {
  // ── Bottom navigation ──────────────────────────────────────
  static const navGreenhouse = Key('nav_greenhouse');
  static const navGarden = Key('nav_garden');
  static const navSettings = Key('nav_settings');

  // ── Greenhouse screen ──────────────────────────────────────
  static const greenhouseTitle = Key('greenhouse_title');
  static const fabCreateHabit = Key('fab_create_habit');
  static const progressRing = Key('progress_ring');
  static const hideCompletedToggle = Key('hide_completed_toggle');
  static const emptyHabitsMessage = Key('empty_habits_message');

  // ── Create-habit bottom sheet ──────────────────────────────
  static const createHabitSheet = Key('create_habit_sheet');
  static const habitNameField = Key('habit_name_field');
  static const habitCreateButton = Key('habit_create_button');

  // ── Habit card ─────────────────────────────────────────────
  /// Per-habit card: `habit_card_$id`
  static Key habitCard(int id) => Key('habit_card_$id');

  /// Per-habit check circle: `habit_check_$id`
  static Key habitCheck(int id) => Key('habit_check_$id');

  // ── Swipe menu items ───────────────────────────────────────
  static const swipeSkip = Key('swipe_skip');
  static const swipeFail = Key('swipe_fail');
  static const swipeDelete = Key('swipe_delete');

  // ── Mark-all buttons per group ─────────────────────────────
  static Key markAllGroup(String timeOfDay) => Key('mark_all_$timeOfDay');

  // ── Time Path (Garden) screen ──────────────────────────────
  static const timePathTitle = Key('time_path_title');
  static const timePathEmpty = Key('time_path_empty');

  // ── Settings screen ────────────────────────────────────────
  static const settingsExport = Key('settings_export');
  static const settingsImport = Key('settings_import');
  static const settingsFriendShare = Key('settings_friend_share');
  static const settingsFriendImport = Key('settings_friend_import');
  static const settingsCard = Key('settings_card');
}
