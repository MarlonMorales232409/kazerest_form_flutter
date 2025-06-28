import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/view/questionnaire/questionnaire_main_view.dart';
import 'package:kazerest_form/config/firebase_service.dart';
import 'package:kazerest_form/config/dark_theme.dart';

class UserDataFormView extends StatefulWidget {
  const UserDataFormView({super.key});

  @override
  State<UserDataFormView> createState() => _UserDataFormViewState();
}

class _UserDataFormViewState extends State<UserDataFormView> {
  final QuestionnaireController controller = Get.find<QuestionnaireController>();
  final _formKey = GlobalKey<FormState>();

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
                  child: _buildForm(),
                ),
                const SizedBox(height: 24),
                _buildNavigationButtons(),
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
        Row(
          children: [
            IconButton(
              onPressed: () => controller.previousStep(),
              icon: const Icon(Icons.arrow_back_ios),
              style: IconButton.styleFrom(
                backgroundColor: DarkTheme.backgroundCard,
                foregroundColor: DarkTheme.textSecondary,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Información de Contacto',
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
          'Para finalizar, compártenos tus datos de contacto. Te enviaremos una propuesta personalizada basada en tus respuestas.',
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
            color: const Color(0xFF10B981).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.security,
                color: Color(0xFF10B981),
                size: 20,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Tus datos están seguros y solo se usarán para contactarte',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF10B981),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          _buildPersonalInfoSection(),
          const SizedBox(height: 32),
          _buildBusinessInfoSection(),
          const SizedBox(height: 32),
          _buildAdditionalInfoSection(),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Card(
      elevation: 2,
      shadowColor: DarkTheme.shadowMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: DarkTheme.backgroundCard,
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
                    Icons.person,
                    color: DarkTheme.textPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Información Personal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: DarkTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextFormField(
              label: 'Nombre completo *',
              hint: 'Ej: Juan Pérez García',
              icon: Icons.person_outline,
              onChanged: (value) => controller.userName.value = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildTextFormField(
              label: 'Teléfono *',
              hint: 'Ej: +52 55 1234 5678',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              onChanged: (value) => controller.userPhone.value = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El teléfono es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildTextFormField(
              label: 'Correo electrónico *',
              hint: 'Ej: juan@mirestaurante.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => controller.userEmail.value = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El correo es obligatorio';
                }
                if (!GetUtils.isEmail(value)) {
                  return 'Ingresa un correo válido';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessInfoSection() {
    return Card(
      elevation: 2,
      shadowColor: DarkTheme.shadowMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: DarkTheme.backgroundCard,
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
                    color: DarkTheme.accentGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.business,
                    color: DarkTheme.textPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Información del Negocio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: DarkTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextFormField(
              label: 'Nombre del negocio *',
              hint: 'Ej: Restaurante La Delicia',
              icon: Icons.store_outlined,
              onChanged: (value) => controller.businessName.value = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre del negocio es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildDropdownField(
              label: 'Tu cargo en el negocio *',
              hint: 'Selecciona tu rol',
              icon: Icons.work_outline,
              items: const [
                'Propietario',
                'Gerente General',
                'Gerente de Operaciones',
                'Chef / Jefe de Cocina',
                'Administrador',
                'Encargado de Sistemas',
                'Otro',
              ],
              onChanged: (value) => controller.userRole.value = value ?? '',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Selecciona tu cargo';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Card(
      elevation: 2,
      shadowColor: DarkTheme.shadowMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: DarkTheme.backgroundCard,
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
                    color: DarkTheme.accentAmber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.comment,
                    color: DarkTheme.textPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Información Adicional',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: DarkTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextFormField(
              label: 'Comentarios o necesidades especiales',
              hint: 'Cuéntanos algo más sobre tu negocio o necesidades específicas...',
              icon: Icons.message_outlined,
              maxLines: 4,
              onChanged: (value) => controller.comments.value = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: DarkTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          validator: validator,
          style: const TextStyle(color: DarkTheme.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: DarkTheme.textMuted,
              size: 20,
            ),
            filled: true,
            fillColor: DarkTheme.backgroundCardElevated,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.primaryPurple, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.error, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.error, width: 2),
            ),
            hintStyle: const TextStyle(
              color: DarkTheme.textMuted,
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: DarkTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: DarkTheme.textMuted,
              size: 20,
            ),
            filled: true,
            fillColor: DarkTheme.backgroundCardElevated,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.primaryPurple, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.error, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: DarkTheme.error, width: 2),
            ),
            hintStyle: const TextStyle(
              color: DarkTheme.textMuted,
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          dropdownColor: DarkTheme.backgroundCard,
          style: const TextStyle(color: DarkTheme.textPrimary),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(color: DarkTheme.textPrimary),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
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
            text: 'Enviar Evaluación',
            onPressed: _canSubmit() ? _submitForm : null,
            isEnabled: _canSubmit(),
            icon: Icons.send,
          )),
        ),
      ],
    );
  }

  bool _canSubmit() {
    return controller.userName.value.isNotEmpty &&
           controller.userEmail.value.isNotEmpty &&
           controller.userPhone.value.isNotEmpty &&
           controller.businessName.value.isNotEmpty &&
           controller.userRole.value.isNotEmpty;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSubmissionDialog();
    }
  }

  void _showSubmissionDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: DarkTheme.backgroundCard,
            border: Border.all(color: DarkTheme.borderLight),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: DarkTheme.accentGreen,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.check,
                  color: DarkTheme.textPrimary,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '¡Evaluación Completada!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: DarkTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Gracias por completar la evaluación. Hemos recibido tus respuestas y te contactaremos pronto con una propuesta personalizada.',
                style: TextStyle(
                  fontSize: 16,
                  color: DarkTheme.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    final userAnswer = controller.buildUserAnswer();
                    
                    // Guardar en Firebase
                    final firebaseService = FirebaseService();
                    final savedId = await firebaseService.saveUserAnswer(userAnswer);
                    
                    if (savedId != null) {
                      print('✅ Respuesta guardada en Firebase con ID: $savedId');
                    } else {
                      print('❌ Error al guardar en Firebase');
                    }
                    
                    Get.back(); // Close dialog
                    Get.back(); // Go back to previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DarkTheme.primaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cerrar',
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
    );
  }
}
