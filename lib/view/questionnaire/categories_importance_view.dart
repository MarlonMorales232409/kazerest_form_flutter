import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/db_local/db_local.dart';
import 'package:kazerest_form/view/widgets/custom_button.dart';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/view/questionnaire/circular_progress_widget.dart';

class CategoriesImportanceView extends StatelessWidget {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();

  CategoriesImportanceView({Key? key}) : super(key: key);

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
            child: _buildCategoriesList(),
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
            child: _buildCategoriesList(),
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
            // Right side - Categories list
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: _buildCategoriesList(),
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
                'Ventajas Tecnológicas',
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
          'Evalúa qué beneficios tecnológicos son más importantes para tu negocio. Usa el deslizador de 0 a 10.',
          style: TextStyle(
            fontSize: 18,
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
            border: Border.all(color: DarkTheme.accentCyan.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: DarkTheme.accentCyan.withOpacity(0.1),
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
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      DarkTheme.accentCyan,
                      DarkTheme.accentCyanLight,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.tune,
                  color: DarkTheme.textPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  '0 = Sin importancia • 10 = Máxima importancia',
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
                'Ventajas Tecnológicas',
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
          'Ajusta el nivel de importancia de cada categoría tecnológica para tu negocio. Esta información nos ayudará a enfocar nuestra propuesta.',
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
            border: Border.all(color: DarkTheme.accentCyan.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: DarkTheme.accentCyan.withOpacity(0.1),
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
                          DarkTheme.accentCyan,
                          DarkTheme.accentCyan.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: DarkTheme.textPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Cómo usar los controles',
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
                'Usa el deslizador para establecer el nivel de importancia de cada categoría (0-10). Mayor valor significa mayor importancia.',
                style: TextStyle(
                  fontSize: 16,
                  color: DarkTheme.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: DarkTheme.backgroundCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: DarkTheme.borderLight),
          ),
          child: Column(
            children: [
              _buildImportanceLegendItem(9, 10, 'Crítico', DarkTheme.accentRed),
              const SizedBox(height: 8),
              _buildImportanceLegendItem(7, 8, 'Muy importante', DarkTheme.accentAmber),
              const SizedBox(height: 8),
              _buildImportanceLegendItem(5, 6, 'Importante', DarkTheme.accentGreen),
              const SizedBox(height: 8),
              _buildImportanceLegendItem(3, 4, 'Moderadamente importante', DarkTheme.primaryPurple),
              const SizedBox(height: 8),
              _buildImportanceLegendItem(0, 2, 'Poco importante', DarkTheme.textMuted),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImportanceLegendItem(int minValue, int maxValue, String description, Color color) {
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
              minValue == maxValue ? minValue.toString() : '$minValue-$maxValue',
              style: const TextStyle(
                fontSize: 10,
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

  Widget _buildCategoriesList() {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryItem(category, index);
      },
    );
  }

  Widget _buildCategoryItem(category, int index) {
    return Obx(() {
      final categoryImportance = controller.categoryImportances
          .firstWhere((ci) => ci.id == category.id);
      
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Card(
          elevation: 2,
          shadowColor: DarkTheme.shadowMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: DarkTheme.cardGradient,
              border: Border.all(
                color: DarkTheme.glassBorder,
                width: 1,
              ),
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
                        color: _getCategoryColor(index),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        _getCategoryIcon(index),
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
                            category.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: DarkTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getCategoryDescription(index),
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
                const SizedBox(height: 24),
                _buildImportanceSlider(category.id),
                const SizedBox(height: 12),
                _buildImportanceLabel(categoryImportance.value),
              ],
            ),
          ),
        ),
      );
    });
  }

  IconData _getCategoryIcon(int index) {
    switch (index) {
      case 0: // Tecnología Móvil
        return Icons.smartphone;
      case 1: // Automatización
        return Icons.precision_manufacturing;
      case 2: // Reportes y Analytics
        return Icons.bar_chart;
      case 3: // Integración con Sistemas Existentes
        return Icons.sync;
      case 4: // Soporte Técnico
        return Icons.support_agent;
      case 5: // Capacitación del Personal
        return Icons.school;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFF6366F1); // Purple
      case 1:
        return const Color(0xFF059669); // Green
      case 2:
        return const Color(0xFFF59E0B); // Amber
      case 3:
        return const Color(0xFFEF4444); // Red
      case 4:
        return const Color(0xFF8B5CF6); // Violet
      case 5:
        return const Color(0xFF06B6D4); // Cyan
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }

  String _getCategoryDescription(int index) {
    switch (index) {
      case 0:
        return "Apps móviles, códigos QR, tecnología para dispositivos móviles";
      case 1:
        return "Procesos automáticos, flujos de trabajo sin intervención manual";
      case 2:
        return "Análisis de datos, reportes de ventas, métricas de negocio";
      case 3:
        return "Conexión con sistemas que ya tienes en tu negocio";
      case 4:
        return "Ayuda técnica, mantenimiento, resolución de problemas";
      case 5:
        return "Entrenamiento para tu equipo, material de capacitación";
      default:
        return "Funcionalidades generales del sistema";
    }
  }

  Widget _buildImportanceSlider(String categoryId) {
    return Obx(() {
      final categoryImportance = controller.categoryImportances
          .firstWhere((ci) => ci.id == categoryId);
      final currentValue = categoryImportance.value;
      
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '0',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: DarkTheme.textMuted,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getSliderColor(currentValue).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _getSliderColor(currentValue).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  '$currentValue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _getSliderColor(currentValue),
                  ),
                ),
              ),
              const Text(
                '10',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: DarkTheme.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Builder(
            builder: (context) => SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 6,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                activeTrackColor: _getSliderColor(currentValue),
                inactiveTrackColor: DarkTheme.borderLight,
                thumbColor: _getSliderColor(currentValue),
                overlayColor: _getSliderColor(currentValue).withOpacity(0.2),
              ),
              child: Slider(
                value: currentValue.toDouble(),
                min: 0,
                max: 10,
                divisions: 10,
                onChanged: (value) {
                  controller.updateCategoryImportance(categoryId, value);
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Color _getSliderColor(int value) {
    if (value <= 2) return const Color(0xFFEF4444); // Red
    if (value <= 4) return const Color(0xFFF97316); // Orange
    if (value <= 6) return const Color(0xFFF59E0B); // Amber
    if (value <= 8) return const Color(0xFF059669); // Green
    return const Color(0xFF10B981); // Emerald
  }

  Widget _buildImportanceLabel(int value) {
    String label = _getImportanceLabel(value);
    
    return Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _getSliderColor(value),
        ),
      ),
    );
  }

  String _getImportanceLabel(int value) {
    switch (value) {
      case 0:
        return "Sin importancia";
      case 1:
      case 2:
        return "Poca importancia";
      case 3:
      case 4:
        return "Algo importante";
      case 5:
      case 6:
        return "Importante";
      case 7:
      case 8:
        return "Muy importante";
      case 9:
      case 10:
        return "Extremadamente importante";
      default:
        return "Importante";
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
}
