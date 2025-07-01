import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/model/model.dart';
import 'package:kazerest_form/view/widgets/custom_button.dart';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/view/questionnaire/circular_progress_widget.dart';

class PriorityOrderingView extends StatelessWidget {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();

  PriorityOrderingView({super.key});

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
            child: Obx(() => _buildPriorityList()),
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
            child: Obx(() => _buildPriorityList()),
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
            // Right side - Priority list
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() => _buildPriorityList()),
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
          'Arrastra y ordena los módulos según su prioridad para tu negocio. El primer elemento será el más importante.',
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ReorderableListView.builder(
        itemCount: controller.priorityModules.length,
        onReorder: (int oldIndex, int newIndex) {
          controller.reorderModules(oldIndex, newIndex);
        },
        buildDefaultDragHandles: false,
        physics: const BouncingScrollPhysics(),
        proxyDecorator: (child, index, animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              final double animValue = Curves.easeInOut.transform(animation.value);
              final double elevation = 0.0 + (6.0 - 0.0) * animValue; // Manual lerp
              return Material(
                elevation: elevation,
                color: Colors.transparent,
                shadowColor: Colors.black26,
                child: child,
              );
            },
            child: child,
          );
        },
        itemBuilder: (context, index) {
          final module = controller.priorityModules[index];
          return _buildPriorityItem(module, index, context);
        },
      ),
    );
  }

  Widget _buildPriorityItem(SystemModule module, int index, BuildContext context) {
    return ReorderableDragStartListener(
      key: Key('module_${module.id}_$index'), // More unique key
      index: index,
      child: Container(
        key: ValueKey('container_${module.id}_$index'), // Add container key
        margin: const EdgeInsets.only(bottom: 8),
        child: Card(
          elevation: 4,
          shadowColor: DarkTheme.shadowMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: DarkTheme.cardGradient,
              border: Border.all(color: DarkTheme.glassBorder),
              boxShadow: [
                BoxShadow(
                  color: _getPriorityColor(index).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Priority number
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getPriorityColor(index),
                        _getPriorityColor(index).withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: _getPriorityColor(index).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
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
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        module.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: DarkTheme.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Visual indicator that card is draggable
                const SizedBox(width: 16),
                Icon(
                  Icons.drag_indicator,
                  color: DarkTheme.textMuted,
                  size: 20,
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
            icon: Icons.arrow_back_rounded,
            onPressed: () => controller.goToStep(0),
            isSecondary: true,
          ),
        ],
      ),
    );
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
                'Arrastra y suelta los elementos para reordenarlos. El primer elemento será tu máxima prioridad.',
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
}
