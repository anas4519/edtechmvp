import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/problem.dart';

class ProblemTab extends StatefulWidget {
  final Problem problem;

  const ProblemTab({super.key, required this.problem});

  @override
  State<ProblemTab> createState() => _ProblemTabState();
}

class _ProblemTabState extends State<ProblemTab> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final problem = widget.problem;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            problem.title,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),

          // Difficulty & tags row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _PillBadge(
                label: _difficultyLabel(problem.difficulty),
                color: _difficultyColor(problem.difficulty),
                isDark: isDark,
              ),
              if (problem.hints.isNotEmpty)
                _PillBadge(
                  label: 'Hints',
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                  isDark: isDark,
                  isOutlined: true,
                ),
              if (problem.companyTags.isNotEmpty)
                _PillBadge(
                  label: 'Company',
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                  isDark: isDark,
                  isOutlined: true,
                ),
            ],
          ),
          const SizedBox(height: 20),

          // Description
          if (problem.description != null)
            Text(
              problem.description!,
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.6,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
              ),
            ),
          const SizedBox(height: 24),

          // Examples
          ...problem.examples.asMap().entries.map((entry) {
            final i = entry.key;
            final ex = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Example ${i + 1}',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkCardAlt
                          : AppColors.lightCardAlt,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        left: BorderSide(
                          color: AppColors.textGray.withValues(alpha: 0.4),
                          width: 3,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ex.input,
                          style: GoogleFonts.robotoMono(
                            fontSize: 13,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ex.output,
                          style: GoogleFonts.robotoMono(
                            fontSize: 13,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ),
                        if (ex.explanation != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            ex.explanation!,
                            style: GoogleFonts.robotoMono(
                              fontSize: 13,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          // Practice section
          if (problem.practiceOptions.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Now your turn!',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  left: BorderSide(
                    color: AppColors.textGray.withValues(alpha: 0.4),
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Input: nums = [2, 4, 6, 8, 10, 12, 14], x= 1',
                    style: GoogleFonts.robotoMono(
                      fontSize: 13,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Output:  ',
                        style: GoogleFonts.robotoMono(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.8,
                          ),
                        ),
                      ),
                      Text(
                        'Pick your answer',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.amber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ...problem.practiceOptions.asMap().entries.map((entry) {
              final idx = entry.key;
              final opt = entry.value;
              final isSelected = _selectedOption == idx;
              return GestureDetector(
                onTap: () => setState(() => _selectedOption = idx),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkCardAlt
                        : AppColors.lightCardAlt,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.amber.withValues(alpha: 0.5)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColors.amber
                              : (isDark
                                    ? AppColors.darkCardAlt
                                    : AppColors.lightCardAlt),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.amber
                                : (isDark
                                      ? AppColors.textGray
                                      : AppColors.textMuted),
                            width: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        opt.label,
                        style: GoogleFonts.robotoMono(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Color _difficultyColor(Difficulty d) {
    switch (d) {
      case Difficulty.easy:
        return AppColors.easy;
      case Difficulty.medium:
        return AppColors.medium;
      case Difficulty.hard:
        return AppColors.hard;
    }
  }

  String _difficultyLabel(Difficulty d) {
    switch (d) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
    }
  }
}

class _PillBadge extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;
  final bool isOutlined;

  const _PillBadge({
    required this.label,
    required this.color,
    required this.isDark,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isOutlined ? Colors.transparent : color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: isOutlined
            ? Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              )
            : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isOutlined
              ? (isDark ? AppColors.textGray : AppColors.textMuted)
              : color,
        ),
      ),
    );
  }
}
