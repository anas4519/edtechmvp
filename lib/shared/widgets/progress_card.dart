import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../core/constants/app_colors.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final int completed;
  final int total;
  final Color accentColor;
  final VoidCallback? onTap;

  const ProgressCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.completed,
    required this.total,
    this.accentColor = AppColors.amber,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border(left: BorderSide(color: accentColor, width: 3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? AppColors.textGray : AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 12),
            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 6,
              percent: progress.clamp(0.0, 1.0),
              backgroundColor: isDark
                  ? AppColors.darkBorder
                  : AppColors.lightBorder,
              progressColor: accentColor,
              barRadius: const Radius.circular(3),
            ),
            const SizedBox(height: 8),
            Text(
              '$completed / $total completed',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? AppColors.textGray : AppColors.textMuted,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
