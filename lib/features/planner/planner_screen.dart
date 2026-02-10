import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/constants/app_colors.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Mock streak data – days the user solved problems
  final Set<int> _streakDays = {
    1,
    2,
    3,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Planner',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Section
            _ProgressSection(isDark: isDark, theme: theme),

            const SizedBox(height: 16),

            // Calendar Section
            _CalendarSection(
              isDark: isDark,
              theme: theme,
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              streakDays: _streakDays,
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
            ),

            const SizedBox(height: 16),

            // Streak Info
            _StreakSection(isDark: isDark),

            const SizedBox(height: 16),

            // Leaderboard Section
            _LeaderboardSection(isDark: isDark, theme: theme),

            const SizedBox(height: 16),

            // Daily Planner
            _DailyPlannerSection(isDark: isDark, theme: theme),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Progress Section
// ──────────────────────────────────────────────
class _ProgressSection extends StatelessWidget {
  final bool isDark;
  final ThemeData theme;

  const _ProgressSection({required this.isDark, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCardAlt
                      : AppColors.lightCardAlt,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Progress',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Circular progress + stats
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular indicator
              CircularPercentIndicator(
                radius: 48,
                lineWidth: 8,
                percent: 296 / 986,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '296',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.amber,
                      ),
                    ),
                    Text(
                      '986',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.textGray
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                progressColor: AppColors.amber,
                backgroundColor: isDark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(width: 32),
              // Difficulty breakdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DifficultyRow(
                    color: AppColors.easy,
                    label: 'Easy',
                    solved: 60,
                    total: 307,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 8),
                  _DifficultyRow(
                    color: AppColors.medium,
                    label: 'Medium',
                    solved: 119,
                    total: 425,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 8),
                  _DifficultyRow(
                    color: AppColors.hard,
                    label: 'Hard',
                    solved: 117,
                    total: 254,
                    isDark: isDark,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DifficultyRow extends StatelessWidget {
  final Color color;
  final String label;
  final int solved;
  final int total;
  final bool isDark;

  const _DifficultyRow({
    required this.color,
    required this.label,
    required this.solved,
    required this.total,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          '$label  ',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.textGray : AppColors.textMuted,
          ),
        ),
        Text(
          '$solved/$total',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textWhite : AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────
// Calendar Section
// ──────────────────────────────────────────────
class _CalendarSection extends StatelessWidget {
  final bool isDark;
  final ThemeData theme;
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Set<int> streakDays;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;

  const _CalendarSection({
    required this.isDark,
    required this.theme,
    required this.calendarFormat,
    required this.focusedDay,
    required this.selectedDay,
    required this.streakDays,
    required this.onDaySelected,
    required this.onFormatChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.5,
        ),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        calendarFormat: calendarFormat,
        startingDayOfWeek: StartingDayOfWeek.monday,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,
        onFormatChanged: onFormatChanged,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            final hasStreak =
                streakDays.contains(day.day) &&
                day.month == DateTime.now().month;
            return Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasStreak
                    ? AppColors.amber.withValues(alpha: 0.15)
                    : null,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (hasStreak)
                      const Text('🔥', style: TextStyle(fontSize: 10)),
                    Text(
                      '${day.day}',
                      style: GoogleFonts.inter(
                        fontSize: hasStreak ? 11 : 13,
                        fontWeight: hasStreak
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.amber.withValues(alpha: 0.3),
                border: Border.all(color: AppColors.amber, width: 1.5),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.amber,
                  ),
                ),
              ),
            );
          },
        ),
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            color: AppColors.amber,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          weekendTextStyle: GoogleFonts.inter(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          outsideTextStyle: GoogleFonts.inter(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
          ),
          cellMargin: const EdgeInsets.all(2),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left_rounded,
            color: AppColors.amber,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right_rounded,
            color: AppColors.amber,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.textGray : AppColors.textMuted,
          ),
          weekendStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.textGray : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Streak Section
// ──────────────────────────────────────────────
class _StreakSection extends StatelessWidget {
  final bool isDark;

  const _StreakSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Current streak
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  'Current  🔥 ',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textGray : AppColors.textMuted,
                  ),
                ),
                Text(
                  '1',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textWhite : AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Divider
          Container(
            width: 1,
            height: 24,
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
          const SizedBox(width: 8),
          // Max streak
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  'Max  🔥 ',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textGray : AppColors.textMuted,
                  ),
                ),
                Text(
                  '12',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textWhite : AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Leaderboard button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  size: 16,
                  color: AppColors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  'Leaderboard',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textGray : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Leaderboard Section
// ──────────────────────────────────────────────
class _LeaderboardSection extends StatelessWidget {
  final bool isDark;
  final ThemeData theme;

  const _LeaderboardSection({required this.isDark, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _RankAvatar(
            rank: 1,
            name: 'Rank 1',
            color: const Color(0xFFFFD700),
            isDark: isDark,
          ),
          _RankAvatar(
            rank: 2,
            name: 'Rank 2',
            color: const Color(0xFFC0C0C0),
            isDark: isDark,
          ),
          _RankAvatar(
            rank: 3,
            name: 'Rank 3',
            color: const Color(0xFFCD7F32),
            isDark: isDark,
          ),
          // Placeholder for more
          Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCardAlt
                      : AppColors.lightCardAlt,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                  ),
                ),
                child: Icon(
                  Icons.more_horiz_rounded,
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                  size: 22,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '...',
                style: GoogleFonts.inter(
                  fontSize: 11,
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

class _RankAvatar extends StatelessWidget {
  final int rank;
  final String name;
  final Color color;
  final bool isDark;

  const _RankAvatar({
    required this.rank,
    required this.name,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: color, width: 2),
              ),
              child: Icon(
                Icons.person_rounded,
                color: Colors.white.withValues(alpha: 0.9),
                size: 28,
              ),
            ),
            Positioned(
              bottom: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('🏆', style: const TextStyle(fontSize: 10)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.textGray : AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────
// Daily Planner Section
// ──────────────────────────────────────────────
class _DailyPlannerSection extends StatelessWidget {
  final bool isDark;
  final ThemeData theme;

  const _DailyPlannerSection({required this.isDark, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  'Daily Planner',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '0',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.edit_outlined,
              size: 18,
              color: isDark ? AppColors.textGray : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
