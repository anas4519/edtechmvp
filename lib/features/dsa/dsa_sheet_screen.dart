import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../core/constants/app_colors.dart';
import 'bloc/dsa_cubit.dart';
import 'dsa_topic_screen.dart';

class DsaSheetScreen extends StatelessWidget {
  const DsaSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DsaCubit()..loadSheetSteps(),
      child: const _DsaSheetView(),
    );
  }
}

class _DsaSheetView extends StatelessWidget {
  const _DsaSheetView();

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
          'Striver\'s A2Z DSA Sheet',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {}),
        ],
      ),
      body: BlocBuilder<DsaCubit, DsaState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Summary header
          final totalProblems = state.steps.fold<int>(
            0,
            (sum, s) => sum + s.totalProblems,
          );
          final totalCompleted = state.steps.fold<int>(
            0,
            (sum, s) => sum + s.completedProblems,
          );
          final overallProgress = totalProblems > 0
              ? totalCompleted / totalProblems
              : 0.0;

          return Column(
            children: [
              // Progress Summary
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [AppColors.darkCard, AppColors.darkSurface]
                        : [AppColors.lightCard, AppColors.lightSurface],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 36,
                      lineWidth: 6,
                      percent: overallProgress.clamp(0.0, 1.0),
                      center: Text(
                        '${(overallProgress * 100).toInt()}%',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      progressColor: AppColors.amber,
                      backgroundColor: isDark
                          ? AppColors.darkBorder
                          : AppColors.lightBorder,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Overall Progress',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$totalCompleted / $totalProblems problems solved',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: isDark
                                  ? AppColors.textGray
                                  : AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Steps List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.steps.length,
                  itemBuilder: (context, index) {
                    final step = state.steps[index];
                    return _StepCard(
                      step: step,
                      index: index,
                      isDark: isDark,
                      onTap: () {
                        if (step.problems.isNotEmpty) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<DsaCubit>(),
                                child: DsaTopicScreen(topic: step),
                              ),
                            ),
                          );
                        }
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

class _StepCard extends StatelessWidget {
  final dynamic step;
  final int index;
  final bool isDark;
  final VoidCallback onTap;

  const _StepCard({
    required this.step,
    required this.index,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = step.totalProblems > 0
        ? step.completedProblems / step.totalProblems
        : 0.0;
    final isComplete =
        step.completedProblems == step.totalProblems && step.totalProblems > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            // Step number indicator
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isComplete
                    ? AppColors.amber.withValues(alpha: 0.2)
                    : (isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: isComplete
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.amber,
                        size: 20,
                      )
                    : Text(
                        '${index + 1}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.amber,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 14),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  if (step.description != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      step.description!,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.textGray
                            : AppColors.textMuted,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: progress.clamp(0.0, 1.0),
                            backgroundColor: isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isComplete ? AppColors.success : AppColors.amber,
                            ),
                            minHeight: 4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${step.completedProblems}/${step.totalProblems}',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.textGray
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              color: isDark ? AppColors.textGray : AppColors.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
