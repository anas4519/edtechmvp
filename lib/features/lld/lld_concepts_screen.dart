import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/topic.dart';
import '../../data/models/problem.dart';
import 'bloc/lld_cubit.dart';
import 'lld_topic_detail.dart';

class LldConceptsScreen extends StatelessWidget {
  final Topic topic;

  const LldConceptsScreen({super.key, required this.topic});

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
      body: BlocBuilder<LldCubit, LldState>(
        builder: (context, state) {
          final currentTopic = state.topics.firstWhere(
            (t) => t.id == topic.id,
            orElse: () => topic,
          );

          return Column(
            children: [
              // Stats header
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
                      label: 'Completed',
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

              // Concepts list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: currentTopic.problems.length,
                  itemBuilder: (context, index) {
                    final concept = currentTopic.problems[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the detail screen, passing a
                        // Topic built from the concept so the detail
                        // screen shows the concept title.
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => LldTopicDetail(
                              topic: Topic(
                                id: concept.id,
                                title: concept.title,
                                totalProblems: 1,
                                completedProblems: concept.isCompleted ? 1 : 0,
                              ),
                            ),
                          ),
                        );
                      },
                      child: _ConceptTile(
                        concept: concept,
                        index: index,
                        isDark: isDark,
                        onToggle: () {
                          context.read<LldCubit>().toggleConcept(
                            topic.id,
                            concept.id,
                          );
                        },
                      ),
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

class _ConceptTile extends StatelessWidget {
  final Problem concept;
  final int index;
  final bool isDark;
  final VoidCallback onToggle;

  const _ConceptTile({
    required this.concept,
    required this.index,
    required this.isDark,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          // Completion indicator
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: concept.isCompleted
                    ? AppColors.success
                    : Colors.transparent,
                border: Border.all(
                  color: concept.isCompleted
                      ? AppColors.success
                      : (isDark ? AppColors.textGray : AppColors.textMuted),
                  width: 2,
                ),
              ),
              child: concept.isCompleted
                  ? const Icon(Icons.circle, color: Colors.white, size: 14)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          // Concept title
          Expanded(
            child: Text(
              concept.title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Bookmark icon
          Icon(
            Icons.bookmark_border_rounded,
            size: 22,
            color: isDark ? AppColors.textGray : AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}
