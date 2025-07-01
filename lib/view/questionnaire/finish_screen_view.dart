import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/view/questionnaire/welcome_screen_view.dart';
import 'package:kazerest_form/view/questionnaire/circular_progress_widget.dart';
import 'package:kazerest_form/view/widgets/custom_button.dart' as widgets;
import 'package:kazerest_form/controller/questionnaire_controller.dart';

class FinishScreenView extends StatelessWidget {
  const FinishScreenView({super.key});

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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const MobileProgressHeader(showOnFinishScreen: true),
          Expanded(
            child: _buildContent(),
          ),
          _buildActionButtons(),
          _buildWatermark(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0),
      child: Column(
        children: [
          Expanded(
            child: _buildContent(),
          ),
          _buildActionButtons(),
          _buildWatermark(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(48.0),
        child: Column(
          children: [
            Expanded(
              child: _buildContent(),
            ),
            _buildActionButtons(),
            _buildWatermark(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSuccessIcon(),
          const SizedBox(height: 32),
          _buildTitle(),
          const SizedBox(height: 16),
          _buildSubtitle(),
          const SizedBox(height: 24),
          _buildDescription(),
        ],
      ),
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
        const SizedBox(height: 12),
        // Contact info
        SizedBox(
          width: double.infinity,
          child: widgets.CustomButton(
            text: 'Información de Contacto',
            icon: Icons.contact_support_rounded,
            isSecondary: true,
            onPressed: () {
              _showContactInfo();
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
    
    // Navigate to the welcome screen for a fresh start
    Get.offAll(() => const WelcomeScreenView());
  }

  void _showContactInfo() {
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
              const Icon(
                Icons.contact_mail_rounded,
                size: 48,
                color: DarkTheme.primaryPurple,
              ),
              const SizedBox(height: 16),
              const Text(
                'Información de Contacto',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: DarkTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              _buildContactItem(
                icon: Icons.email_rounded,
                title: 'Email',
                value: 'contacto@kazerest.com',
              ),
              _buildContactItem(
                icon: Icons.phone_rounded,
                title: 'Teléfono',
                value: '+1 (555) 123-4567',
              ),
              _buildContactItem(
                icon: Icons.language_rounded,
                title: 'Sitio Web',
                value: 'www.kazerest.com',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: widgets.CustomButton(
                  text: 'Cerrar',
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: DarkTheme.backgroundPrimary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: DarkTheme.borderLight.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Fixed width container for icon to ensure consistent alignment
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: DarkTheme.primaryPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: DarkTheme.primaryPurple,
            ),
          ),
          const SizedBox(width: 16),
          // Expanded to take remaining space and ensure consistent layout
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: DarkTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: DarkTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
