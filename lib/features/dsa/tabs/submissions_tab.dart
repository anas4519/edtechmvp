import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class SubmissionsTab extends StatelessWidget {
  const SubmissionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.lightCard,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                _HeaderCell('No.', flex: 1),
                _HeaderCell('Status', flex: 2),
                _HeaderCell('Language', flex: 2),
                _HeaderCell('Code', flex: 1),
                _HeaderCell('Analysis', flex: 2),
                _HeaderCell('Action', flex: 1),
              ],
            ),
          ),
          // Empty body
          Container(
            padding: const EdgeInsets.symmetric(vertical: 28),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
              border: Border(
                left: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 0.5,
                ),
                right: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 0.5,
                ),
                bottom: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 0.5,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'No submissions yet.',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing 0 out of 0 submissions',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                ),
              ),
              Text(
                'Page 1',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final int flex;

  const _HeaderCell(this.label, {this.flex = 1});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.textGray : AppColors.textMuted,
        ),
      ),
    );
  }
}
