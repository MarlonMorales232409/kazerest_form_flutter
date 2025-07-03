import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/view/questionnaire/welcome_screen_view.dart';
import 'package:kazerest_form/view/questionnaire/circular_progress_widget.dart';
import 'package:kazerest_form/view/widgets/custom_button.dart' as widgets;
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:confetti/confetti.dart';

class FinishScreenView extends StatefulWidget {
  const FinishScreenView({super.key});

  @override
  State<FinishScreenView> createState() => _FinishScreenViewState();
}

class _FinishScreenViewState extends State<FinishScreenView> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    // Start the animation when the screen loads
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

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
              _buildResponsiveLayout(context),
              const PositionedCircularProgress(showOnFinishScreen: true),
              // Top center cannon
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi / 2, // down
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  maxBlastForce: 20,
                  minBlastForce: 10,
                  gravity: 0.1,
                  colors: const [
                    DarkTheme.primaryPurple,
                    DarkTheme.primaryPurpleLight,
                    DarkTheme.accentGreen,
                    Colors.orange,
                    Colors.pink,
                    Colors.blue,
                  ],
                ),
              ),
              // Left side cannon
              Align(
                alignment: Alignment.centerLeft,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: 0, // right
                  emissionFrequency: 0.05,
                  numberOfParticles: 10,
                  maxBlastForce: 20,
                  minBlastForce: 10,
                  gravity: 0.1,
                  colors: const [
                    DarkTheme.primaryPurple,
                    DarkTheme.primaryPurpleLight,
                    DarkTheme.accentGreen,
                    Colors.orange,
                  ],
                ),
              ),
              // Right side cannon
              Align(
                alignment: Alignment.centerRight,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi, // left
                  emissionFrequency: 0.05,
                  numberOfParticles: 10,
                  maxBlastForce: 20,
                  minBlastForce: 10,
                  gravity: 0.1,
                  colors: const [
                    DarkTheme.primaryPurple,
                    DarkTheme.primaryPurpleLight,
                    Colors.pink,
                    Colors.blue,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    
    if (isDesktop) {
      return _buildDesktopLayout(context);
    } else if (isTablet) {
      return _buildTabletLayout(context);
    } else {
      return _buildMobileLayout(context);
    }
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const MobileProgressHeader(showOnFinishScreen: true),
          const SizedBox(height: 24),
          _buildContent(),
          const SizedBox(height: 24),
          _buildActionButtons(),
          const SizedBox(height: 16),
          _buildWatermark(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0),
      child: Column(
        children: [
          _buildContent(),
          const SizedBox(height: 24),
          _buildActionButtons(),
          const SizedBox(height: 16),
          _buildWatermark(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            children: [
              _buildContent(),
              const SizedBox(height: 24),
              _buildActionButtons(),
              const SizedBox(height: 16),
              _buildWatermark(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildSuccessIcon(),
        const SizedBox(height: 32),
        _buildTitle(),
        const SizedBox(height: 16),
        _buildSubtitle(),
        const SizedBox(height: 24),
        _buildDescription(),
      ],
    );
  }

  Widget _buildWatermark() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: DarkTheme.primaryPurple.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/logo.png',
                width: 24,
                height: 24,
                fit: BoxFit.cover,
                cacheWidth: 24,
                cacheHeight: 24,
                filterQuality: FilterQuality.high,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          DarkTheme.primaryPurple,
                          DarkTheme.primaryPurpleLight,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu_rounded,
                      color: DarkTheme.textPrimary,
                      size: 14,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'KazeCode',
            style: TextStyle(
              fontSize: 12,
              color: DarkTheme.textSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            DarkTheme.accentGreen,
            DarkTheme.accentGreen.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: DarkTheme.accentGreen.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(
        Icons.check_rounded,
        color: DarkTheme.textPrimary,
        size: 60,
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      '¡Evaluación Completada!',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: DarkTheme.textPrimary,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      'Tu respuesta ha sido enviada exitosamente',
      style: TextStyle(
        fontSize: 18,
        color: DarkTheme.textSecondary,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: DarkTheme.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: DarkTheme.borderLight,
          width: 1,
        ),
      ),
      child: const Text(
        'Gracias por completar la evaluación de KazeRest. Hemos recibido todas tus respuestas y nuestro equipo las revisará cuidadosamente.\n\nTe contactaremos pronto con una propuesta personalizada que se adapte a las necesidades específicas de tu negocio.',
        style: TextStyle(
          fontSize: 16,
          color: DarkTheme.textSecondary,
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Fireworks button
        SizedBox(
          width: double.infinity,
          child: widgets.CustomButton(
            text: 'Celebrar de Nuevo',
            icon: Icons.celebration,
            isSecondary: true,
            onPressed: () {
              _confettiController.play();
            },
          ),
        ),
        const SizedBox(height: 12),
        // Primary action - Start new evaluation
        SizedBox(
          width: double.infinity,
          child: widgets.CustomButton(
            text: 'Realizar Nueva Evaluación',
            icon: Icons.refresh_rounded,
            onPressed: () {
              _startNewEvaluation();
            },
          ),
        ),
      ],
    );
  }

  void _startNewEvaluation() {
    // Reset all controller data and start from beginning if controller exists
    try {
      if (Get.isRegistered<QuestionnaireController>()) {
        final controller = Get.find<QuestionnaireController>();
        controller.resetAll();
      }
    } catch (e) {
      // If controller doesn't exist, just continue - it will be created fresh
      print('Controller not found, will be created fresh: $e');
    }
    
    // Reset the progress indicator to initial state
    CircularProgressWidget.resetProgress();
    
    // Navigate to the welcome screen for a fresh start
    Get.offAll(() => const WelcomeScreenView());
  }
}
