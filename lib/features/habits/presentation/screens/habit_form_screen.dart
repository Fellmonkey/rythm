import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../database/app_database.dart';
import '../../../spheres/di/sphere_providers.dart';
import '../../di/habit_providers.dart';

/// Экран создания / редактирования привычки.
class HabitFormScreen extends ConsumerStatefulWidget {
  const HabitFormScreen({super.key, this.habitId});

  final int? habitId;

  @override
  ConsumerState<HabitFormScreen> createState() => _HabitFormScreenState();
}

class _HabitFormScreenState extends ConsumerState<HabitFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _targetCtrl = TextEditingController(text: '1');
  final _minCtrl = TextEditingController(text: '1');
  final _unitCtrl = TextEditingController();

  String _type = AppConstants.habitTypeBinary;
  int? _sphereId;
  int _priority = AppConstants.priorityLow;
  int _energyRequired = AppConstants.energyMedium;
  int _goalPerWeek = 7;

  bool _isEditing = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (widget.habitId != null) {
      _isEditing = true;
      _loadHabit();
    } else {
      _loading = false;
    }
  }

  Future<void> _loadHabit() async {
    final habit = await ref
        .read(habitRepositoryProvider)
        .getById(widget.habitId!);
    _nameCtrl.text = habit.name;
    _descCtrl.text = habit.description ?? '';
    _targetCtrl.text = habit.targetValue.toString();
    _minCtrl.text = habit.minValue.toString();
    _unitCtrl.text = habit.unit ?? '';
    setState(() {
      _type = habit.type;
      _sphereId = habit.sphereId;
      _priority = habit.priority;
      _energyRequired = habit.energyRequired;
      _goalPerWeek = habit.goalPerWeek;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _targetCtrl.dispose();
    _minCtrl.dispose();
    _unitCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final spheresAsync = ref.watch(spheresProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Редактировать' : 'Новая привычка'),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.warning),
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Название
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(hintText: 'Название привычки'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Введите название' : null,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 12),

            // Описание
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                hintText: 'Описание (опционально)',
              ),
              maxLines: 2,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 20),

            // Тип привычки
            Text('Тип', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: AppConstants.habitTypeBinary,
                  label: Text('Да/Нет'),
                  icon: Icon(Icons.check_circle_outline, size: 18),
                ),
                ButtonSegment(
                  value: AppConstants.habitTypeCounter,
                  label: Text('Счётчик'),
                  icon: Icon(Icons.add_circle_outline, size: 18),
                ),
                ButtonSegment(
                  value: AppConstants.habitTypeDuration,
                  label: Text('Время'),
                  icon: Icon(Icons.timer_outlined, size: 18),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            const SizedBox(height: 20),

            // Цель и минимум (для counter/duration)
            if (_type != AppConstants.habitTypeBinary) ...[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _targetCtrl,
                      decoration: const InputDecoration(hintText: 'Цель'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _minCtrl,
                      decoration: const InputDecoration(hintText: 'Минимум'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _unitCtrl,
                      decoration: InputDecoration(
                        hintText: _type == AppConstants.habitTypeDuration
                            ? 'мин'
                            : 'ед.',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],

            // Сфера
            Text('Сфера жизни', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            spheresAsync.when(
              data: (spheres) => Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Без сферы'),
                    selected: _sphereId == null,
                    onSelected: (_) => setState(() => _sphereId = null),
                  ),
                  ...spheres.map(
                    (s) => ChoiceChip(
                      label: Text(s.name),
                      selected: _sphereId == s.id,
                      onSelected: (_) => setState(() => _sphereId = s.id),
                      avatar: CircleAvatar(
                        backgroundColor: _colorFromHex(s.color),
                        radius: 8,
                      ),
                    ),
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => const Text('Ошибка загрузки сфер'),
            ),
            const SizedBox(height: 20),

            // Энергия
            Text(
              'Требуемая энергия',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 1, label: Text('Низкая')),
                ButtonSegment(value: 2, label: Text('Средняя')),
                ButtonSegment(value: 3, label: Text('Высокая')),
              ],
              selected: {_energyRequired},
              onSelectionChanged: (s) =>
                  setState(() => _energyRequired = s.first),
            ),
            const SizedBox(height: 20),

            // Приоритет
            Text('Приоритет', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Низкий')),
                ButtonSegment(value: 1, label: Text('Средний')),
                ButtonSegment(value: 2, label: Text('Высокий')),
              ],
              selected: {_priority},
              onSelectionChanged: (s) => setState(() => _priority = s.first),
            ),
            const SizedBox(height: 20),

            // Дней в неделю
            Text(
              'Дней в неделю',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Slider(
              value: _goalPerWeek.toDouble(),
              min: 1,
              max: 7,
              divisions: 6,
              label: '$_goalPerWeek',
              onChanged: (v) => setState(() => _goalPerWeek = v.round()),
            ),
            const SizedBox(height: 32),

            // Кнопка сохранения
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                child: Text(_isEditing ? 'Сохранить' : 'Создать'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final companion = HabitsCompanion(
      name: Value(_nameCtrl.text.trim()),
      description: Value(
        _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
      ),
      type: Value(_type),
      sphereId: Value(_sphereId),
      targetValue: Value(int.tryParse(_targetCtrl.text) ?? 1),
      minValue: Value(int.tryParse(_minCtrl.text) ?? 1),
      unit: Value(_unitCtrl.text.trim().isEmpty ? null : _unitCtrl.text.trim()),
      priority: Value(_priority),
      energyRequired: Value(_energyRequired),
      goalPerWeek: Value(_goalPerWeek),
    );

    final repo = ref.read(habitRepositoryProvider);

    if (_isEditing) {
      await repo.update(widget.habitId!, companion);
    } else {
      await repo.create(companion);
    }

    HapticFeedback.lightImpact();
    if (mounted) context.pop();
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить привычку?'),
        content: const Text('Все данные и логи этой привычки будут удалены.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(habitRepositoryProvider).delete(widget.habitId!);
              if (mounted) context.pop();
            },
            child: const Text(
              'Удалить',
              style: TextStyle(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );
  }

  Color _colorFromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.startsWith('#')) hex = hex.substring(1);
    if (hex.length == 6) buffer.write('FF');
    buffer.write(hex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
