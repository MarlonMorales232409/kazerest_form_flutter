import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/view/questionnaire/interest_cards_view.dart';
import 'package:kazerest_form/view/questionnaire/priority_ordering_view.dart';
import 'package:kazerest_form/view/questionnaire/califications_view.dart';
import 'package:kazerest_form/view/questionnaire/categories_importance_view.dart';
import 'package:kazerest_form/view/questionnaire/user_data_form_view.dart';
import 'package:kazerest_form/view/questionnaire/circular_progress_widget.dart';
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
          child: Stack(
            children: [
              Obx(() => _buildCurrentStep()),
              const PositionedCircularProgress(),
            ],
          ),
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
        return const UserDataFormView();
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
