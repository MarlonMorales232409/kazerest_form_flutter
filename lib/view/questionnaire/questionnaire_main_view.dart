import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/view/questionnaire/interest_cards_view.dart';
import 'package:kazerest_form/view/questionnaire/priority_ordering_view.dart';
import 'package:kazerest_form/view/questionnaire/califications_view.dart';
import 'package:kazerest_form/view/questionnaire/categories_importance_view.dart';
import 'package:kazerest_form/view/questionnaire/user_data_form_view.dart';
import 'package:kazerest_form/config/dark_theme.dart';

class QuestionnaireMainView extends StatelessWidget {
  final QuestionnaireController controller = Get.put(QuestionnaireController());

  QuestionnaireMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: DarkTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Obx(() => _buildCurrentStep()),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (controller.currentStep.value) {
      case 0:
        return InterestCardsView();
      case 1:
        return PriorityOrderingView();
      case 2:
        return CalificationsView();
      case 3:
        return CategoriesImportanceView();
      case 4:
        return UserDataFormView();
      default:
        return InterestCardsView();
    }
  }
}

// Progress indicator widget for showing current step
class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            children: List.generate(totalSteps, (index) {
              final isActive = index <= currentStep;
              final isCompleted = index < currentStep;
              
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < totalSteps - 1 ? 8 : 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            gradient: isActive || isCompleted 
                                ? DarkTheme.primaryGradient
                                : null,
                            color: isActive || isCompleted 
                                ? null
                                : DarkTheme.borderLight,
                            boxShadow: isActive || isCompleted ? [
                              BoxShadow(
                                color: DarkTheme.primaryPurple.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ] : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          Text(
            'Paso ${currentStep + 1} de $totalSteps',
            style: const TextStyle(
              fontSize: 14,
              color: DarkTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

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
