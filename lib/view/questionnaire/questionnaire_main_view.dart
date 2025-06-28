import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/view/questionnaire/interest_cards_view.dart';
import 'package:kazerest_form/view/questionnaire/priority_ordering_view.dart';
import 'package:kazerest_form/view/questionnaire/califications_view.dart';
import 'package:kazerest_form/view/questionnaire/categories_importance_view.dart';
import 'package:kazerest_form/view/questionnaire/user_data_form_view.dart';

class QuestionnaireMainView extends StatelessWidget {
  final QuestionnaireController controller = Get.put(QuestionnaireController());

  QuestionnaireMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Obx(() => _buildCurrentStep()),
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
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

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
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: isActive || isCompleted 
                                ? const Color(0xFF6366F1) 
                                : const Color(0xFFE5E7EB),
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
              color: Color(0xFF6B7280),
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
    Key? key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isSecondary = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary 
              ? Colors.white 
              : const Color(0xFF6366F1),
          foregroundColor: isSecondary 
              ? const Color(0xFF6366F1) 
              : Colors.white,
          elevation: isSecondary ? 0 : 2,
          side: isSecondary 
              ? const BorderSide(color: Color(0xFF6366F1), width: 1) 
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: const Color(0xFFE5E7EB),
          disabledForegroundColor: const Color(0xFF9CA3AF),
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
