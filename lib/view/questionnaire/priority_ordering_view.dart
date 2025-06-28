import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/model/model.dart';
import 'package:kazerest_form/view/questionnaire/questionnaire_main_view.dart';

class PriorityOrderingView extends StatelessWidget {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();

  PriorityOrderingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
            IconButton(
              onPressed: () => controller.previousStep(),
              icon: const Icon(Icons.arrow_back_ios),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Ordena por Prioridad',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Arrastra y ordena los módulos según la importancia para tu negocio. El primer elemento será tu máxima prioridad.',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.2)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Color(0xFF6366F1),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(() => Text(
                  '${controller.priorityModules.length} módulos seleccionados para ordenar',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6366F1),
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

    return ReorderableListView.builder(
      itemCount: controller.priorityModules.length,
      onReorder: controller.reorderModules,
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            final double animValue = Curves.easeInOut.transform(animation.value);
            final double elevation = lerpDouble(0, 6, animValue);
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
    );
  }

  Widget _buildPriorityItem(SystemModule module, int index, BuildContext context) {
    return Container(
      key: ValueKey(module.id),
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Row(
            children: [
              // Priority number
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getPriorityColor(index),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      module.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Drag handle
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.drag_handle,
                  color: Color(0xFF9CA3AF),
                  size: 20,
                ),
              ),
            ],
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
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.reorder,
              color: Color(0xFF9CA3AF),
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No hay módulos para ordenar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Primero selecciona algunos módulos que te interesen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Volver a Selección',
            onPressed: () => controller.previousStep(),
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
}

// Helper function for lerp
double lerpDouble(double a, double b, double t) {
  return a + (b - a) * t;
}
