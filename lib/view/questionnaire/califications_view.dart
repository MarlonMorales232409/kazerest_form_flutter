import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/db_local/db_local.dart';
import 'package:kazerest_form/view/questionnaire/questionnaire_main_view.dart';

class CalificationsView extends StatelessWidget {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();

  CalificationsView({Key? key}) : super(key: key);

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
                child: _buildCalificationsList(),
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
                'Califica la Importancia',
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
          'Califica del 1 al 5 qué tan importante es cada aspecto para tu negocio. Esto nos ayudará a personalizar mejor la solución.',
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
            color: const Color(0xFF059669).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF059669).withOpacity(0.2)),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.star_outline,
                color: Color(0xFF059669),
                size: 20,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '5 estrellas = Muy importante • 1 estrella = Poco importante',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF059669),
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
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
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
                      color: _getCalificationIcon(index)['color'],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      _getCalificationIcon(index)['icon'],
                      color: Colors.white,
                      size: 20,
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
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getCalificationDescription(index),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() => _buildStarRating(calification.id)),
              const SizedBox(height: 8),
              Obx(() => _buildRatingLabel(calification.id)),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getCalificationIcon(int index) {
    switch (index) {
      case 0: // Facilidad de Uso
        return {'icon': Icons.touch_app, 'color': const Color(0xFF6366F1)};
      case 1: // Ahorro de Tiempo
        return {'icon': Icons.schedule, 'color': const Color(0xFF059669)};
      case 2: // Reducción de Errores
        return {'icon': Icons.verified, 'color': const Color(0xFFEF4444)};
      case 3: // Mejora en Experiencia del Cliente
        return {'icon': Icons.sentiment_very_satisfied, 'color': const Color(0xFFF59E0B)};
      case 4: // Control de Costos
        return {'icon': Icons.savings, 'color': const Color(0xFF8B5CF6)};
      case 5: // Análisis de Datos
        return {'icon': Icons.analytics, 'color': const Color(0xFF06B6D4)};
      default:
        return {'icon': Icons.star, 'color': const Color(0xFF6366F1)};
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
              child: Icon(
                starValue <= currentRating ? Icons.star : Icons.star_border,
                color: starValue <= currentRating 
                    ? const Color(0xFFFBBF24) 
                    : const Color(0xFFD1D5DB),
                size: 32,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildRatingLabel(String calificationId) {
    final currentRating = controller.userCalifications[calificationId] ?? 3;
    String label = _getRatingLabel(currentRating);
    
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _getRatingColor(currentRating).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _getRatingColor(currentRating).withOpacity(0.3),
          ),
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
}
