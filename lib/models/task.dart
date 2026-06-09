class Task {
  final String id;
  String title;
  String? description;
  DateTime? deadline;
  int priority; // 1=low, 2=medium, 3=high
  bool isCompleted;
  int estimatedMinutes;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.deadline,
    this.priority = 2,
    this.isCompleted = false,
    this.estimatedMinutes = 30,
    required this.createdAt,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'deadline': deadline?.toIso8601String(),
    'priority': priority,
    'isCompleted': isCompleted,
    'estimatedMinutes': estimatedMinutes,
    'createdAt': createdAt.toIso8601String(),
  };

  // Create from JSON
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    deadline: json['deadline'] != null
        ? DateTime.parse(json['deadline'])
        : null,
    priority: json['priority'] ?? 2,
    isCompleted: json['isCompleted'] ?? false,
    estimatedMinutes: json['estimatedMinutes'] ?? 30,
    createdAt: DateTime.parse(json['createdAt']),
  );

  // Get priority label
  String get priorityLabel {
    if (priority == 3) return 'High 🔴';
    if (priority == 2) return 'Medium 🟡';
    return 'Low 🟢';
  }

  // Check if deadline is near (within 24 hours)
  bool get isDeadlineNear {
    if (deadline == null) return false;
    final difference = deadline!.difference(DateTime.now());
    return difference.inHours <= 24 && difference.inHours >= 0;
  }

  // Check if deadline is overdue
  bool get isOverdue {
    if (deadline == null) return false;
    return deadline!.isBefore(DateTime.now()) && !isCompleted;
  }
}
