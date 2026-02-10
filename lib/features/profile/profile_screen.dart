import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/theme_bloc.dart';

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.amberGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.amber.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.4),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Anas Nadeem',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'TUF+ Premium Member',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatBadge(value: '160', label: 'Solved'),
                      _StatBadge(value: '7', label: 'Streak'),
                      _StatBadge(value: '35%', label: 'Progress'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Settings section
            _SettingsSection(
              title: 'Preferences',
              isDark: isDark,
              children: [
                // Theme toggle
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return _SettingsTile(
                      icon: themeState.isDark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      title: 'Dark Mode',
                      isDark: isDark,
                      trailing: Switch.adaptive(
                        value: themeState.isDark,
                        onChanged: (_) {
                          context.read<ThemeBloc>().add(const ToggleTheme());
                        },
                        activeColor: AppColors.amber,
                      ),
                    );
                  },
                ),
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  isDark: isDark,
                  trailing: Switch.adaptive(
                    value: true,
                    onChanged: (_) {},
                    activeColor: AppColors.amber,
                  ),
                ),
                _SettingsTile(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  isDark: isDark,
                  trailing: Text(
                    'English',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isDark ? AppColors.textGray : AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _SettingsSection(
              title: 'About',
              isDark: isDark,
              children: [
                _SettingsTile(
                  icon: Icons.info_outline_rounded,
                  title: 'App Version',
                  isDark: isDark,
                  trailing: Text(
                    '1.0.0',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isDark ? AppColors.textGray : AppColors.textMuted,
                    ),
                  ),
                ),
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  isDark: isDark,
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: isDark ? AppColors.textGray : AppColors.textMuted,
                  ),
                ),
                _SettingsTile(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  isDark: isDark,
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: isDark ? AppColors.textGray : AppColors.textMuted,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Logout button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout_rounded, size: 20),
                label: Text(
                  'Logout',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
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

class _StatBadge extends StatelessWidget {
  final String value;
  final String label;

  const _StatBadge({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final bool isDark;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.isDark,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textGray : AppColors.textMuted,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              width: 0.5,
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDark;
  final Widget trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.isDark,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: isDark ? AppColors.textGray : AppColors.textMuted,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
