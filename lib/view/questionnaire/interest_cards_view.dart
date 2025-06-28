import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/model/model.dart';
import 'package:kazerest_form/db_local/db_local.dart';

class InterestCardsView extends StatelessWidget {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();

  InterestCardsView({Key? key}) : super(key: key);

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
                child: Obx(() => _buildCardStack()),
              ),
              const SizedBox(height: 24),
              _buildActionButtons(),
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
        const Text(
          '¿Qué funciones te interesan?',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Desliza las tarjetas para seleccionar las funciones que más te interesan para tu negocio',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Obx(() => _buildProgressIndicator()),
      ],
    );
  }

  Widget _buildProgressIndicator() {
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
                color: Color(0xFF6366F1),
              ),
            ),
            Text(
              '${controller.interestedModules.length} seleccionadas',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF059669),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildCardStack() {
    if (controller.currentCardIndex.value >= systemModules.length) {
      return _buildCompletionCard();
    }

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Next card (if available)
          if (controller.currentCardIndex.value + 1 < systemModules.length)
            Transform.scale(
              scale: 0.9,
              child: _buildModuleCard(
                systemModules[controller.currentCardIndex.value + 1],
                isActive: false,
              ),
            ),
          // Current card
          _buildModuleCard(
            systemModules[controller.currentCardIndex.value],
            isActive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(SystemModule module, {required bool isActive}) {
    return Container(
      width: double.infinity,
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: isActive ? 8 : 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                const Color(0xFFF8F9FA),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Módulo ${module.id}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6366F1),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                module.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                module.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
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
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        ...features.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                size: 16,
                color: Color(0xFF059669),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  feature,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
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
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6366F1).withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF059669),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '¡Perfecto!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 12),
                Obx(() => Text(
                  'Has seleccionado ${controller.interestedModules.length} módulos que te interesan',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                )),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => controller.goToStep(1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Continuar con Prioridades',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
    if (controller.currentCardIndex.value >= systemModules.length) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () => controller.swipeLeft(
                systemModules[controller.currentCardIndex.value],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFEF4444),
                elevation: 0,
                side: const BorderSide(color: Color(0xFFEF4444), width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'No me interesa',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () => controller.swipeRight(
                systemModules[controller.currentCardIndex.value],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Me interesa',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
