import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/stats_row.dart';
import 'package:todo_app/widgets/theme_toggle.dart';

/// Header section with gradient background.
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1A1D2E), const Color(0xFF0D0F1A)]
                : [
                    AppColors.primaryGradientStart,
                    AppColors.primaryGradientEnd,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildGreeting(isDark), const ThemeToggle()],
                ),
                const SizedBox(height: 24),
                Consumer<TodoProvider>(
                  builder: (context, provider, _) =>
                      StatsRow(provider: provider, isDark: isDark),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello! 👋',
          style: TextStyle(
            fontSize: 15,
            color: isDark ? Colors.white60 : Colors.white.withAlpha(200),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          StringConstants.myTasks,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : Colors.white,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
