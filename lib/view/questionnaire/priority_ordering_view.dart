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
  final ScrollController _scrollController = ScrollController();
  final RxBool _isHeaderVisible = true.obs;
  double _previousScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final currentScrollPosition = _scrollController.position.pixels;
    const threshold = 15.0; // Threshold más alto para reducir sensibilidad

    if ((currentScrollPosition - _previousScrollPosition).abs() > threshold) {
      if (currentScrollPosition > _previousScrollPosition && currentScrollPosition > 80) {
        // Scrolling down - hide header
        if (_isHeaderVisible.value) {
          _isHeaderVisible.value = false;
        }
      } else if (currentScrollPosition < _previousScrollPosition || currentScrollPosition <= 50) {
        // Scrolling up o cerca del top - show header
        if (!_isHeaderVisible.value) {
          _isHeaderVisible.value = true;
        }
      }
      _previousScrollPosition = currentScrollPosition;
    }
  }

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
    return Column(
      children: [
        // Header animado que se oculta/muestra
        Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _isHeaderVisible.value ? null : 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isHeaderVisible.value ? 1.0 : 0.0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
              child: Column(
                children: [
                  const MobileProgressHeader(),
                  _buildHeader(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        )),
        // Contenido principal con scroll
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Column(
                      children: [
                        Obx(() => _buildPriorityList()),
                        const SizedBox(height: 24),
                        _buildNavigationButtons(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        // Header fijo para tablets
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(48.0, 24.0, 48.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
            ],
          ),
        ),
        // Contenido principal con scroll
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: Obx(() => _buildPriorityList()),
                ),
                const SizedBox(height: 24),
                _buildNavigationButtons(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
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

    final screenWidth = MediaQuery.of(Get.context!).size.width;
    final isMobile = screenWidth <= 768;

    if (isMobile) {
      // Para móvil, usamos una columna simple con gestión manual del reordenamiento
      return Column(
        children: controller.priorityModules.asMap().entries.map((entry) {
          final index = entry.key;
          final module = entry.value;
          return _buildPriorityItemMobile(module, index, context);
        }).toList(),
      );
    } else {
      // Para desktop y tablet, mantenemos ReorderableListView
      return Container(
        constraints: const BoxConstraints(maxHeight: 600),
        child: ReorderableListView.builder(
          itemCount: controller.priorityModules.length,
          onReorder: (int oldIndex, int newIndex) {
            try {
              HapticFeedback.lightImpact();
            } catch (e) {
              // Ignorar si no está disponible
            }
            controller.reorderModules(oldIndex, newIndex);
          },
          buildDefaultDragHandles: false,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          proxyDecorator: (child, index, animation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                final double animValue = Curves.easeInOut.transform(animation.value);
                final double elevation = 2.0 + (12.0 - 2.0) * animValue;
                final double scale = 1.0 + (0.05 * animValue);
                
                return Transform.scale(
                  scale: scale,
                  child: Material(
                    elevation: elevation,
                    color: Colors.transparent,
                    shadowColor: DarkTheme.primaryPurple.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: DarkTheme.primaryPurple.withOpacity(0.2 * animValue),
                            blurRadius: 15 * animValue,
                            offset: Offset(0, 5 * animValue),
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
            return _buildPriorityItem(module, index, context);
          },
        ),
      );
    }
  }

  Widget _buildPriorityItem(SystemModule module, int index, BuildContext context) {
    return ReorderableDragStartListener(
      key: Key('module_${module.id}_$index'),
      index: index,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 4, right: 4),
        child: Material(
          elevation: 2,
          shadowColor: DarkTheme.shadowMedium,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              // Pequeña animación al tocar
            },
            child: Container(
              padding: const EdgeInsets.all(20),
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
              child: Row(
                children: [
                  // Priority number con mejor diseño
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _getPriorityColor(index),
                          _getPriorityColor(index).withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(22),
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
                          fontSize: 18,
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
                        const SizedBox(height: 6),
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
                  // Área de agarre más grande y visible
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: DarkTheme.textMuted.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 20,
                          height: 3,
                          decoration: BoxDecoration(
                            color: DarkTheme.textMuted.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          width: 20,
                          height: 3,
                          decoration: BoxDecoration(
                            color: DarkTheme.textMuted.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          width: 20,
                          height: 3,
                          decoration: BoxDecoration(
                            color: DarkTheme.textMuted.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityItemMobile(SystemModule module, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 4, right: 4),
      child: Material(
        elevation: 1,
        shadowColor: DarkTheme.shadowMedium,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Mostrar opciones de reordenamiento
            _showReorderOptions(module, index);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
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
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Priority number
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getPriorityColor(index),
                        _getPriorityColor(index).withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: _getPriorityColor(index).withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
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
                      const SizedBox(height: 6),
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
                // Botones de reordenamiento
                const SizedBox(width: 12),
                Column(
                  children: [
                    if (index > 0)
                      InkWell(
                        onTap: () => _moveUp(index),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: DarkTheme.primaryPurple,
                            size: 24,
                          ),
                        ),
                      ),
                    if (index < controller.priorityModules.length - 1)
                      InkWell(
                        onTap: () => _moveDown(index),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: DarkTheme.primaryPurple,
                            size: 24,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _moveUp(int index) {
    if (index > 0) {
      try {
        HapticFeedback.lightImpact();
      } catch (e) {
        // Ignorar si no está disponible
      }
      controller.reorderModules(index, index - 1);
    }
  }

  void _moveDown(int index) {
    if (index < controller.priorityModules.length - 1) {
      try {
        HapticFeedback.lightImpact();
      } catch (e) {
        // Ignorar si no está disponible
      }
      controller.reorderModules(index, index + 1);
    }
  }

  void _showReorderOptions(SystemModule module, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: DarkTheme.cardGradient,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: DarkTheme.glassBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      module.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: DarkTheme.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Posición actual: ${index + 1}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: DarkTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (index > 0)
                ListTile(
                  leading: const Icon(Icons.arrow_upward, color: DarkTheme.primaryPurple),
                  title: const Text('Mover arriba', style: TextStyle(color: DarkTheme.textPrimary)),
                  onTap: () {
                    Navigator.pop(context);
                    _moveUp(index);
                  },
                ),
              if (index < controller.priorityModules.length - 1)
                ListTile(
                  leading: const Icon(Icons.arrow_downward, color: DarkTheme.primaryPurple),
                  title: const Text('Mover abajo', style: TextStyle(color: DarkTheme.textPrimary)),
                  onTap: () {
                    Navigator.pop(context);
                    _moveDown(index);
                  },
                ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
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
