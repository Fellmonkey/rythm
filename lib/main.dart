import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: RythmApp()));
}

class RythmApp extends ConsumerWidget {
  const RythmApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Ритм',
      debugShowCheckedModeBanner: false,
    );
  } 
}
