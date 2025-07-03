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
        decoration: const BoxDecoration(gradient: DarkTheme.backgroundGradient),
        child: SafeArea(child: _buildResponsiveLayout(context)),
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
          _buildScrollableContent(),
          const SizedBox(height: 24),
          _buildStartButton(),
          const SizedBox(height: 16),
          _buildWatermark(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 48.0,
        vertical: 32.0,
      ),
      child: Column(
        children: [
          _buildScrollableContent(),
          const SizedBox(height: 24),
          _buildStartButton(),
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
        constraints: const BoxConstraints(maxWidth: 900),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            children: [
              _buildScrollableContent(),
              const SizedBox(height: 24),
              _buildStartButton(),
              const SizedBox(height: 16),
              _buildWatermark(),
              const SizedBox(height: 32),
            ],
          ),
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
      ],
    );
  }

  Widget _buildLogo() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive logo size
        final screenWidth = MediaQuery.of(context).size.width;
        final logoSize = screenWidth < 768 ? 120.0 : 160.0;
        final iconSize = screenWidth < 768 ? 60.0 : 80.0;

        return Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [DarkTheme.primaryPurple, DarkTheme.primaryPurpleLight],
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
        final fontSize = screenWidth < 768 ? 34.0 : 42.0;

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
        border: Border.all(color: DarkTheme.borderLight, width: 1),
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
          fontSize: 20,
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < 768;
        
        if (isMobile) {
          // Layout vertical para móviles - tarjetas full width
          return Column(
            children: features.asMap().entries.map((entry) {
              final index = entry.key;
              final feature = entry.value;
              return Column(
                children: [
                  if (index > 0) const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity, // Full width en móviles
                    child: _buildFeatureItemVertical(
                      icon: feature['icon'] as IconData,
                      text: feature['text'] as String,
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        } else {
          // Layout horizontal para pantallas más grandes con espacios
          return Row(
            children: features.asMap().entries.map((entry) {
              final index = entry.key;
              final feature = entry.value;
              return [
                if (index > 0) const SizedBox(width: 24), // Espacio entre tarjetas
                Expanded(
                  child: _buildFeatureItemVertical(
                    icon: feature['icon'] as IconData,
                    text: feature['text'] as String,
                  ),
                ),
              ];
            }).expand((widgets) => widgets).toList(),
          );
        }
      },
    );
  }

  Widget _buildFeatureItemVertical({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DarkTheme.backgroundCard.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: DarkTheme.borderLight.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Contenedor del ícono con diseño moderno
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  DarkTheme.primaryPurple.withOpacity(0.1),
                  DarkTheme.primaryPurpleLight.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: DarkTheme.primaryPurple.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              size: 32,
              color: DarkTheme.primaryPurpleLight,
            ),
          ),
          const SizedBox(height: 16),
          // Texto centrado y responsive
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: DarkTheme.textSecondary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [DarkTheme.primaryPurple, DarkTheme.primaryPurpleLight],
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

  void _startQuestionnaire() {
    // Navigate to the main questionnaire
    Get.offAll(() => QuestionnaireMainView());
  }
}
