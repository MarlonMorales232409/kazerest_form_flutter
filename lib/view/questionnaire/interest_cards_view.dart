import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/model/model.dart';
import 'package:kazerest_form/db_local/db_local.dart';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/view/questionnaire/circular_progress_widget.dart';

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
            child: _buildCardStack(),
          ),
          const SizedBox(height: 24),
          _buildActionButtons(),
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
            child: _buildCardStack(),
          ),
          const SizedBox(height: 24),
          _buildActionButtons(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1400),
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
            // Right side - Card interaction
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: _buildCardStack(),
                  ),
                  const SizedBox(height: 24),
                  _buildActionButtons(),
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
            fontSize: 18,
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
              key: ValueKey('card_${controller.currentCardIndex.value}'),
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
      final isCardExiting = controller.isCardExiting.value;
      
      // When the main card is exiting, the second card should move up smoothly
      final nextCardOffset = isCardExiting ? 0.0 : dragOffset * 0.05;
      
      final nextCardScale = isCardExiting 
          ? 1.0  // Scale up to full size when becoming main card
          : 0.92 + (dragOffset.abs() * 0.0005).clamp(0.0, 0.03);
              
      final nextCardOpacity = isCardExiting 
          ? 1.0  // Full opacity when becoming main card
          : 0.7 + (dragOffset.abs() * 0.001).clamp(0.0, 0.2);
      
      final duration = isCardExiting 
          ? const Duration(milliseconds: 600)  // Smooth transition to main card
          : const Duration(milliseconds: 200);
      
      final curve = isCardExiting 
          ? Curves.easeOutCubic
          : Curves.easeOut;
      
      return AnimatedContainer(
        duration: duration,
        curve: curve,
        transform: Matrix4.identity()
          ..scale(nextCardScale)
          ..translate(nextCardOffset, isCardExiting ? 0 : 8),
        child: AnimatedOpacity(
          duration: duration,
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isDesktop = screenWidth > 1024;
        final cardHeight = isDesktop ? 450.0 : 400.0;
        final cardMargin = isDesktop ? 16.0 : 8.0;
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          width: double.infinity,
          height: cardHeight,
          margin: EdgeInsets.symmetric(horizontal: cardMargin),
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
                      fontSize: 18,
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
      },
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
            fontSize: 16,
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
                    fontSize: 16,
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

  Widget _buildDraggableCard(SystemModule module, {Key? key}) {
    return Obx(
      key: key,
      () {
      final dragOffset = controller.dragOffset.value;
      final isDragging = controller.isDragging.value;
      final isExiting = controller.isCardExiting.value;
      final exitDirection = controller.cardExitDirection.value;
      final maxDragDistance = 150.0;
      
      // Calculate exit animation values
      double exitTranslation = 0.0;
      double exitRotation = 0.0;
      double exitScale = 1.0;
      double exitOpacity = 1.0;
      
      if (isExiting) {
        exitTranslation = exitDirection == 'left' ? -400.0 : 400.0;
        exitRotation = exitDirection == 'left' ? -0.3 : 0.3;
        exitScale = 0.8;
        exitOpacity = 0.0;
      }
      
      // Animation values based on state
      final rotation = isExiting 
          ? exitRotation 
          : (dragOffset / maxDragDistance) * 0.1;
      
      final scale = isExiting 
          ? exitScale 
          : (isDragging ? 1.02 : 1.0);
      
      final opacity = isExiting 
          ? exitOpacity 
          : (isDragging ? 0.95 : 1.0);
      
      final translation = isExiting 
          ? exitTranslation 
          : (dragOffset * 0.8);
      
      return GestureDetector(
        onPanStart: isExiting ? null : (details) => controller.onDragStart(module),
        onPanUpdate: isExiting ? null : (details) => controller.onDragUpdate(details.delta.dx),
        onPanEnd: isExiting ? null : (details) => controller.onDragEnd(details.velocity.pixelsPerSecond.dx),
        child: AnimatedContainer(
          duration: isExiting 
              ? const Duration(milliseconds: 400)
              : isDragging 
                  ? Duration.zero 
                  : const Duration(milliseconds: 600),
          curve: isExiting 
              ? Curves.easeInBack
              : isDragging 
                  ? Curves.linear 
                  : Curves.easeOutBack,
          transform: Matrix4.identity()
            ..translate(translation, 0.0)
            ..rotateZ(rotation)
            ..scale(scale),
          child: AnimatedOpacity(
            duration: isExiting 
                ? const Duration(milliseconds: 300)
                : const Duration(milliseconds: 300),
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
    },
    );
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
      final isCardExiting = controller.isCardExiting.value;
      
      // Hide indicators during card transitions or when not dragging significantly
      if (isCardExiting || (!isDragging && dragOffset.abs() < 15)) {
        return const SizedBox.shrink();
      }
      
      final leftOpacity = dragOffset < 0 ? (dragOffset.abs() / 150).clamp(0.0, 0.9) : 0.0;
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

  Widget _buildDesktopHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '¿Qué funciones te interesan?',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: DarkTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Explora las funcionalidades de nuestro sistema y selecciona las que más se adapten a las necesidades de tu negocio.',
          style: TextStyle(
            fontSize: 18,
            color: DarkTheme.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        _buildProgressIndicator(),
      ],
    );
  }

  Widget _buildDesktopInstructions() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: DarkTheme.backgroundCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: DarkTheme.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: DarkTheme.primaryPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.swipe,
                      color: DarkTheme.textPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Cómo usar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: DarkTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInstructionItem(
                Icons.arrow_forward,
                'Arrastra hacia la derecha',
                'Si la función te interesa',
                DarkTheme.accentGreen,
              ),
              const SizedBox(height: 12),
              _buildInstructionItem(
                Icons.arrow_back,
                'Arrastra hacia la izquierda',
                'Si no te interesa',
                DarkTheme.accentRed,
              ),
              const SizedBox(height: 12),
              _buildInstructionItem(
                Icons.touch_app,
                'Toca la tarjeta',
                'Para ver más detalles',
                DarkTheme.accentAmber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Obx(() => Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                DarkTheme.accentGreen.withOpacity(0.1),
                DarkTheme.accentGreen.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: DarkTheme.accentGreen.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: DarkTheme.accentGreen,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                '${controller.interestedModules.length} Funciones',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: DarkTheme.accentGreen,
                ),
              ),
              const Text(
                'seleccionadas',
                style: TextStyle(
                  fontSize: 16,
                  color: DarkTheme.textSecondary,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildInstructionItem(IconData icon, String title, String subtitle, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: DarkTheme.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
