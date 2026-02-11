import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/theme_bloc.dart';
import 'widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isDark
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                ),
                onPressed: () {
                  context.read<ThemeBloc>().add(const ToggleTheme());
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            ProfileHeader(isDark: isDark),
            const SizedBox(height: 24),

            // Track Progress Text
            TrackProgressSection(isDark: isDark),
            const SizedBox(height: 24),

            // DSA Progress Chart
            DsaProgressCard(isDark: isDark),
            const SizedBox(height: 16),

            // Sheet Progress Bars
            SheetProgressCard(isDark: isDark),
            const SizedBox(height: 16),

            // Skills
            InfoCard(
              title: 'Skills',
              subtitle: 'Edit Profile to add',
              isDark: isDark,
            ),
            const SizedBox(height: 16),

            // Submission Heatmap
            SubmissionHeatmap(isDark: isDark),
            const SizedBox(height: 16),

            // Coding Profiles
            InfoCard(
              title: 'Coding Profiles',
              subtitle: 'Edit Profile to add profiles',
              isDark: isDark,
              content: Center(
                child: Icon(
                  LineIcons.code,
                  size: 48,
                  color: isDark
                      ? AppColors.darkCardAlt
                      : AppColors.lightCardAlt,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Projects
            InfoCard(
              title: 'Projects',
              subtitle: 'Add projects to showcase your work',
              isDark: isDark,
              content: Center(
                child: Icon(
                  LineIcons.briefcase,
                  size: 48,
                  color: isDark
                      ? AppColors.darkCardAlt
                      : AppColors.lightCardAlt,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Contests
            InfoCard(
              title: 'Contests',
              subtitle:
                  'Rating graph will be visible after attending at least one contest.',
              isDark: isDark,
              content: Center(
                child: Icon(
                  LineIcons.trophy,
                  size: 48,
                  color: isDark
                      ? AppColors.darkCardAlt
                      : AppColors.lightCardAlt,
                ),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
