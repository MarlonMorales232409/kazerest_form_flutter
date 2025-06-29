import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/view/questionnaire/questionnaire_main_view.dart';

class WelcomeScreenView extends StatelessWidget {
  const WelcomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: DarkTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: _buildResponsiveLayout(context),
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: _buildScrollableContent(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: _buildStartButton(),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
            child: _buildScrollableContent(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(48, 8, 48, 32),
          child: _buildStartButton(),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(48.0),
                child: _buildScrollableContent(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(48, 8, 48, 48),
              child: _buildStartButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return Column(
      children: [
        _buildLogo(),
        const SizedBox(height: 32),
        _buildWelcomeTitle(),
        const SizedBox(height: 20),
        _buildSubtitle(),
        const SizedBox(height: 28),
        _buildDescription(),
        const SizedBox(height: 28),
        _buildFeaturesList(),
        const SizedBox(height: 16), // Extra bottom padding for scroll
      ],
    );
  }

  Widget _buildLogo() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive logo size
        final screenWidth = MediaQuery.of(context).size.width;
        final logoSize = screenWidth < 768 ? 100.0 : 140.0;
        final iconSize = screenWidth < 768 ? 50.0 : 70.0;
        
        return Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                DarkTheme.primaryPurple,
                DarkTheme.primaryPurpleLight,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(logoSize / 2),
            boxShadow: [
              BoxShadow(
                color: DarkTheme.primaryPurple.withOpacity(0.3),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.restaurant_menu_rounded,
            color: DarkTheme.textPrimary,
            size: iconSize,
          ),
        );
      },
    );
  }

  Widget _buildWelcomeTitle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final fontSize = screenWidth < 768 ? 28.0 : 36.0;
        
        return Text(
          'Bienvenido a KazeRest',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: DarkTheme.textPrimary,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }

  Widget _buildSubtitle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final fontSize = screenWidth < 768 ? 18.0 : 20.0;
        
        return Text(
          'Evaluación de Software para Restaurantes',
          style: TextStyle(
            fontSize: fontSize,
            color: DarkTheme.primaryPurpleLight,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: DarkTheme.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: DarkTheme.borderLight,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Text(
        'Te invitamos a participar en una breve encuesta sobre las necesidades de software para tu restaurante.\n\nEsta evaluación nos ayudará a entender mejor cómo podemos optimizar las operaciones de tu negocio y mejorar la experiencia de tus clientes.',
        style: TextStyle(
          fontSize: 18,
          color: DarkTheme.textSecondary,
          height: 1.7,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {
        'icon': Icons.access_time_rounded,
        'text': 'Solo toma 5-7 minutos completar',
      },
      {
        'icon': Icons.privacy_tip_rounded,
        'text': 'Tus datos están completamente seguros',
      },
      {
        'icon': Icons.local_offer_rounded,
        'text': 'Recibirás una propuesta personalizada',
      },
    ];

    return Column(
      children: features.map((feature) => 
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: DarkTheme.primaryPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: DarkTheme.primaryPurpleLight,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  feature['text'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    color: DarkTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildStartButton() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            DarkTheme.primaryPurple,
            DarkTheme.primaryPurpleLight,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: DarkTheme.primaryPurple.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          _startQuestionnaire();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.play_arrow_rounded,
              color: DarkTheme.textPrimary,
              size: 28,
            ),
            const SizedBox(width: 12),
            const Text(
              'Comenzar Encuesta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: DarkTheme.textPrimary,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startQuestionnaire() {
    // Navigate to the main questionnaire
    Get.offAll(() => QuestionnaireMainView());
  }
}
