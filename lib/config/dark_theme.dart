import 'package:flutter/material.dart';

class DarkTheme {
  // Primary Colors
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color primaryPurpleLight = Color(0xFFA78BFA);
  static const Color primaryPurpleDark = Color(0xFF7C3AED);
  
  // Background Colors
  static const Color backgroundPrimary = Color(0xFF0F0F23);
  static const Color backgroundSecondary = Color(0xFF1A1A2E);
  static const Color backgroundCard = Color(0xFF16213E);
  static const Color backgroundCardElevated = Color(0xFF1E2749);
  
  // Accent Colors
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentGreenLight = Color(0xFF34D399);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color accentRedLight = Color(0xFFF87171);
  static const Color accentAmber = Color(0xFFFBBF24);
  static const Color accentAmberLight = Color(0xFFFCD34D);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentCyanLight = Color(0xFF22D3EE);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFCBD5E1);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textPlaceholder = Color(0xFF64748B);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF8B5CF6),
      Color(0xFF7C3AED),
    ],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF16213E),
      Color(0xFF1A1A2E),
    ],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0F0F23),
      Color(0xFF1A1A2E),
    ],
  );
  
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF10B981),
      Color(0xFF059669),
    ],
  );
  
  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFEF4444),
      Color(0xFFDC2626),
    ],
  );
  
  static const LinearGradient amberGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFBBF24),
      Color(0xFFF59E0B),
    ],
  );
  
  // Borders
  static const Color borderLight = Color(0xFF334155);
  static const Color borderMedium = Color(0xFF475569);
  static const Color borderStrong = Color(0xFF64748B);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF06B6D4);
  
  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowStrong = Color(0x4D000000);
  
  // Glass Effect Colors
  static Color glass = Colors.white.withOpacity(0.1);
  static Color glassBorder = Colors.white.withOpacity(0.2);
  
  // Priority Colors for ordering
  static const List<Color> priorityColors = [
    Color(0xFFEF4444), // Red - Highest priority
    Color(0xFFF97316), // Orange
    Color(0xFFFBBF24), // Amber
    Color(0xFF10B981), // Green
    Color(0xFF06B6D4), // Cyan
    Color(0xFF8B5CF6), // Purple - Default
  ];
  
  // Category Colors
  static const List<LinearGradient> categoryGradients = [
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF10B981), Color(0xFF059669)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF97316), Color(0xFFEA580C)],
    ),
  ];
}
