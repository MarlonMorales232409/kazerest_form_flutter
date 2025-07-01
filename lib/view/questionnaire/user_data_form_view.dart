import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';
import 'package:kazerest_form/view/questionnaire/finish_screen_view.dart';
import 'package:kazerest_form/view/widgets/custom_button.dart';
import 'package:kazerest_form/config/firebase_service.dart';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/view/questionnaire/circular_progress_widget.dart';

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
            child: _buildForm(),
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
            child: _buildForm(),
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
            // Left side - Header and info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 48.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDesktopHeader(),
                    const SizedBox(height: 32),
                    _buildDesktopSideInfo(),
                  ],
                ),
              ),
            ),
            // Right side - Form
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: _buildDesktopForm(),
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
            fontSize: 18,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    
    return Card(
      elevation: 2,
      shadowColor: DarkTheme.shadowMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(isDesktop ? 20 : 24),
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 16),
            _buildTextFormField(
              label: 'Teléfono de la oficina *',
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
            const SizedBox(height: 16),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    
    return Card(
      elevation: 2,
      shadowColor: DarkTheme.shadowMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(isDesktop ? 20 : 24),
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
            const SizedBox(height: 20),
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

  Widget _buildNavigationButtons() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    
    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: CustomButton(
              text: 'Anterior',
              onPressed: () => controller.previousStep(),
              isSecondary: true,
              icon: Icons.arrow_back,
            ),
          ),
          SizedBox(
            width: 250,
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
           controller.businessName.value.isNotEmpty;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSubmissionDialog();
    }
  }

  void _showSubmissionDialog() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 500 : double.infinity,
          ),
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
                    // Navigate to finish screen instead of going back
                    Get.offAll(() => const FinishScreenView());
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

  Widget _buildDesktopHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => controller.previousStep(),
          icon: const Icon(Icons.arrow_back_ios),
          style: IconButton.styleFrom(
            backgroundColor: DarkTheme.backgroundCard,
            foregroundColor: DarkTheme.textSecondary,
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Información de Contacto',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: DarkTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Para finalizar, compártenos tus datos de contacto. Te enviaremos una propuesta personalizada basada en tus respuestas.',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF6B7280),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopSideInfo() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Color(0xFF10B981),
                    size: 24,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Datos Seguros',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Tus datos están seguros y solo se usarán para contactarte con una propuesta personalizada.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF10B981),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: DarkTheme.backgroundCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: DarkTheme.borderLight),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: DarkTheme.primaryPurple,
                    size: 24,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Respuesta Rápida',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: DarkTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Nuestro equipo te contactará en menos de 24 horas con una propuesta adaptada a tu negocio.',
                style: TextStyle(
                  fontSize: 16,
                  color: DarkTheme.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildPersonalInfoSection()),
              const SizedBox(width: 24),
              Expanded(child: _buildBusinessInfoSection()),
            ],
          ),
          const SizedBox(height: 32),
          _buildAdditionalInfoSection(),
        ],
      ),
    );
  }
}
