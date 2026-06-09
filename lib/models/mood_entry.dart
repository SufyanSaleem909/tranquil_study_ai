class MoodEntry {
  final String id;
  final int mood;
  final int energy;
  final int stress;
  final String? note;
  final DateTime timestamp;

  MoodEntry({
    required this.id,
    required this.mood,
    required this.energy,
    required this.stress,
    this.note,
    required this.timestamp,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() => {
    'id': id,
    'mood': mood,
    'energy': energy,
    'stress': stress,
    'note': note,
    'timestamp': timestamp.toIso8601String(),
  };

  // Create from JSON
  factory MoodEntry.fromJson(Map<String, dynamic> json) => MoodEntry(
    id: json['id'],
    mood: json['mood'],
    energy: json['energy'],
    stress: json['stress'],
    note: json['note'],
    timestamp: DateTime.parse(json['timestamp']),
  );

  // Get mood label
  String get moodLabel {
    if (mood >= 8) return 'Great 😊';
    if (mood >= 6) return 'Good 🙂';
    if (mood >= 4) return 'Okay 😐';
    if (mood >= 2) return 'Low 😔';
    return 'Very Low 😞';
  }

  // Get stress label
  String get stressLabel {
    if (stress >= 8) return 'Very High 🔴';
    if (stress >= 6) return 'High 🟠';
    if (stress >= 4) return 'Moderate 🟡';
    return 'Low 🟢';
  }

  // Get energy label
  String get energyLabel {
    if (energy >= 8) return 'High ⚡';
    if (energy >= 5) return 'Medium 🔋';
    return 'Low 🪫';
  }
}
