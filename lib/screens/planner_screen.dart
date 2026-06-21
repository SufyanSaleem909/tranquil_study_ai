import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/task.dart';
import '../services/storage_service.dart';
import '../services/ai_service.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  List<Task> _tasks = [];
  bool _isGeneratingPlan = false;
  String? _aiPlan;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    setState(() {
      _tasks = StorageService.getTasks();
    });
  }

  Future<void> _generateAiPlan() async {
    if (_tasks.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Add some tasks first!')));
      return;
    }

    setState(() => _isGeneratingPlan = true);

    final latestMood = StorageService.getLatestMood();
    final energy = latestMood?.energy ?? 5;
    final stress = latestMood?.stress ?? 5;
    final taskTitles = _tasks
        .where((t) => !t.isCompleted)
        .map((t) => t.title)
        .toList();

    final plan = await AiService.generateStudyPlan(taskTitles, energy, stress);

    setState(() {
      _isGeneratingPlan = false;
      _aiPlan = plan;
    });
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    int priority = 2;
    int estimatedMinutes = 30;
    DateTime? deadline;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.textSecondary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Task title *',
                    prefixIcon: Icon(Icons.task_alt, color: AppTheme.primary),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: descController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Description (optional)',
                    prefixIcon: Icon(
                      Icons.notes,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  'Priority',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildPriorityChip(
                      ctx,
                      setModalState,
                      1,
                      'Low 🟢',
                      priority,
                      (v) => priority = v,
                    ),
                    const SizedBox(width: 8),
                    _buildPriorityChip(
                      ctx,
                      setModalState,
                      2,
                      'Medium 🟡',
                      priority,
                      (v) => priority = v,
                    ),
                    const SizedBox(width: 8),
                    _buildPriorityChip(
                      ctx,
                      setModalState,
                      3,
                      'High 🔴',
                      priority,
                      (v) => priority = v,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  'Estimated Time: $estimatedMinutes min',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: estimatedMinutes.toDouble(),
                  min: 15,
                  max: 180,
                  divisions: 11,
                  activeColor: AppTheme.primary,
                  onChanged: (v) =>
                      setModalState(() => estimatedMinutes = v.round()),
                ),
                const SizedBox(height: 8),

                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppTheme.primary,
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: AppTheme.textPrimary,
                          ),
                        ),
                        child: child!,
                      ),
                    );
                    if (picked != null) setModalState(() => deadline = picked);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: AppTheme.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          deadline == null
                              ? 'Set Deadline (optional)'
                              : '${deadline!.day}/${deadline!.month}/${deadline!.year}',
                          style: TextStyle(
                            color: deadline == null
                                ? AppTheme.textSecondary
                                : AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (titleController.text.trim().isEmpty) {
                        showDialog(
                          context: ctx,
                          builder: (c) => AlertDialog(
                            backgroundColor: AppTheme.card,
                            title: const Text('Missing Title'),
                            content: const Text(
                              'Please enter a task title to continue.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(c),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        return;
                      }
                      final task = Task(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleController.text.trim(),
                        description: descController.text.isEmpty
                            ? null
                            : descController.text,
                        deadline: deadline,
                        priority: priority,
                        estimatedMinutes: estimatedMinutes,
                        createdAt: DateTime.now(),
                      );
                      StorageService.saveTask(task);
                      Navigator.pop(ctx);
                      _loadTasks();
                    },
                    child: const Text('Save Task'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditTaskDialog(Task task) {
    final titleController = TextEditingController(text: task.title);
    final descController = TextEditingController(text: task.description ?? '');
    int priority = task.priority;
    int estimatedMinutes = task.estimatedMinutes;
    DateTime? deadline = task.deadline;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.plannerTaskCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.textSecondary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Edit Task',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Task title *',
                    prefixIcon: Icon(Icons.task_alt, color: AppTheme.primary),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: descController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Description (optional)',
                    prefixIcon: Icon(
                      Icons.notes,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  'Priority',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildPriorityChip(
                      ctx,
                      setModalState,
                      1,
                      'Low 🟢',
                      priority,
                      (v) => priority = v,
                    ),
                    const SizedBox(width: 8),
                    _buildPriorityChip(
                      ctx,
                      setModalState,
                      2,
                      'Medium 🟡',
                      priority,
                      (v) => priority = v,
                    ),
                    const SizedBox(width: 8),
                    _buildPriorityChip(
                      ctx,
                      setModalState,
                      3,
                      'High 🔴',
                      priority,
                      (v) => priority = v,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  'Estimated Time: $estimatedMinutes min',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: estimatedMinutes.toDouble(),
                  min: 15,
                  max: 180,
                  divisions: 11,
                  activeColor: AppTheme.primary,
                  onChanged: (v) =>
                      setModalState(() => estimatedMinutes = v.round()),
                ),
                const SizedBox(height: 8),

                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: deadline ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppTheme.primary,
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: AppTheme.textPrimary,
                          ),
                        ),
                        child: child!,
                      ),
                    );
                    if (picked != null) setModalState(() => deadline = picked);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: AppTheme.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          deadline == null
                              ? 'Set Deadline (optional)'
                              : '${deadline!.day}/${deadline!.month}/${deadline!.year}',
                          style: TextStyle(
                            color: deadline == null
                                ? AppTheme.textSecondary
                                : AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (titleController.text.trim().isEmpty) {
                        showDialog(
                          context: ctx,
                          builder: (c) => AlertDialog(
                            backgroundColor: AppTheme.card,
                            title: const Text('Missing Title'),
                            content: const Text(
                              'Please enter a task title to continue.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(c),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        return;
                      }
                      task.title = titleController.text.trim();
                      task.description = descController.text.isEmpty
                          ? null
                          : descController.text;
                      task.deadline = deadline;
                      task.priority = priority;
                      task.estimatedMinutes = estimatedMinutes;
                      StorageService.updateTask(task);
                      Navigator.pop(ctx);
                      _loadTasks();
                    },
                    child: const Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityChip(
    BuildContext ctx,
    StateSetter setModalState,
    int value,
    String label,
    int current,
    Function(int) onSelect,
  ) {
    final isSelected = current == value;
    return GestureDetector(
      onTap: () => setModalState(() => onSelect(value)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary.withValues(alpha: 0.2)
              : AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primary : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingTasks = _tasks.where((t) => !t.isCompleted).toList();
    final completedTasks = _tasks.where((t) => t.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Planner'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome, color: AppTheme.primary),
            onPressed: _generateAiPlan,
            tooltip: 'Generate AI Plan',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: AppTheme.plannerFab,
        child: Icon(Icons.add, color: AppTheme.plannerFabIcon),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isGeneratingPlan)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.card,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppTheme.primary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Generating your study plan...',
                        style: TextStyle(color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ),

              if (_aiPlan != null && !_isGeneratingPlan) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.plannerAiCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                color: AppTheme.primary,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'AI Study Plan',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: AppTheme.primary),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: AppTheme.textSecondary,
                              size: 18,
                            ),
                            onPressed: () => setState(() => _aiPlan = null),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _aiPlan!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.plannerAiText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              Text(
                'Pending (${pendingTasks.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              if (pendingTasks.isEmpty)
                _buildEmptyState(
                  'No pending tasks 🎉',
                  'Tap + to add a new task',
                )
              else
                ...pendingTasks.map((task) => _buildTaskCard(task, false)),

              if (completedTasks.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  'Completed (${completedTasks.length})',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                ...completedTasks.map((task) => _buildTaskCard(task, true)),
              ],

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(Task task, bool isCompleted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.plannerTaskCard,
        borderRadius: BorderRadius.circular(16),
        border: task.isOverdue
            ? Border.all(color: AppTheme.plannerOverdue.withValues(alpha: 0.5))
            : task.isDeadlineNear
            ? Border.all(
                color: AppTheme.plannerDeadlineNear.withValues(alpha: 0.5),
              )
            : null,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              task.isCompleted = !task.isCompleted;
              await StorageService.updateTask(task);
              _loadTasks();
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppTheme.plannerComplete.withValues(alpha: 0.2)
                    : Colors.transparent,
                border: Border.all(
                  color: isCompleted
                      ? AppTheme.plannerComplete
                      : AppTheme.textSecondary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: isCompleted
                  ? Icon(Icons.check, color: AppTheme.plannerComplete, size: 16)
                  : null,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    color: isCompleted
                        ? AppTheme.textSecondary
                        : AppTheme.textPrimary,
                    fontWeight: FontWeight.w500,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (task.deadline != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 12,
                        color: task.isOverdue
                            ? AppTheme.plannerOverdue
                            : task.isDeadlineNear
                            ? AppTheme.plannerDeadlineNear
                            : AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        task.isOverdue
                            ? 'Overdue!'
                            : task.isDeadlineNear
                            ? 'Due soon!'
                            : '${task.deadline!.day}/${task.deadline!.month}/${task.deadline!.year}',
                        style: TextStyle(
                          fontSize: 11,
                          color: task.isOverdue
                              ? AppTheme.plannerOverdue
                              : task.isDeadlineNear
                              ? AppTheme.plannerDeadlineNear
                              : AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(task.priorityLabel, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              Text(
                '${task.estimatedMinutes}m',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),

          const SizedBox(width: 8),

          Column(
            children: [
              GestureDetector(
                onTap: () => _showEditTaskDialog(task),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: AppTheme.primary,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () async {
                  await StorageService.deleteTask(task.id);
                  _loadTasks();
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: AppTheme.accent,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.task_alt, color: AppTheme.textSecondary, size: 40),
            const SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
