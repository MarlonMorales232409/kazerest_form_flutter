import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:kazerest_form/config/dark_theme.dart';
import 'package:kazerest_form/controller/questionnaire_controller.dart';

class CircularProgressWidget extends StatefulWidget {
  final double size;
  final bool showOnFinishScreen;
  
  const CircularProgressWidget({
    super.key,
    this.size = 80.0,
    this.showOnFinishScreen = false,
  });

  @override
  State<CircularProgressWidget> createState() => _CircularProgressWidgetState();
}

class _CircularProgressWidgetState extends State<CircularProgressWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _glowController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    
    // Pulse animation for the container
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    // Glow animation for the progress
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
    
    // Start animations
    _pulseController.repeat(reverse: true);
    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if controller exists before trying to access it
    if (!Get.isRegistered<QuestionnaireController>()) {
      // If no controller is registered, just show a static progress
      const totalSteps = 5;
      return _buildProgressWidget(0, totalSteps, 0.2);
    }
    
    final controller = Get.find<QuestionnaireController>();
    
    // Total steps (0-4 = 5 steps, finish screen is considered step 5)
    const totalSteps = 5;
    
    if (widget.showOnFinishScreen) {
      // For finish screen, no need for reactivity
      return _buildProgressWidget(totalSteps, totalSteps, 1.0);
    }
    
    return Obx(() {
      // Access the observable directly and store it
      final currentStepValue = controller.currentStep.value;
      
      // Calculate progress percentage
      double progressPercent = (currentStepValue + 1) / totalSteps;
      
      return _buildProgressWidget(currentStepValue, totalSteps, progressPercent);
    });
  }

  Widget _buildProgressWidget(int currentStep, int totalSteps, double progressPercent) {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseAnimation, _glowAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.size / 2),
              boxShadow: [
                // Outer glow effect
                BoxShadow(
                  color: DarkTheme.primaryPurple.withOpacity(_glowAnimation.value * 0.6),
                  blurRadius: 25,
                  spreadRadius: 3,
                  offset: const Offset(0, 0),
                ),
                // Inner shadow for depth
                BoxShadow(
                  color: DarkTheme.primaryPurple.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: CircularPercentIndicator(
              radius: widget.size / 2,
              lineWidth: 7.0,
              animation: true,
              animationDuration: 1500,
              percent: progressPercent,
              center: _buildCenterContent(currentStep, totalSteps),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: DarkTheme.backgroundCard.withOpacity(0.3),
              backgroundWidth: 5.0,
              // Enhanced gradient based on progress
              linearGradient: LinearGradient(
                colors: _getGradientColors(progressPercent),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              rotateLinearGradient: true,
            ),
          ),
        );
      },
    );
  }

  List<Color> _getGradientColors(double progress) {
    if (widget.showOnFinishScreen || progress >= 1.0) {
      return [
        DarkTheme.accentGreen,
        DarkTheme.accentGreen.withOpacity(0.8),
        DarkTheme.primaryPurple.withOpacity(0.3),
      ];
    } else if (progress >= 0.8) {
      final greenRatio = (progress - 0.8) * 5; // 0.0 to 1.0
      return [
        Color.lerp(DarkTheme.primaryPurple, DarkTheme.accentGreen, greenRatio)!,
        DarkTheme.primaryPurple.withOpacity(0.8),
        DarkTheme.primaryPurple.withOpacity(0.4),
      ];
    } else {
      return [
        DarkTheme.primaryPurple,
        DarkTheme.primaryPurple.withOpacity(0.8),
        DarkTheme.primaryPurple.withOpacity(0.4),
      ];
    }
  }

  Widget _buildCenterContent(int currentStep, int totalSteps) {
    if (widget.showOnFinishScreen) {
      return _buildCompletedIcon();
    }
    
    return _buildStepCounter(currentStep, totalSteps);
  }

  Widget _buildStepCounter(int currentStep, int totalSteps) {
    // For very small sizes, use a simplified layout
    if (widget.size < 60) {
      return Container(
        width: widget.size * 0.7,
        height: widget.size * 0.7,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              DarkTheme.primaryPurple.withOpacity(0.15),
              DarkTheme.primaryPurple.withOpacity(0.05),
              Colors.transparent,
            ],
            stops: const [0.0, 0.7, 1.0],
          ),
          borderRadius: BorderRadius.circular(widget.size / 4),
          border: Border.all(
            color: DarkTheme.primaryPurple.withOpacity(0.3),
            width: 1.0,
          ),
        ),
        child: Center(
          child: Text(
            '${currentStep + 1}',
            style: TextStyle(
              fontSize: widget.size * 0.3,
              fontWeight: FontWeight.bold,
              color: DarkTheme.primaryPurple,
            ),
          ),
        ),
      );
    }
    
    return Container(
      width: widget.size * 0.65, // Slightly larger
      height: widget.size * 0.65, // Slightly larger
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            DarkTheme.primaryPurple.withOpacity(0.15),
            DarkTheme.primaryPurple.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
        borderRadius: BorderRadius.circular(widget.size / 4),
        border: Border.all(
          color: DarkTheme.primaryPurple.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: DarkTheme.primaryPurple.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Add this to prevent overflow
        children: [
          Text(
            '${currentStep + 1}',
            style: TextStyle(
              fontSize: widget.size * 0.26, // Slightly smaller font
              fontWeight: FontWeight.bold,
              color: DarkTheme.primaryPurple,
              shadows: [
                Shadow(
                  color: DarkTheme.primaryPurple.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          Container(
            width: widget.size * 0.16, // Slightly smaller
            height: 1.0, // Reduced height
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  DarkTheme.primaryPurple.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 1), // Reduced spacing
          Text(
            '$totalSteps',
            style: TextStyle(
              fontSize: widget.size * 0.14, // Slightly smaller font
              fontWeight: FontWeight.w500,
              color: DarkTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedIcon() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1200),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Transform.rotate(
            angle: value * 2 * 3.14159, // 360 degrees rotation
            child: Container(
              width: widget.size * 0.6,
              height: widget.size * 0.6,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    DarkTheme.accentGreen,
                    DarkTheme.accentGreen.withOpacity(0.8),
                    DarkTheme.accentGreen.withOpacity(0.6),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
                borderRadius: BorderRadius.circular(widget.size / 4),
                boxShadow: [
                  BoxShadow(
                    color: DarkTheme.accentGreen.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                  BoxShadow(
                    color: DarkTheme.accentGreen.withOpacity(0.3),
                    blurRadius: 25,
                    spreadRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Icon(
                Icons.check_rounded,
                color: DarkTheme.textPrimary,
                size: widget.size * 0.35,
                shadows: [
                  Shadow(
                    color: DarkTheme.backgroundPrimary.withOpacity(0.5),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PositionedCircularProgress extends StatelessWidget {
  final bool showOnFinishScreen;
  
  const PositionedCircularProgress({
    super.key,
    this.showOnFinishScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;
    
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    final isMobile = screenWidth <= 768;
    
    // On mobile, don't show the overlapping progress indicator
    // Instead, we'll integrate it into the layout
    if (isMobile) {
      return const SizedBox.shrink();
    }
    
    // Responsive sizing with safe area considerations for tablet and desktop
    double size = 70.0;
    double topOffset = 20.0 + padding.top;
    double rightOffset = 20.0;
    
    if (isDesktop) {
      size = 90.0;
      topOffset = 30.0 + padding.top;
      rightOffset = 30.0;
    } else if (isTablet) {
      size = 80.0;
      topOffset = 25.0 + padding.top;
      rightOffset = 25.0;
    }
    
    // Ensure the progress indicator fits within screen bounds
    if (topOffset + size > screenHeight - 20) {
      topOffset = screenHeight - size - 20;
    }
    
    return Positioned(
      top: topOffset,
      right: rightOffset,
      child: CircularProgressWidget(
        size: size,
        showOnFinishScreen: showOnFinishScreen,
      ),
    );
  }
}

// New widget for integrated mobile progress
class MobileProgressHeader extends StatelessWidget {
  final bool showOnFinishScreen;
  
  const MobileProgressHeader({
    super.key,
    this.showOnFinishScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768;
    
    // Only show on mobile devices
    if (!isMobile) {
      return const SizedBox.shrink();
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            DarkTheme.backgroundCard.withOpacity(0.8),
            DarkTheme.backgroundCardElevated.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: DarkTheme.primaryPurple.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: DarkTheme.primaryPurple.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // App title/step info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: DarkTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.assessment_rounded,
                        color: DarkTheme.textPrimary,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'KazeRest Form',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: DarkTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
                if (!showOnFinishScreen) ...[
                  const SizedBox(height: 8),
                  _buildStepInfo(),
                ] else ...[
                  const SizedBox(height: 4),
                  const Text(
                    'Evaluación Completada',
                    style: TextStyle(
                      fontSize: 14,
                      color: DarkTheme.accentGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Compact progress indicator
          CircularProgressWidget(
            size: 50,
            showOnFinishScreen: showOnFinishScreen,
          ),
        ],
      ),
    );
  }

  Widget _buildStepInfo() {
    if (!Get.isRegistered<QuestionnaireController>()) {
      return const Text(
        'Paso 1 de 5 • Evaluando producto',
        style: TextStyle(
          fontSize: 13,
          color: DarkTheme.textSecondary,
        ),
      );
    }
    
    final controller = Get.find<QuestionnaireController>();
    
    return Obx(() {
      final currentStep = controller.currentStep.value;
      String stepName = _getStepName(currentStep);
      
      return Text(
        'Paso ${currentStep + 1} de 5 • $stepName',
        style: const TextStyle(
          fontSize: 13,
          color: DarkTheme.textSecondary,
        ),
      );
    });
  }
  
  String _getStepName(int step) {
    switch (step) {
      case 0:
        return 'Módulos de Interés';
      case 1:
        return 'Prioridad de Módulos';
      case 2:
        return 'Calificaciones';
      case 3:
        return 'Importancia de Categorías';
      case 4:
        return 'Datos del Usuario';
      default:
        return 'Evaluando producto';
    }
  }
}
