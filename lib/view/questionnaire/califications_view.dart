import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/db_local/db_local.dart';
import 'package:kazerest_form/view/widgets/custom_button.dart';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/view/questionnaire/circular_progress_widget.dart';

class CalificationsView extends StatelessWidget {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();

  CalificationsView({Key? key}) : super(key: key);

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
      return _buildDesktopLayout();
    } else if (isTablet) {
      return _buildTabletLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MobileProgressHeader(),
          _buildHeader(),
          const SizedBox(height: 32),
          Expanded(
            child: _buildCalificationsList(),
          ),
          const SizedBox(height: 24),
          _buildNavigationButtons(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          Expanded(
            child: _buildCalificationsList(),
          ),
          const SizedBox(height: 24),
          _buildNavigationButtons(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(48.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side - Header and instructions
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 48.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDesktopHeader(),
                    const SizedBox(height: 32),
                    _buildDesktopInstructions(),
                  ],
                ),
              ),
            ),
            // Right side - Califications list
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: _buildCalificationsList(),
                  ),
                  const SizedBox(height: 24),
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: DarkTheme.backgroundCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: DarkTheme.glassBorder),
              ),
              child: IconButton(
                onPressed: () => controller.previousStep(),
                icon: const Icon(Icons.arrow_back_ios),
                style: IconButton.styleFrom(
                  foregroundColor: DarkTheme.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Califica la Importancia',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: DarkTheme.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Califica del 1 al 5 qué tan importante es cada aspecto para tu negocio. Esto nos ayudará a personalizar mejor la solución.',
          style: TextStyle(
            fontSize: 16,
            color: DarkTheme.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                DarkTheme.backgroundCard,
                DarkTheme.backgroundCardElevated,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: DarkTheme.accentAmber.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: DarkTheme.accentAmber.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: DarkTheme.amberGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.star_outline,
                  color: DarkTheme.textPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  '5 estrellas = Muy importante • 1 estrella = Poco importante',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: DarkTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalificationsList() {
    return ListView.builder(
      itemCount: califications.length,
      itemBuilder: (context, index) {
        final calification = califications[index];
        return _buildCalificationItem(calification, index);
      },
    );
  }

  Widget _buildCalificationItem(calification, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 4,
        shadowColor: DarkTheme.shadowMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: DarkTheme.cardGradient,
            border: Border.all(color: DarkTheme.glassBorder),
            boxShadow: [
              BoxShadow(
                color: _getCalificationIcon(index)['color'].withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _getCalificationIcon(index)['color'],
                          _getCalificationIcon(index)['color'].withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: _getCalificationIcon(index)['color'].withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      _getCalificationIcon(index)['icon'],
                      color: DarkTheme.textPrimary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          calification.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: DarkTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getCalificationDescription(index),
                          style: const TextStyle(
                            fontSize: 14,
                            color: DarkTheme.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildStarRating(calification.id),
              const SizedBox(height: 8),
              _buildRatingLabel(calification.id),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getCalificationIcon(int index) {
    switch (index) {
      case 0: // Facilidad de Uso
        return {'icon': Icons.touch_app, 'color': DarkTheme.primaryPurple};
      case 1: // Ahorro de Tiempo
        return {'icon': Icons.schedule, 'color': DarkTheme.accentGreen};
      case 2: // Reducción de Errores
        return {'icon': Icons.verified, 'color': DarkTheme.accentRed};
      case 3: // Mejora en Experiencia del Cliente
        return {'icon': Icons.sentiment_very_satisfied, 'color': DarkTheme.accentAmber};
      case 4: // Control de Costos
        return {'icon': Icons.savings, 'color': DarkTheme.primaryPurpleDark};
      case 5: // Análisis de Datos
        return {'icon': Icons.analytics, 'color': DarkTheme.accentCyan};
      default:
        return {'icon': Icons.star, 'color': DarkTheme.primaryPurple};
    }
  }

  String _getCalificationDescription(int index) {
    switch (index) {
      case 0:
        return "Qué tan fácil debe ser de usar para ti y tu personal";
      case 1:
        return "Importancia de automatizar tareas para ahorrar tiempo";
      case 2:
        return "Necesidad de reducir errores en pedidos y operaciones";
      case 3:
        return "Prioridad de mejorar la experiencia de tus clientes";
      case 4:
        return "Importancia de controlar y reducir costos operativos";
      case 5:
        return "Valor de tener reportes y análisis para tomar decisiones";
      default:
        return "Califica la importancia de este aspecto";
    }
  }

  Widget _buildStarRating(String calificationId) {
    return Obx(() {
      final currentRating = controller.userCalifications[calificationId] ?? 3;
      
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          final starValue = index + 1;
          return GestureDetector(
            onTap: () => controller.updateCalification(calificationId, starValue),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Container(
                  decoration: starValue <= currentRating ? BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: DarkTheme.accentAmber.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ) : null,
                  child: Icon(
                    starValue <= currentRating ? Icons.star_rounded : Icons.star_border_rounded,
                    color: starValue <= currentRating 
                        ? DarkTheme.accentAmber
                        : DarkTheme.borderMedium,
                    size: 36,
                  ),
                ),
              ),
            ),
          );
        }),
      );
    });
  }

  Widget _buildRatingLabel(String calificationId) {
    return Obx(() {
      final currentRating = controller.userCalifications[calificationId] ?? 3;
      String label = _getRatingLabel(currentRating);
      
      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _getRatingColor(currentRating).withOpacity(0.2),
                _getRatingColor(currentRating).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _getRatingColor(currentRating).withOpacity(0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: _getRatingColor(currentRating).withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _getRatingColor(currentRating),
            ),
          ),
        ),
      );
    });
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return "Poco importante";
      case 2:
        return "Algo importante";
      case 3:
        return "Importante";
      case 4:
        return "Muy importante";
      case 5:
        return "Extremadamente importante";
      default:
        return "Importante";
    }
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 1:
        return const Color(0xFFEF4444);
      case 2:
        return const Color(0xFFF97316);
      case 3:
        return const Color(0xFFF59E0B);
      case 4:
        return const Color(0xFF059669);
      case 5:
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF6B7280);
    }
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Anterior',
            onPressed: () => controller.previousStep(),
            isSecondary: true,
            icon: Icons.arrow_back,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            text: 'Continuar',
            onPressed: () => controller.nextStep(),
            icon: Icons.arrow_forward,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: DarkTheme.backgroundCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: DarkTheme.glassBorder),
              ),
              child: IconButton(
                onPressed: () => controller.previousStep(),
                icon: const Icon(Icons.arrow_back_ios),
                style: IconButton.styleFrom(
                  foregroundColor: DarkTheme.textSecondary,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Text(
                'Califica la Importancia',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: DarkTheme.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Evalúa cada aspecto según su importancia para tu negocio. Esta información nos permitirá personalizar mejor nuestra propuesta.',
          style: TextStyle(
            fontSize: 18,
            color: DarkTheme.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopInstructions() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                DarkTheme.backgroundCard,
                DarkTheme.backgroundCardElevated,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: DarkTheme.accentAmber.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: DarkTheme.accentAmber.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          DarkTheme.accentAmber,
                          DarkTheme.accentAmber.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.star_outline,
                      color: DarkTheme.textPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Escala de Calificación',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: DarkTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Utiliza la escala del 1 al 5 para calificar cada aspecto:',
                style: TextStyle(
                  fontSize: 16,
                  color: DarkTheme.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: DarkTheme.backgroundCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: DarkTheme.borderLight),
          ),
          child: Column(
            children: [
              _buildRatingLegendItem(5, 'Extremadamente importante', DarkTheme.accentGreen),
              const SizedBox(height: 8),
              _buildRatingLegendItem(4, 'Muy importante', DarkTheme.accentAmber),
              const SizedBox(height: 8),
              _buildRatingLegendItem(3, 'Moderadamente importante', DarkTheme.primaryPurple),
              const SizedBox(height: 8),
              _buildRatingLegendItem(2, 'Poco importante', DarkTheme.textMuted),
              const SizedBox(height: 8),
              _buildRatingLegendItem(1, 'No es importante', DarkTheme.accentRed),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingLegendItem(int rating, String description, Color color) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              rating.toString(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: DarkTheme.textPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: color == DarkTheme.textMuted ? DarkTheme.textMuted : DarkTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
