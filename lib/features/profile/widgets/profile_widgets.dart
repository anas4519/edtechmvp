import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../core/constants/app_colors.dart';

// ─── Profile Header ──────────────────────────────────────────────────────────

class ProfileHeader extends StatelessWidget {
  final bool isDark;

  const ProfileHeader({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Icon(
                LineIcons.user,
                size: 32,
                color: isDark ? AppColors.textGray : AppColors.textMuted,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anas Nadeem',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Anas',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.amber,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                icon: LineIcons.edit,
                label: 'Edit Profile',
                isDark: isDark,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionButton(
                icon: LineIcons.share,
                label: 'Share Profile',
                isDark: isDark,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isDark ? AppColors.textGray : AppColors.textMuted,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textGray : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Track Progress ──────────────────────────────────────────────────────────

class TrackProgressSection extends StatelessWidget {
  final bool isDark;

  const TrackProgressSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Track Progress',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        _ProgressRow(label: 'DSA', value: '63%', isDark: isDark),
        _ProgressRow(label: 'OOPS', value: '100%', isDark: isDark),
        _ProgressRow(label: 'Low Level Design', value: '24%', isDark: isDark),
        _ProgressRow(label: 'CORE Subjects', value: '0%', isDark: isDark),
      ],
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const _ProgressRow({
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textGray : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Reusable Card Container ─────────────────────────────────────────────────

class AppCard extends StatelessWidget {
  final Widget child;
  final bool isDark;
  final EdgeInsetsGeometry? padding;

  const AppCard({
    super.key,
    required this.child,
    required this.isDark,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.5,
        ),
      ),
      child: child,
    );
  }
}

// ─── DSA Progress Card ───────────────────────────────────────────────────────

class DsaProgressCard extends StatefulWidget {
  final bool isDark;

  const DsaProgressCard({super.key, required this.isDark});

  @override
  State<DsaProgressCard> createState() => _DsaProgressCardState();
}

class _DsaProgressCardState extends State<DsaProgressCard> {
  bool _isTufSelected = true;

  @override
  Widget build(BuildContext context) {
    // Mock data based on selection
    final total = _isTufSelected ? 986 : 1500;

    // Values as integers
    final easyVal = _isTufSelected ? 60 : 150;
    final mediumVal = _isTufSelected ? 119 : 200;
    final hardVal = _isTufSelected ? 117 : 100;

    final solved = easyVal + mediumVal + hardVal;

    // Percentages for stacked indicators
    // 1. Bottom layer (Hard + Medium + Easy)
    final hardPercent = (easyVal + mediumVal + hardVal) / total;
    // 2. Middle layer (Medium + Easy)
    final mediumPercent = (easyVal + mediumVal) / total;
    // 3. Top layer (Easy)
    final easyPercent = easyVal / total;

    // Strings for text
    final easyStr = _isTufSelected ? '$easyVal/307' : '$easyVal/500';
    final mediumStr = _isTufSelected ? '$mediumVal/425' : '$mediumVal/600';
    final hardStr = _isTufSelected ? '$hardVal/254' : '$hardVal/400';

    return AppCard(
      isDark: widget.isDark,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DSA Progress',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? AppColors.darkCardAlt
                      : AppColors.lightCardAlt,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    _ToggleOption(
                      label: 'TUF',
                      isSelected: _isTufSelected,
                      isDark: widget.isDark,
                      onTap: () => setState(() => _isTufSelected = true),
                    ),
                    _ToggleOption(
                      label: 'LeetCode',
                      isSelected: !_isTufSelected,
                      isDark: widget.isDark,
                      onTap: () => setState(() => _isTufSelected = false),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Hard layer (Bottom - Red)
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 10.0,
                    percent: hardPercent,
                    backgroundColor: widget.isDark
                        ? AppColors.darkCardAlt.withValues(alpha: 0.5)
                        : AppColors.lightCardAlt,
                    progressColor: AppColors.error,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 800,
                  ),
                  // Medium layer (Middle - Amber)
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 10.0,
                    percent: mediumPercent,
                    backgroundColor: Colors.transparent,
                    progressColor: AppColors.amber,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 800,
                  ),
                  // Easy layer (Top - Teal)
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 10.0,
                    percent: easyPercent,
                    backgroundColor:
                        Colors.transparent, // Transparent to show layers below
                    progressColor: AppColors.teal,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 800,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$solved',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 24,
                          color: widget.isDark
                              ? AppColors.textGray
                              : AppColors.textMuted,
                          margin: const EdgeInsets.symmetric(vertical: 2),
                        ),
                        Text(
                          '$total',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: widget.isDark
                                ? AppColors.textGray
                                : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LegendItem(
                    color: AppColors.teal,
                    label: 'Easy',
                    value: easyStr,
                    isDark: widget.isDark,
                  ),
                  const SizedBox(height: 8),
                  _LegendItem(
                    color: AppColors.amber,
                    label: 'Medium',
                    value: mediumStr,
                    isDark: widget.isDark,
                  ),
                  const SizedBox(height: 8),
                  _LegendItem(
                    color: AppColors.error,
                    label: 'Hard',
                    value: hardStr,
                    isDark: widget.isDark,
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

class _ToggleOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _ToggleOption({
    required this.label,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                    ? AppColors.darkCardAlt.withValues(alpha: 0.5)
                    : AppColors.lightCard)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(
                  color: isDark
                      ? AppColors.amber.withValues(alpha: 0.5)
                      : AppColors.textMuted,
                  width: 0.5,
                )
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.onSurface
                : (isDark ? AppColors.textGray : AppColors.textMuted),
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  final bool isDark;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          '$label  ',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isDark ? AppColors.textGray : AppColors.textMuted,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.textGray : AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

// ─── Sheet Progress Card ─────────────────────────────────────────────────────

class SheetProgressCard extends StatelessWidget {
  final bool isDark;

  const SheetProgressCard({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sheet Progress',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _SheetProgressBar(
            label: 'A2Z Sheet',
            percent: 0.14,
            color: AppColors.amber,
            isDark: isDark,
          ),
          _SheetProgressBar(
            label: 'Striver 79 Sheet',
            percent: 0.11,
            color: AppColors.amber,
            isDark: isDark,
          ),
          _SheetProgressBar(
            label: 'SDE Sheet',
            percent: 0.03,
            color: AppColors.amber,
            isDark: isDark,
          ),
          _SheetProgressBar(
            label: 'Blind 75 Sheet',
            percent: 0.03,
            color: AppColors.amber,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _SheetProgressBar extends StatelessWidget {
  final String label;
  final double percent;
  final Color color;
  final bool isDark;

  const _SheetProgressBar({
    required this.label,
    required this.percent,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                ),
              ),
              Text(
                '${(percent * 100).toInt()}%',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearPercentIndicator(
            lineHeight: 8.0,
            percent: percent,
            padding: EdgeInsets.zero,
            backgroundColor: isDark
                ? AppColors.darkCardAlt
                : AppColors.lightCardAlt,
            progressColor: color,
            barRadius: const Radius.circular(4),
          ),
        ],
      ),
    );
  }
}

// ─── Simple Info Card (Skills, etc) ──────────────────────────────────────────

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDark;
  final Widget? content;

  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isDark,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      isDark: isDark,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (content != null) ...[
              const SizedBox(height: 16),
              content!,
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isDark ? AppColors.textGray : AppColors.textMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ] else ...[
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ─── Submission Heatmap ──────────────────────────────────────────────────────

class SubmissionHeatmap extends StatefulWidget {
  final bool isDark;

  const SubmissionHeatmap({super.key, required this.isDark});

  @override
  State<SubmissionHeatmap> createState() => _SubmissionHeatmapState();
}

class _SubmissionHeatmapState extends State<SubmissionHeatmap> {
  String _selectedYear = '2026';
  bool _isTufSelected = true;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      isDark: widget.isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: _isTufSelected ? '37 ' : '120 ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: 'submissions in the year',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _selectedYear,
                  items: ['2024', '2025', '2026'].map((String year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(
                        year,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedYear = newValue;
                      });
                    }
                  },
                  underline: const SizedBox(),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  dropdownColor: widget.isDark
                      ? AppColors.darkSurface
                      : AppColors.lightSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Toggle
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: widget.isDark
                  ? AppColors.darkCardAlt
                  : AppColors.lightCardAlt,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ToggleOption(
                  label: 'TUF',
                  isSelected: _isTufSelected,
                  isDark: widget.isDark,
                  onTap: () => setState(() => _isTufSelected = true),
                ),
                _ToggleOption(
                  label: 'LeetCode',
                  isSelected: !_isTufSelected,
                  isDark: widget.isDark,
                  onTap: () => setState(() => _isTufSelected = false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Grid
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 140, // Height for roughly 7 rows of 20px squares
              width: 600, // Make it wide enough to scroll
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, // 7 days in a week (rows)
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1, // Square cells
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 53 * 7, // 53 weeks
                itemBuilder: (context, index) {
                  // Mock pattern depending on selection and random factor per year
                  final factor = _isTufSelected
                      ? (_selectedYear == '2026' ? 7 : 5)
                      : (_selectedYear == '2026' ? 4 : 3);
                  final isActive =
                      (index % factor == 2) || (index % 5 == 0 && index < 30);
                  return Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.success
                          : (widget.isDark
                                ? AppColors.darkCardAlt
                                : AppColors.lightCardAlt),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Month labels row (simplified mock)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['Jan', 'Feb', 'Mar', 'Apr', 'May'].map((m) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  m,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: widget.isDark
                        ? AppColors.textGray
                        : AppColors.textMuted,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Days - ${_isTufSelected ? 14 : 45}  |  Max Streak - ${_isTufSelected ? 5 : 12}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: widget.isDark
                        ? AppColors.textGray
                        : AppColors.textMuted,
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: widget.isDark
                            ? AppColors.darkCardAlt
                            : AppColors.lightCardAlt,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Not visited yet',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: widget.isDark
                            ? AppColors.textGray
                            : AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Achieved',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: widget.isDark
                            ? AppColors.textGray
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
