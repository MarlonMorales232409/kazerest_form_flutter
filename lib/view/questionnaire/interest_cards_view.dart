import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/model/model.dart';
import 'package:kazerest_form/db_local/db_local.dart';
import 'package:kazerest_form/config/dark_theme.dart';

class InterestCardsView extends StatelessWidget {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();

  InterestCardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: DarkTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                Expanded(
                  child: _buildCardStack(),
                ),
                const SizedBox(height: 24),
                _buildActionButtons(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '¿Qué funciones te interesan?',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: DarkTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Arrastra las tarjetas para seleccionar las funciones que más te interesan para tu negocio',
          style: TextStyle(
            fontSize: 16,
            color: DarkTheme.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildProgressIndicator(),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Obx(() {
      final progress = (controller.currentCardIndex.value + 1) / systemModules.length;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${controller.currentCardIndex.value + 1} de ${systemModules.length}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: DarkTheme.primaryPurpleLight,
                ),
              ),
              Text(
                '${controller.interestedModules.length} seleccionadas',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: DarkTheme.accentGreenLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: DarkTheme.primaryPurple.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: DarkTheme.borderLight,
                valueColor: const AlwaysStoppedAnimation<Color>(DarkTheme.primaryPurple),
                minHeight: 6,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCardStack() {
    return Obx(() {
      if (controller.currentCardIndex.value >= systemModules.length) {
        return _buildCompletionCard();
      }

      return Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Third card (if available) - background
            if (controller.currentCardIndex.value + 2 < systemModules.length)
              Transform.scale(
                scale: 0.8,
                child: Transform.translate(
                  offset: const Offset(0, 20),
                  child: Opacity(
                    opacity: 0.3,
                    child: _buildModuleCard(
                      systemModules[controller.currentCardIndex.value + 2],
                      isActive: false,
                    ),
                  ),
                ),
              ),
            // Second card (if available) - middle
            if (controller.currentCardIndex.value + 1 < systemModules.length)
              _buildSecondCard(),
            // Current card with drag functionality
            _buildDraggableCard(
              systemModules[controller.currentCardIndex.value],
            ),
            // Drag indicators
            _buildDragIndicators(),
          ],
        ),
      );
    });
  }

  Widget _buildSecondCard() {
    return Obx(() {
      final dragOffset = controller.dragOffset.value;
      final nextCardOffset = dragOffset * 0.05; // More subtle movement
      final nextCardScale = 0.92 + (dragOffset.abs() * 0.0005).clamp(0.0, 0.03); // Gentler scaling
      final nextCardOpacity = 0.7 + (dragOffset.abs() * 0.001).clamp(0.0, 0.2); // Smoother opacity
      
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Smooth transition
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..scale(nextCardScale)
          ..translate(nextCardOffset, 8),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: nextCardOpacity,
          child: _buildModuleCard(
            systemModules[controller.currentCardIndex.value + 1],
            isActive: false,
          ),
        ),
      );
    });
  }

  Widget _buildModuleCard(SystemModule module, {required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      width: double.infinity,
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: isActive ? 12 : 4,
        shadowColor: DarkTheme.shadowMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: DarkTheme.cardGradient,
            border: Border.all(
              color: DarkTheme.glassBorder,
              width: 1,
            ),
            boxShadow: isActive ? [
              BoxShadow(
                color: DarkTheme.primaryPurple.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ] : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: DarkTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: DarkTheme.primaryPurple.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Módulo ${module.id}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: DarkTheme.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                module.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: DarkTheme.textPrimary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                module.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: DarkTheme.textSecondary,
                  height: 1.6,
                ),
              ),
              const Spacer(),
              _buildCardFeatures(module),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardFeatures(SystemModule module) {
    // Add some example features based on module type
    List<String> features = _getModuleFeatures(module.id);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Características principales:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: DarkTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        ...features.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  gradient: DarkTheme.greenGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.check,
                  size: 12,
                  color: DarkTheme.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  feature,
                  style: const TextStyle(
                    fontSize: 14,
                    color: DarkTheme.textMuted,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  List<String> _getModuleFeatures(String moduleId) {
    switch (moduleId) {
      case "1":
        return ["Control en tiempo real", "Gestión de mesas", "Seguimiento de pedidos"];
      case "2":
        return ["Sin contacto físico", "Actualización automática", "Fácil para clientes"];
      case "3":
        return ["Notificaciones automáticas", "Organización eficiente", "Reducción de errores"];
      case "4":
        return ["Control de stock", "Análisis de costos", "Alertas automáticas"];
      case "5":
        return ["Permisos personalizados", "Control de horarios", "Gestión de roles"];
      case "6":
        return ["Múltiples métodos de pago", "Facturación automática", "Reportes de ventas"];
      case "7":
        return ["Programa de fidelidad", "Historial de pedidos", "Reservas online"];
      case "8":
        return ["Análisis detallados", "Gráficos interactivos", "Reportes automáticos"];
      case "9":
        return ["Recomendaciones inteligentes", "Predicciones", "Automatización"];
      case "10":
        return ["Control centralizado", "Sincronización", "Gestión múltiple"];
      default:
        return ["Funcionalidad avanzada", "Fácil de usar", "Soporte incluido"];
    }
  }

  Widget _buildCompletionCard() {
    return Center(
      child: Container(
        width: double.infinity,
        height: 400,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          elevation: 12,
          shadowColor: DarkTheme.shadowMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  DarkTheme.backgroundCard,
                  DarkTheme.backgroundCardElevated,
                ],
              ),
              border: Border.all(
                color: DarkTheme.glassBorder,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: DarkTheme.accentGreen.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: DarkTheme.greenGradient,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: DarkTheme.accentGreen.withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: DarkTheme.textPrimary,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '¡Perfecto!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: DarkTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Obx(() => Text(
                  'Has seleccionado ${controller.interestedModules.length} módulos que te interesan',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: DarkTheme.textSecondary,
                    height: 1.5,
                  ),
                )),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: DarkTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: DarkTheme.primaryPurple.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => controller.goToStep(1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Continuar con Prioridades',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: DarkTheme.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Obx(() {
      if (controller.currentCardIndex.value >= systemModules.length) {
        return const SizedBox.shrink();
      }

      return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: DarkTheme.redGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: DarkTheme.accentRed.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => controller.swipeLeft(
                systemModules[controller.currentCardIndex.value],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close_rounded, size: 20, color: DarkTheme.textPrimary),
                  SizedBox(width: 8),
                  Text(
                    'No me interesa',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: DarkTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: DarkTheme.greenGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: DarkTheme.accentGreen.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => controller.swipeRight(
                systemModules[controller.currentCardIndex.value],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_rounded, size: 20, color: DarkTheme.textPrimary),
                  SizedBox(width: 8),
                  Text(
                    'Me interesa',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: DarkTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
      );
    });
  }

  Widget _buildDraggableCard(SystemModule module) {
    return Obx(() {
      final dragOffset = controller.dragOffset.value;
      final isDragging = controller.isDragging.value;
      final maxDragDistance = 150.0; // Increased for smoother feel
      
      // More subtle rotation based on drag position
      final rotation = (dragOffset / maxDragDistance) * 0.1; // Reduced rotation
      
      // Smoother scale transition
      final scale = isDragging ? 1.02 : 1.0; // Less aggressive scaling
      
      // Gentler opacity changes
      final opacity = isDragging ? 0.95 : 1.0; // Less dramatic opacity change
      
      return GestureDetector(
        onPanStart: (details) => controller.onDragStart(module),
        onPanUpdate: (details) => controller.onDragUpdate(details.delta.dx),
        onPanEnd: (details) => controller.onDragEnd(details.velocity.pixelsPerSecond.dx),
        child: AnimatedContainer(
          duration: isDragging ? Duration.zero : const Duration(milliseconds: 600), // Longer return animation
          curve: isDragging ? Curves.linear : Curves.easeOutBack, // Smoother curve
          transform: Matrix4.identity()
            ..translate(dragOffset * 0.8, 0.0) // Slightly dampened movement
            ..rotateZ(rotation)
            ..scale(scale),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300), // Longer opacity transition
            opacity: opacity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: _getShadowColor(dragOffset, isDragging),
                    blurRadius: _getShadowBlur(dragOffset, isDragging),
                    offset: Offset(0, _getShadowOffset(isDragging)),
                  ),
                ],
              ),
              child: _buildModuleCard(module, isActive: true),
            ),
          ),
        ),
      );
    });
  }

  Color _getShadowColor(double dragOffset, bool isDragging) {
    if (dragOffset.abs() > 80) {
      return dragOffset > 0 
          ? DarkTheme.accentGreen.withOpacity(0.2)
          : DarkTheme.accentRed.withOpacity(0.2);
    }
    return isDragging 
        ? DarkTheme.primaryPurple.withOpacity(0.3)
        : DarkTheme.shadowMedium;
  }

  double _getShadowBlur(double dragOffset, bool isDragging) {
    if (isDragging) return 20 + (dragOffset.abs() * 0.1);
    return 15;
  }

  double _getShadowOffset(bool isDragging) {
    return isDragging ? 12 : 8;
  }

  Widget _buildDragIndicators() {
    return Obx(() {
      final dragOffset = controller.dragOffset.value;
      final isDragging = controller.isDragging.value;
      
      if (!isDragging && dragOffset.abs() < 15) return const SizedBox.shrink(); // Higher threshold
      
      final leftOpacity = dragOffset < 0 ? (dragOffset.abs() / 150).clamp(0.0, 0.9) : 0.0; // Smoother progression
      final rightOpacity = dragOffset > 0 ? (dragOffset / 150).clamp(0.0, 0.9) : 0.0;
      
      return Positioned.fill(
        child: Row(
          children: [
            // Left indicator (Not Interested)
            Expanded(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200), // Smoother fade
                opacity: leftOpacity,
                child: Container(
                  margin: const EdgeInsets.only(right: 200), // More space for card
                  decoration: BoxDecoration(
                    gradient: _getIndicatorGradient(leftOpacity, true),
                    borderRadius: BorderRadius.circular(24), // Rounded corners
                    border: Border.all(
                      color: DarkTheme.accentRed.withOpacity(leftOpacity * 0.8),
                      width: 2,
                    ),
                    boxShadow: leftOpacity > 0.4 ? [
                      BoxShadow(
                        color: DarkTheme.accentRed.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ] : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: 1.0 + (leftOpacity * 0.3), // Gentler scaling
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        child: Icon(
                          Icons.close_rounded,
                          size: 42, // Slightly smaller
                          color: DarkTheme.textPrimary.withOpacity(leftOpacity),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          fontSize: 12 + (leftOpacity * 2), // Smoother text scaling
                          fontWeight: FontWeight.w600,
                          color: DarkTheme.textPrimary.withOpacity(leftOpacity),
                          letterSpacing: 0.5,
                        ),
                        child: const Text(
                          'NO ME\nINTERESA',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 200), // Space for the card
            // Right indicator (Interested)
            Expanded(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: rightOpacity,
                child: Container(
                  margin: const EdgeInsets.only(left: 200),
                  decoration: BoxDecoration(
                    gradient: _getIndicatorGradient(rightOpacity, false),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: DarkTheme.accentGreen.withOpacity(rightOpacity * 0.8),
                      width: 2,
                    ),
                    boxShadow: rightOpacity > 0.4 ? [
                      BoxShadow(
                        color: DarkTheme.accentGreen.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ] : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: 1.0 + (rightOpacity * 0.3),
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        child: Icon(
                          Icons.favorite_rounded,
                          size: 42,
                          color: DarkTheme.textPrimary.withOpacity(rightOpacity),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          fontSize: 12 + (rightOpacity * 2),
                          fontWeight: FontWeight.w600,
                          color: DarkTheme.textPrimary.withOpacity(rightOpacity),
                          letterSpacing: 0.5,
                        ),
                        child: const Text(
                          'ME\nINTERESA',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  LinearGradient _getIndicatorGradient(double opacity, bool isLeft) {
    if (opacity > 0.5) {
      return isLeft ? DarkTheme.redGradient : DarkTheme.greenGradient;
    }
    return LinearGradient(
      colors: isLeft 
          ? [
              DarkTheme.accentRed.withOpacity(opacity * 0.7),
              DarkTheme.accentRedLight.withOpacity(opacity * 0.7),
            ]
          : [
              DarkTheme.accentGreen.withOpacity(opacity * 0.7),
              DarkTheme.accentGreenLight.withOpacity(opacity * 0.7),
            ],
    );
  }
}
