import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary brand colors
  static const Color teal = Color(0xFF2DBDA8);
  static const Color tealLight = Color(0xFF3DD6BF);
  static const Color amber = Color(0xFFE8773A);
  static const Color amberLight = Color(0xFFF5A623);

  // Featured card colors (from screenshot)
  static const Color dsaGreen = Color(0xFF2DBDA8);
  static const Color lldBrown = Color(0xFF5C4033);
  static const Color allProblemsPurple = Color(0xFF7B5EA7);
  static const Color oopsPink = Color(0xFFBB86C0);

  // Dark theme - warm dark brown tones matching TUF+
  static const Color darkBg = Color(0xFF0D0B08);
  static const Color darkSurface = Color(0xFF171310);
  static const Color darkCard = Color(0xFF1E1914);
  static const Color darkCardAlt = Color(0xFF262019);
  static const Color darkBorder = Color(0xFF332B22);

  // Light theme
  static const Color lightBg = Color(0xFFF8F6F3);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF3F0EC);
  static const Color lightCardAlt = Color(0xFFE8E3DC);
  static const Color lightBorder = Color(0xFFD4CCC2);

  // Text
  static const Color textWhite = Color(0xFFEDE8E2);
  static const Color textGray = Color(0xFF9B8E80);
  static const Color textDark = Color(0xFF1E1914);
  static const Color textMuted = Color(0xFF6B5D50);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF5A623);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Difficulty
  static const Color easy = Color(0xFF22C55E);
  static const Color medium = Color(0xFFF5A623);
  static const Color hard = Color(0xFFEF4444);

  // Gradients
  static const LinearGradient tealGradient = LinearGradient(
    colors: [Color(0xFF2DBDA8), Color(0xFF3DD6BF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient amberGradient = LinearGradient(
    colors: [Color(0xFFE8773A), Color(0xFFF5A623)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF7B5EA7), Color(0xFFA17FD0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF171310), Color(0xFF1E1914)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
