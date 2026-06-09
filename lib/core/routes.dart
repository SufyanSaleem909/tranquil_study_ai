import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/checkin_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/planner_screen.dart';
import '../screens/calm_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String checkIn = '/checkin';
  static const String chat = '/chat';
  static const String planner = '/planner';
  static const String calm = '/calm';

  static Map<String, WidgetBuilder> get routes => {
    home: (_) => const HomeScreen(),
    checkIn: (_) => const CheckInScreen(),
    chat: (_) => const ChatScreen(),
    planner: (_) => const PlannerScreen(),
    calm: (_) => const CalmScreen(),
  };
}
