import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/view/questionnaire/circular_progress_widget.dart';
import 'package:kazerest_form/view/widgets/custom_button.dart';

class ProgressDemoView extends StatelessWidget {
  const ProgressDemoView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionnaireController>();
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: DarkTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Main content
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        size: 64,
                        color: DarkTheme.primaryPurple,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Demostración del Indicador de Progreso',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: DarkTheme.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Observa el indicador circular en la esquina superior derecha mientras cambias de paso.',
                        style: TextStyle(
                          fontSize: 16,
                          color: DarkTheme.textSecondary,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      Obx(() => Column(
                        children: [
                          Text(
                            'Paso Actual: ${controller.currentStep.value + 1} de 5',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: DarkTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  text: 'Anterior',
                                  icon: Icons.arrow_back_rounded,
                                  isSecondary: true,
                                  isEnabled: controller.currentStep.value > 0,
                                  onPressed: controller.currentStep.value > 0
                                      ? () => controller.currentStep.value--
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomButton(
                                  text: 'Siguiente',
                                  icon: Icons.arrow_forward_rounded,
                                  isEnabled: controller.currentStep.value < 4,
                                  onPressed: controller.currentStep.value < 4
                                      ? () => controller.currentStep.value++
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: 'Mostrar Finalizado',
                            icon: Icons.check_circle_rounded,
                            isSecondary: true,
                            onPressed: () {
                              Get.dialog(
                                Dialog(
                                  backgroundColor: DarkTheme.backgroundCard,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Vista de Finalización',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: DarkTheme.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'Observa el indicador completado con animación',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: DarkTheme.textSecondary,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 24),
                                        const CircularProgressWidget(
                                          size: 100,
                                          showOnFinishScreen: true,
                                        ),
                                        const SizedBox(height: 24),
                                        CustomButton(
                                          text: 'Cerrar',
                                          onPressed: () => Get.back(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              // Progress indicator
              const PositionedCircularProgress(),
            ],
          ),
        ),
      ),
    );
  }
}
