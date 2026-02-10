import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/topic.dart';
import '../../data/models/problem.dart';
import 'bloc/dsa_cubit.dart';

class DsaTopicScreen extends StatelessWidget {
  final Topic topic;

  const DsaTopicScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          topic.title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: BlocBuilder<DsaCubit, DsaState>(
        builder: (context, state) {
          final currentTopic = state.steps.firstWhere(
            (t) => t.id == topic.id,
            orElse: () => topic,
          );

          return Column(
            children: [
              // Topic info header
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(
                      label: 'Total',
                      value: '${currentTopic.totalProblems}',
                      color: AppColors.info,
                      isDark: isDark,
                    ),
                    _StatItem(
                      label: 'Solved',
                      value: '${currentTopic.completedProblems}',
                      color: AppColors.success,
                      isDark: isDark,
                    ),
                    _StatItem(
                      label: 'Remaining',
                      value:
                          '${currentTopic.totalProblems - currentTopic.completedProblems}',
                      color: AppColors.warning,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              // Problems list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: currentTopic.problems.length,
                  itemBuilder: (context, index) {
                    final problem = currentTopic.problems[index];
                    return _ProblemTile(
                      problem: problem,
                      index: index,
                      isDark: isDark,
                      onToggle: () {
                        context.read<DsaCubit>().toggleProblem(
                          topic.id,
                          problem.id,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isDark ? AppColors.textGray : AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _ProblemTile extends StatelessWidget {
  final Problem problem;
  final int index;
  final bool isDark;
  final VoidCallback onToggle;

  const _ProblemTile({
    required this.problem,
    required this.index,
    required this.isDark,
    required this.onToggle,
  });

  Color _difficultyColor() {
    switch (problem.difficulty) {
      case Difficulty.easy:
        return AppColors.easy;
      case Difficulty.medium:
        return AppColors.medium;
      case Difficulty.hard:
        return AppColors.hard;
    }
  }

  String _difficultyLabel() {
    switch (problem.difficulty) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: problem.isCompleted
              ? AppColors.amber.withValues(alpha: 0.3)
              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          width: 0.5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        leading: GestureDetector(
          onTap: onToggle,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: problem.isCompleted ? AppColors.amber : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: problem.isCompleted
                    ? AppColors.amber
                    : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                width: 2,
              ),
            ),
            child: problem.isCompleted
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                : null,
          ),
        ),
        title: Text(
          problem.title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface,
            decoration: problem.isCompleted ? TextDecoration.lineThrough : null,
            decorationColor: AppColors.textGray,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _difficultyColor().withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _difficultyLabel(),
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _difficultyColor(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.article_outlined,
              size: 18,
              color: isDark ? AppColors.textGray : AppColors.textMuted,
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.play_circle_outline_rounded,
              size: 18,
              color: isDark ? AppColors.textGray : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
