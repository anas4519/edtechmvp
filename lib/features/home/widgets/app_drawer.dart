import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import '../../../core/constants/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with Home/Plus tabs and close button
              _buildHeader(context, isDark),
              const SizedBox(height: 24),
              Divider(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                height: 1,
              ),
              const SizedBox(height: 16),

              // Menu items
              _DrawerMenuItem(
                icon: LineIcons.user,
                label: 'My Profile',
                isDark: isDark,
                onTap: () => Navigator.pop(context),
              ),
              _DrawerMenuItem(
                icon: LineIcons.cog,
                label: 'Account',
                isDark: isDark,
                onTap: () => Navigator.pop(context),
              ),
              _DrawerMenuItem(
                icon: LineIcons.bell,
                label: 'Notifications',
                isDark: isDark,
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? AppColors.textGray : AppColors.textMuted,
                  size: 22,
                ),
                onTap: () => Navigator.pop(context),
              ),
              _DrawerMenuItem(
                icon: LineIcons.bug,
                label: 'Buganizer',
                isDark: isDark,
                onTap: () => Navigator.pop(context),
              ),
              _DrawerMenuItem(
                icon: LineIcons.alternateSignOut,
                label: 'Logout',
                isDark: isDark,
                labelColor: AppColors.amber,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close_rounded,
              color: isDark ? AppColors.textGray : AppColors.textMuted,
              size: 24,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Home tab
            _TabChip(
              icon: LineIcons.home,
              label: 'Home',
              isActive: false,
              isDark: isDark,
            ),
            const SizedBox(width: 8),
            // Plus tab
            _TabChip(
              icon: Icons.grid_view_rounded,
              label: 'Plus',
              isActive: true,
              isDark: isDark,
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Private helper widgets ──────────────────────────────────────────────────

class _TabChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isDark;

  const _TabChip({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.amber;
    final inactiveColor = isDark ? AppColors.textGray : AppColors.textMuted;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isActive
            ? activeColor.withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isActive
            ? Border.all(color: activeColor.withValues(alpha: 0.3))
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: isActive ? activeColor : inactiveColor),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final Color? labelColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    required this.isDark,
    this.labelColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        labelColor ?? (isDark ? AppColors.textWhite : AppColors.textDark);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
