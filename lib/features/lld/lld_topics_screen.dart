import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import 'bloc/lld_cubit.dart';
import 'lld_topic_detail.dart';

class LldTopicsScreen extends StatelessWidget {
  const LldTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LldCubit()..loadTopics(),
      child: const _LldTopicsView(),
    );
  }
}

class _LldTopicsView extends StatelessWidget {
  const _LldTopicsView();

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
          'Low Level Design',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: BlocBuilder<LldCubit, LldState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.topics.length,
            itemBuilder: (context, index) {
              final topic = state.topics[index];
              final colors = [
                AppColors.amber,
                AppColors.amber,
                AppColors.info,
                const Color(0xFFA855F7),
                AppColors.success,
                const Color(0xFFEC4899),
                const Color(0xFF6366F1),
                AppColors.warning,
                const Color(0xFF14B8A6),
                AppColors.error,
              ];
              final color = colors[index % colors.length];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => LldTopicDetail(topic: topic),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border(left: BorderSide(color: color, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _getTopicIcon(index),
                          color: color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              topic.title,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '${topic.totalProblems} ${topic.totalProblems == 1 ? 'concept' : 'concepts'}',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: color,
                                    ),
                                  ),
                                ),
                                if (topic.completedProblems > 0) ...[
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.check_circle_rounded,
                                    size: 14,
                                    color: AppColors.success,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${topic.completedProblems} done',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: isDark
                            ? AppColors.textGray
                            : AppColors.textMuted,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  IconData _getTopicIcon(int index) {
    const icons = [
      Icons.foundation_rounded,
      Icons.construction_rounded,
      Icons.widgets_rounded,
      Icons.psychology_rounded,
      Icons.local_parking_rounded,
      Icons.grid_3x3_rounded,
      Icons.movie_rounded,
      Icons.elevator_rounded,
      Icons.casino_rounded,
      Icons.account_balance_rounded,
    ];
    return icons[index % icons.length];
  }
}
