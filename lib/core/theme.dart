import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ════════════════════════════════════════════════
  // 🌐 GLOBAL
  // ════════════════════════════════════════════════
  static const Color card = Color(0xFFDBEAF2);
  static const Color background = Color(0xFFF5F0E8);
  static const Color surface = Color(0xFFDBEAF2);
  static const Color primary = Color(0xFF142F43);
  static const Color secondary = Color(0xFF85B8D4);
  static const Color accent = Color(0xFFE8715A);
  static const Color warning = Color(0xFFE9A878);
  static const Color success = Color(0xFF4CAF50);
  static const Color textPrimary = Color(0xFF142F43);
  static const Color textSecondary = Color(0xFF4A6880);

  // ════════════════════════════════════════════════
  // 🏠 HOME SCREEN
  // ════════════════════════════════════════════════
  static const Color homeBackground = Color(0xFFF5F0E8);
  static const Color homeAppBar = Color(0xFFF5F0E8);
  static const Color homeGreetingText = Color(0xFF142F43);
  static const Color homeSubtitleText = Color(0xFF4A6880);
  static const Color homeHistoryIcon = Color(0xFFFFFFFF);
  static const Color homeHistoryIconBg = Color(0xFF142F43);
  static const Color homeSettingsIcon = Color(0xFF142F43);
  static const Color homeSettingsIconBg = Color(0xFFF5F0E8);
  static const Color homeMoodCard = Color(0xFFFFFFFF);
  static const Color homeMoodCardBorder = Color(0xFF85B8D4);
  static const Color homeStatCard = Color(0xFFFFFFFF);
  static const Color homeStatIcon1 = Color(0xFF85B8D4);
  static const Color homeStatIcon2 = Color(0xFFE8715A);
  static const Color homeFeatureCard1 = Color(0xFFE8715A); // Mind Check-In
  static const Color homeFeatureCard2 = Color(0xFF142F43); // AI Companion
  static const Color homeFeatureCard3 = Color(0xFF85B8D4); // Smart Planner
  static const Color homeFeatureCard4 = Color(0xFF112E39); // Calm Toolkit
  static const Color homeFeatureIcon = Color(0xFFFFFFFF);
  static const Color homeFeatureTitle = Color(0xFFFFFFFF);
  static const Color homeFeatureSubtitle = Color(0xFFFFFFFF);

  // ════════════════════════════════════════════════
  // 🧠 MIND CHECK-IN SCREEN
  // ════════════════════════════════════════════════
  static const Color checkinBackground = Color(0xFFF5F0E8);
  static const Color checkinInfoCard = Color(0xFFDBEAF2);
  static const Color checkinInfoIcon = Color(0xFF142F43);
  static const Color checkinSliderMoodLow = Color(0xFFE8715A);
  static const Color checkinSliderMoodMid = Color(0xFFE9A878);
  static const Color checkinSliderMoodHigh = Color(0xFF4CAF50);
  static const Color checkinSliderStressLow = Color(0xFF4CAF50);
  static const Color checkinSliderStressHigh = Color(0xFFE8715A);
  static const Color checkinNoteField = Color(0xFFDBEAF2);
  static const Color checkinTipCard = Color(0xFF85B8D4);
  static const Color checkinTipIcon = Color(0xFF142F43);
  static const Color checkinTipText = Color(0xFF142F43);

  // ════════════════════════════════════════════════
  // 💬 CHAT SCREEN
  // ════════════════════════════════════════════════
  static const Color chatBackground = Color(0xFFF5F0E8);
  static const Color chatAppBarIcon = Color(0xFF142F43);
  static const Color chatAppBarIconBg = Color(0xFFDBEAF2);
  static const Color chatBubbleUser = Color(0xFF142F43);
  static const Color chatBubbleAI = Color(0xFFDBEAF2);
  static const Color chatTextUser = Color(0xFFFFFFFF);
  static const Color chatTextAI = Color(0xFF142F43);
  static const Color chatInputBar = Color(0xFFDBEAF2);
  static const Color chatSendButton = Color(0xFF142F43);
  static const Color chatSendIcon = Color(0xFFFFFFFF);
  static const Color chatQuickPromptBg = Color(0xFFDBEAF2);
  static const Color chatQuickPromptBorder = Color(0xFF85B8D4);
  static const Color chatQuickPromptText = Color(0xFF142F43);

  // ════════════════════════════════════════════════
  // 📅 PLANNER SCREEN
  // ════════════════════════════════════════════════
  static const Color plannerBackground = Color(0xFFF5F0E8);
  static const Color plannerAiCard = Color(0xFF85B8D4);
  static const Color plannerAiText = Color(0xFF142F43);
  static const Color plannerTaskCard = Color(0xFFDBEAF2);
  static const Color plannerHighPriority = Color(0xFFE8715A);
  static const Color plannerMidPriority = Color(0xFFE9A878);
  static const Color plannerLowPriority = Color(0xFF4CAF50);
  static const Color plannerOverdue = Color(0xFFE8715A);
  static const Color plannerDeadlineNear = Color(0xFFE9A878);
  static const Color plannerComplete = Color(0xFF4CAF50);
  static const Color plannerFab = Color(0xFF142F43);
  static const Color plannerFabIcon = Color(0xFFFFFFFF);

  // ════════════════════════════════════════════════
  // 🌿 CALM TOOLKIT SCREEN
  // ════════════════════════════════════════════════
  static const Color calmBackground = Color(0xFFF5F0E8);
  static const Color calmInfoCard = Color(0xFFDBEAF2);
  static const Color calmTabActive = Color(0xFF142F43);
  static const Color calmTabInactive = Color(0xFFFFFFFF);
  static const Color calmBreathingCard = Color(0xFFDBEAF2);
  static const Color calmBreathingCircle = Color(0xFF85B8D4);
  static const Color calmBreathingText = Color(0xFF142F43);
  static const Color calmGroundingCard = Color(0xFFDBEAF2);
  static const Color calmGroundingItem = Color(0xFF85B8D4);
  static const Color calmGroundingText = Color(0xFF142F43);
  static const Color calmReframeCard = Color(0xFFDBEAF2);
  static const Color calmReframeItem = Color(0xFFE9A878);
  static const Color calmMicroBreakCard = Color(0xFFDBEAF2);
  static const Color calmMicroBreakItem = Color(0xFF4CAF50);

  // ════════════════════════════════════════════════
  // 📊 HISTORY SCREEN
  // ════════════════════════════════════════════════
  static const Color historyBackground = Color(0xFFF5F0E8);
  static const Color historyAvgCard = Color(0xFFDBEAF2);
  static const Color historyAvgMood = Color(0xFFE8715A);
  static const Color historyAvgEnergy = Color(0xFF85B8D4);
  static const Color historyAvgStress = Color(0xFF142F43);
  static const Color historyTrendCard = Color(0xFFDBEAF2);
  static const Color historyBarHigh = Color(0xFF4CAF50);
  static const Color historyBarMid = Color(0xFFE9A878);
  static const Color historyBarLow = Color(0xFFE8715A);
  static const Color historyEntryCard = Color(0xFFDBEAF2);
  static const Color historyMoodChip = Color(0xFFE8715A);
  static const Color historyEnergyChip = Color(0xFF85B8D4);
  static const Color historyStressChip = Color(0xFF142F43);

  // ════════════════════════════════════════════════
  // ⚙️ SETTINGS SCREEN
  // ════════════════════════════════════════════════
  static const Color settingsBackground = Color(0xFFF5F0E8);
  static const Color settingsInfoCard = Color(0xFF85B8D4);
  static const Color settingsInfoText = Color(0xFF142F43);
  static const Color settingsDataCard = Color(0xFFDBEAF2);
  static const Color settingsTile = Color(0xFFDBEAF2);
  static const Color settingsTileIcon1 = Color(0xFF85B8D4);
  static const Color settingsTileIcon2 = Color(0xFF142F43);
  static const Color settingsTileDestructive = Color(0xFFE8715A);
  static const Color settingsAboutCard = Color(0xFFDBEAF2);

  // ════════════════════════════════════════════════
  // 🚀 ONBOARDING SCREEN
  // ════════════════════════════════════════════════
  static const Color onboardingBackground = Color(0xFFF5F0E8);
  static const Color onboardingPage1Icon = Color(0xFF142F43);
  static const Color onboardingPage2Icon = Color(0xFFE8715A);
  static const Color onboardingPage3Icon = Color(0xFF85B8D4);
  static const Color onboardingPage4Icon = Color(0xFF4CAF50);
  static const Color onboardingTitle = Color(0xFF142F43);
  static const Color onboardingSubtitle = Color(0xFF4A6880);
  static const Color onboardingDotActive = Color(0xFF142F43);
  static const Color onboardingDotInactive = Color(0xFF85B8D4);
  static const Color onboardingSkipText = Color(0xFF4A6880);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        error: accent,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(color: textPrimary),
          bodyLarge: TextStyle(color: textPrimary),
          bodyMedium: TextStyle(color: textSecondary),
          labelLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: homeAppBar,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        hintStyle: const TextStyle(color: textSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
