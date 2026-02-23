import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors – vibrant violet/indigo
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF9D97FF);
  static const Color primaryGradientStart = Color(0xFF6C63FF);
  static const Color primaryGradientEnd = Color(0xFF48CAE4);

  // Background
  static const Color backgroundLight = Color(0xFFF4F6FB);
  static const Color backgroundDark = Color(0xFF0D0F1A);

  // Surface
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A1D2E);

  // Card
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF222537);

  // Priority
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

  static IconData getPriorityIcon(int priority) {
    switch (priority) {
      case 3:
        return Icons.keyboard_double_arrow_up_rounded;
      case 2:
        return Icons.keyboard_arrow_up_rounded;
      case 1:
      default:
        return Icons.keyboard_arrow_down_rounded;
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
