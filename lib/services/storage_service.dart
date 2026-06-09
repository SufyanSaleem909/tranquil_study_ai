import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mood_entry.dart';
import '../models/task.dart';
import '../core/constants.dart';

class StorageService {
  static SharedPreferences? _prefs;

  // Initialize storage
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ─── MOOD ENTRIES ───────────────────────────────────────

  static Future<void> saveMoodEntry(MoodEntry entry) async {
    final list = getMoodHistory();
    list.add(entry);
    final jsonList = list.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs?.setStringList(AppConstants.moodHistoryKey, jsonList);
  }

  static List<MoodEntry> getMoodHistory() {
    final jsonList = _prefs?.getStringList(AppConstants.moodHistoryKey) ?? [];
    return jsonList.map((e) => MoodEntry.fromJson(jsonDecode(e))).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  static MoodEntry? getLatestMood() {
    final history = getMoodHistory();
    return history.isEmpty ? null : history.first;
  }

  // ─── TASKS ──────────────────────────────────────────────

  static Future<void> saveTask(Task task) async {
    final list = getTasks();
    list.add(task);
    await _saveTasks(list);
  }

  static Future<void> updateTask(Task updatedTask) async {
    final list = getTasks();
    final index = list.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      list[index] = updatedTask;
      await _saveTasks(list);
    }
  }

  static Future<void> deleteTask(String taskId) async {
    final list = getTasks();
    list.removeWhere((t) => t.id == taskId);
    await _saveTasks(list);
  }

  static List<Task> getTasks() {
    final jsonList = _prefs?.getStringList(AppConstants.tasksKey) ?? [];
    return jsonList.map((e) => Task.fromJson(jsonDecode(e))).toList()
      ..sort((a, b) => b.priority.compareTo(a.priority));
  }

  static Future<void> _saveTasks(List<Task> tasks) async {
    final jsonList = tasks.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs?.setStringList(AppConstants.tasksKey, jsonList);
  }

  // ─── CHAT HISTORY ────────────────────────────────────────

  static Future<void> saveChatHistory(
    List<Map<String, String>> messages,
  ) async {
    final jsonList = messages.map((e) => jsonEncode(e)).toList();
    await _prefs?.setStringList(AppConstants.chatHistoryKey, jsonList);
  }

  static List<Map<String, String>> getChatHistory() {
    final jsonList = _prefs?.getStringList(AppConstants.chatHistoryKey) ?? [];
    return jsonList
        .map((e) => Map<String, String>.from(jsonDecode(e)))
        .toList();
  }

  static Future<void> clearChatHistory() async {
    await _prefs?.remove(AppConstants.chatHistoryKey);
  }
}
