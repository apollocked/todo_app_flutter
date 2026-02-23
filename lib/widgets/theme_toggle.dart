import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/theme_provider.dart';

/// Theme toggle button.
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () => themeProvider.toggleTheme(!themeProvider.isDarkMode),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(isDark ? 18 : 40),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withAlpha(50)),
        ),
        child: Icon(
          themeProvider.isDarkMode
              ? Icons.light_mode_rounded
              : Icons.dark_mode_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
