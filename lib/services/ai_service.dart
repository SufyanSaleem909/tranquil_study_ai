import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

class AiService {
  // Send message to Groq API
  static Future<String> sendMessage(
    List<Map<String, String>> conversationHistory,
  ) async {
    try {
      // Build messages with system prompt
      final messages = [
        {'role': 'system', 'content': AppConstants.systemPrompt},
        ...conversationHistory,
      ];

      final response = await http.post(
        Uri.parse(AppConstants.apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppConstants.apiKey}',
        },
        body: jsonEncode({
          'model': AppConstants.model,
          'max_tokens': 1024,
          'messages': messages,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'] ??
            'No response received.';
      } else if (response.statusCode == 401) {
        return 'API key is invalid. Please check your configuration.';
      } else if (response.statusCode == 429) {
        return 'Too many requests. Please wait a moment and try again.';
      } else {
        return 'Something went wrong (${response.statusCode}). Please try again.';
      }
    } catch (e) {
      return 'Connection error. Please check your internet and try again.';
    }
  }

  // Generate a quick wellness tip based on mood
  static Future<String> getWellnessTip(int mood, int energy, int stress) async {
    final prompt =
        'My mood is $mood/10, energy is $energy/10, stress is $stress/10. '
        'Give me one short, practical tip for right now. Max 2 sentences.';

    return await sendMessage([
      {'role': 'user', 'content': prompt},
    ]);
  }

  // Generate study plan based on tasks and mood
  static Future<String> generateStudyPlan(
    List<String> tasks,
    int energy,
    int stress,
  ) async {
    final taskList = tasks.join(', ');
    final prompt =
        'I have these tasks: $taskList. '
        'My energy is $energy/10 and stress is $stress/10. '
        'Give me a short, realistic study plan for today with time blocks. '
        'Keep it simple and achievable.';

    return await sendMessage([
      {'role': 'user', 'content': prompt},
    ]);
  }
}
