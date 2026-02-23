import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFF6366F1); // Modern Indigo
  static const Color primaryDark = Color(0xFF818CF8);

  // Neutral Colors
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);

  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E293B);

  // Functional Colors
  static const Color lowPriority = Color(0xFF10B981); // Emerald
  static const Color mediumPriority = Color(0xFFF59E0B); // Amber
  static const Color highPriority = Color(0xFFEF4444); // Rose

  static Color getPriorityColor(int priority) {
    switch (priority) {
      case 2:
        return mediumPriority;
      case 3:
        return highPriority;
      case 1:
      default:
        return lowPriority;
    }
  }

  static String getPriorityName(int priority) {
    switch (priority) {
      case 2:
        return 'Medium';
      case 3:
        return 'High';
      case 1:
      default:
        return 'Low';
    }
  }
}
