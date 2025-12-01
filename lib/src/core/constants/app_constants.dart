import 'package:flutter/material.dart';

/// App-wide color constants
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF19AF48);
  static const Color primaryDark = Color(0xFF0F8F38);
  static const Color accent = Color(0xFFA3CB43);

  // Background colors
  static const Color background = Color(0xFF003334);
  static const Color cardBackground = Color(0xFF0F1F1F);
  static const Color darkCard = Color(0xFF1A2A2A);

  // Text colors
  static const Color textPrimary = Colors.white;
  static final Color textSecondary = Colors.white.withValues(alpha: 0.9);
  static final Color textTertiary = Colors.white.withValues(alpha: 0.7);

  // Utility colors
  static final Color overlay = Colors.black.withValues(alpha: 0.5);
  static final Color shimmer = Colors.grey.withValues(alpha: 0.3);
}

/// App-wide spacing constants
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

/// App-wide border radius constants
class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double round = 999.0;
}

/// App-wide font sizes
class AppFontSizes {
  static const double xs = 10.0;
  static const double sm = 12.0;
  static const double md = 14.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
}
