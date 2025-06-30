import 'package:flutter/material.dart';
import 'package:kazerest_form/config/dark_theme.dart';

// Custom button widget
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isSecondary;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isSecondary = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: isEnabled && !isSecondary ? DarkTheme.primaryGradient : null,
        borderRadius: BorderRadius.circular(16),
        border: isSecondary ? Border.all(
          color: isEnabled ? DarkTheme.primaryPurple : DarkTheme.borderLight,
          width: 1,
        ) : null,
        boxShadow: isEnabled && !isSecondary ? [
          BoxShadow(
            color: DarkTheme.primaryPurple.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ] : null,
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary 
              ? DarkTheme.backgroundCard 
              : Colors.transparent,
          foregroundColor: isSecondary 
              ? (isEnabled ? DarkTheme.primaryPurple : DarkTheme.textMuted)
              : DarkTheme.textPrimary,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBackgroundColor: DarkTheme.borderLight,
          disabledForegroundColor: DarkTheme.textMuted,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
