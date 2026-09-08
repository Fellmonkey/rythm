import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hintful/hintful.dart';

import 'app_tours.dart';
import 'onboarding_flags.dart';

/// One-time onboarding tour for a screen: `with OnboardingTourMixin`,
/// `tourScope` + `hintTarget(AppHintIds.xxx, child)`.
mixin OnboardingTourMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  /// Tour id from [OnboardingTours].
  String get tourScope;

  HintTour get hintTour {
    final t = AppTours.byId(tourScope);
    if (t != null) return t;
    throw StateError('No tour for scope "$tourScope" — add it to AppTours');
  }

  /// One-step mini-tour for the first habit card (greenhouse only).
  HintStep? get pendingHintStep => tourScope == AppTourIds.greenhouse
      ? AppTours.greenhouseHabitPendingStep
      : null;

  HintController? _hintController;
  bool _starting = false;

  /// Captured in [initState] — no `ref` reads after an `await`.
  OnboardingFlags? _flags;

  Widget hintTarget(String id, Widget child) =>
      HintTarget(id: id, child: child);

  @override
  void initState() {
    super.initState();
    _hintController = HintController(overlayHostBuilder: defaultOverlayHost());
    _flags = ref.read(onboardingFlagsProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) => _startWhenReady());
  }

  Future<void> _startWhenReady() async {
    final controller = _hintController;
    final flags = _flags;
    if (controller == null || flags == null || _starting) return;
    _starting = true;
    await ref.read(onboardingFlagsProvider.future);
    if (!mounted || _hintController == null) return;
    if (flags.isSeen(tourScope)) {
      // The card step was skipped when the tour ran (no habits yet) —
      // teach the gestures via the mini-tour.
      if (flags.habitTutorialPending && pendingHintStep != null) {
        startPendingTour();
      }
      return;
    }
    // Seen on start — a dismissed tour never nags again.
    await flags.markSeen(tourScope);
    if (!mounted || _hintController == null) return;
    // hintful skips missing steps per tour policy; no polling needed.
    await _hintController!.start(hintTour);
  }

  /// Shows the mini-tour via tryShowHint and consumes the flag only when
  /// it actually started — a busy tour will be retried on the next trigger.
  Future<void> startPendingTour() async {
    final controller = _hintController;
    final flags = _flags;
    final step = pendingHintStep;
    if (controller == null || flags == null || step == null) return;
    final started = await controller.tryShowHint(step);
    if (started) await flags.clearHabitTutorialPending();
  }

  @override
  void dispose() {
    _hintController?.dispose();
    _hintController = null;
    super.dispose();
  }
}
