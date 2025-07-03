import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/model/model.dart';
import 'package:kazerest_form/view/widgets/custom_button.dart';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/view/questionnaire/circular_progress_widget.dart';

class PriorityOrderingView extends StatefulWidget {
  const PriorityOrderingView({super.key});

  @override
  State<PriorityOrderingView> createState() => _PriorityOrderingViewState();
}

class _PriorityOrderingViewState extends State<PriorityOrderingView> {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: DarkTheme.backgroundGradient,
        ),
        child: _buildResponsiveLayout(context),
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
    return SafeArea(
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          // Header que se mueve con el scroll
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  const MobileProgressHeader(),
                  const SizedBox(height: 32),
                  _buildHeader(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          // Priority list que mantiene drag and drop
          Obx(() => controller.priorityModules.isEmpty 
            ? SliverToBoxAdapter(child: _buildEmptyState())
            : SliverReorderableList(
                itemCount: controller.priorityModules.length,
                onReorder: (int oldIndex, int newIndex) {
                  try {
                    HapticFeedback.lightImpact();
                  } catch (e) {
                    // Ignorar si no está disponible
                  }
                  controller.reorderModules(oldIndex, newIndex);
                },
                proxyDecorator: (child, index, animation) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget? child) {
                      final double animValue = Curves.easeInOut.transform(animation.value);
                      final double elevation = 4.0 + (16.0 - 4.0) * animValue;
                      final double scale = 1.0 + (0.08 * animValue);
                      
                      return Transform.scale(
                        scale: scale,
                        child: Material(
                          elevation: elevation,
                          color: Colors.transparent,
                          shadowColor: DarkTheme.primaryPurple.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: DarkTheme.primaryPurple.withOpacity(0.3 * animValue),
                                  blurRadius: 20 * animValue,
                                  offset: Offset(0, 8 * animValue),
                                ),
                              ],
                            ),
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: child,
                  );
                },
                itemBuilder: (context, index) {
                  final module = controller.priorityModules[index];
                  return Container(
                    key: Key('module_${module.id}_$index'),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _buildDraggablePriorityItem(module, index, context),
                  );
                },
              ),
          ),
          // Navigation buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _buildNavigationButtons(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(48.0, 24.0, 48.0, 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            Obx(() => controller.priorityModules.isEmpty 
              ? _buildEmptyState()
              : _buildPriorityList()),
            const SizedBox(height: 24),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return SafeArea(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
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
                // Right side - Priority list
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Obx(() => controller.priorityModules.isEmpty 
                        ? _buildEmptyState()
                        : _buildDesktopPriorityList()),
                      const SizedBox(height: 24),
                      _buildNavigationButtons(),
                    ],
                  ),
                ),
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
          'Prioriza los Módulos de Software',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: DarkTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Arrastra desde el área "Arrastrar aquí" en el lado derecho de cada tarjeta para cambiar el orden. El primer elemento será el más importante.',
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
            border: Border.all(color: DarkTheme.primaryPurple.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: DarkTheme.primaryPurple.withOpacity(0.1),
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
                  gradient: DarkTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: DarkTheme.textPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(() => Text(
                  '${controller.priorityModules.length} módulos seleccionados para ordenar',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: DarkTheme.textSecondary,
                  ),
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriorityList() {
    if (controller.priorityModules.isEmpty) {
      return _buildEmptyState();
    }

    // For tablet layout - with drag and drop functionality
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.priorityModules.length,
        buildDefaultDragHandles: false,
        onReorder: (int oldIndex, int newIndex) {
          try {
            HapticFeedback.lightImpact();
          } catch (e) {
            // Ignore if not available
          }
          controller.reorderModules(oldIndex, newIndex);
        },
        proxyDecorator: (child, index, animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              final double animValue = Curves.easeInOut.transform(animation.value);
              final double elevation = 4.0 + (16.0 - 4.0) * animValue;
              final double scale = 1.0 + (0.08 * animValue);
              
              return Transform.scale(
                scale: scale,
                child: Material(
                  elevation: elevation,
                  color: Colors.transparent,
                  shadowColor: DarkTheme.primaryPurple.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: DarkTheme.primaryPurple.withOpacity(0.3 * animValue),
                          blurRadius: 20 * animValue,
                          offset: Offset(0, 8 * animValue),
                        ),
                      ],
                    ),
                    child: child,
                  ),
                ),
              );
            },
            child: child,
          );
        },
        itemBuilder: (context, index) {
          final module = controller.priorityModules[index];
          return Container(
            key: Key('module_${module.id}_$index'),
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildDraggablePriorityItem(module, index, context),
          );
        },
      ),
    );
  }

  Widget _buildDraggablePriorityItem(SystemModule module, int index, BuildContext context) {
    return Container(
      key: Key('module_${module.id}_$index'),
      margin: const EdgeInsets.only(bottom: 16, left: 4, right: 4),
      child: Material(
        elevation: 2,
        shadowColor: DarkTheme.shadowMedium,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: DarkTheme.cardGradient,
            border: Border.all(
              color: DarkTheme.glassBorder,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _getPriorityColor(index).withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Contenido principal (no draggable)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // Priority number
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                _getPriorityColor(index),
                                _getPriorityColor(index).withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: _getPriorityColor(index).withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: DarkTheme.textPrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Module content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                module.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: DarkTheme.textPrimary,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                module.description,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: DarkTheme.textSecondary,
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Drag handle area (solo esta parte es draggable)
                ReorderableDragStartListener(
                  index: index,
                  child: Container(
                    width: 80,
                    height: double.infinity, // Now this will work with IntrinsicHeight
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          DarkTheme.primaryPurple.withOpacity(0.1),
                          DarkTheme.primaryPurple.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      border: Border(
                        left: BorderSide(
                          color: DarkTheme.primaryPurple.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.drag_indicator,
                          color: DarkTheme.primaryPurple,
                          size: 28,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Arrastrar',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: DarkTheme.primaryPurple,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'aquí',
                          style: TextStyle(
                            fontSize: 10,
                            color: DarkTheme.primaryPurple.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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

  Color _getPriorityColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFEF4444); // Red for highest priority
      case 1:
        return const Color(0xFFF97316); // Orange
      case 2:
        return const Color(0xFFF59E0B); // Amber
      default:
        return const Color(0xFF6366F1); // Purple for others
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  DarkTheme.backgroundCard,
                  DarkTheme.backgroundCardElevated,
                ],
              ),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: DarkTheme.borderLight),
            ),
            child: const Icon(
              Icons.reorder,
              color: DarkTheme.textMuted,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No hay módulos para ordenar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: DarkTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Primero debes seleccionar al menos un módulo que te interese.\nTotal de módulos interesados: ${controller.interestedModules.length}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: DarkTheme.textMuted,
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Volver a Selección de Módulos',
            onPressed: () => controller.goToStep(0),
            isSecondary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600; // Breakpoint más estricto para móvil
    
    if (isMobile) {
      // Columna de botones para móvil - ahora centrada y parte del scroll
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton(
            text: 'Anterior',
            onPressed: () => controller.previousStep(),
            isSecondary: true,
            icon: Icons.arrow_back,
          ),
          const SizedBox(height: 12),
          Obx(() => CustomButton(
            text: 'Continuar',
            onPressed: controller.priorityModules.isNotEmpty 
                ? () => controller.nextStep() 
                : null,
            isEnabled: controller.priorityModules.isNotEmpty,
            icon: Icons.arrow_forward,
          )),
        ],
      );
    } else {
      // Fila de botones para tablet y desktop ocupando todo el ancho
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
          const SizedBox(width: 12),
          Expanded(
            child: Obx(() => CustomButton(
              text: 'Continuar',
              onPressed: controller.priorityModules.isNotEmpty 
                  ? () => controller.nextStep() 
                  : null,
              isEnabled: controller.priorityModules.isNotEmpty,
              icon: Icons.arrow_forward,
            )),
          ),
        ],
      );
    }
  }

  Widget _buildDesktopHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prioriza los Módulos de Software',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: DarkTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Organiza los módulos según su prioridad para tu negocio. Esta información nos ayudará a personalizar mejor nuestra propuesta.',
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
            border: Border.all(color: DarkTheme.primaryPurple.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: DarkTheme.primaryPurple.withOpacity(0.1),
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
                      gradient: DarkTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      color: DarkTheme.textPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Instrucciones',
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
                'Arrastra desde el área "Arrastrar aquí" en el lado derecho de cada tarjeta para reordenar. El primer elemento será tu máxima prioridad.',
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
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Máxima Prioridad',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: DarkTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF97316),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Alta Prioridad',
                    style: TextStyle(
                      fontSize: 14,
                      color: DarkTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF59E0B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Prioridad Media',
                    style: TextStyle(
                      fontSize: 14,
                      color: DarkTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6366F1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Prioridad Estándar',
                    style: TextStyle(
                      fontSize: 14,
                      color: DarkTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopPriorityList() {
    // Desktop priority list with drag and drop functionality
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.priorityModules.length,
        buildDefaultDragHandles: false,
        onReorder: (int oldIndex, int newIndex) {
          try {
            HapticFeedback.lightImpact();
          } catch (e) {
            // Ignore if not available
          }
          controller.reorderModules(oldIndex, newIndex);
        },
        proxyDecorator: (child, index, animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              final double animValue = Curves.easeInOut.transform(animation.value);
              final double elevation = 4.0 + (16.0 - 4.0) * animValue;
              final double scale = 1.0 + (0.08 * animValue);
              
              return Transform.scale(
                scale: scale,
                child: Material(
                  elevation: elevation,
                  color: Colors.transparent,
                  shadowColor: DarkTheme.primaryPurple.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: DarkTheme.primaryPurple.withOpacity(0.3 * animValue),
                          blurRadius: 20 * animValue,
                          offset: Offset(0, 8 * animValue),
                        ),
                      ],
                    ),
                    child: child,
                  ),
                ),
              );
            },
            child: child,
          );
        },
        itemBuilder: (context, index) {
          final module = controller.priorityModules[index];
          return Container(
            key: Key('module_${module.id}_$index'),
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildDraggablePriorityItem(module, index, context),
          );
        },
      ),
    );
  }
}
