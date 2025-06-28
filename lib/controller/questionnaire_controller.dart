import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:kazerest_form/model/model.dart';
import 'package:kazerest_form/db_local/db_local.dart';

class QuestionnaireController extends GetxController {
  // Step 1: Interest Card Slider
  var currentCardIndex = 0.obs;
  var interestedModules = <SystemModule>[].obs;
  var rejectedModules = <SystemModule>[].obs;
  var draggedModule = Rxn<SystemModule>();
  var dragDirection = ''.obs; // 'left', 'right', or ''
  var dragOffset = 0.0.obs; // Current drag position
  var isDragging = false.obs; // Whether user is currently dragging
  var isCardExiting = false.obs; // Whether card is exiting with animation
  var cardExitDirection = ''.obs; // 'left' or 'right' for exit animation
  
  // Step 2: Priority Ordering
  var priorityModules = <SystemModule>[].obs;
  
  // Step 3: Califications
  var userCalifications = <String, int>{}.obs;
  
  // Step 4: Categories Importance
  var categoryImportances = <CategoryImportance>[].obs;
  
  // Step 5: User Data
  var userName = ''.obs;
  var userPhone = ''.obs;
  var userEmail = ''.obs;
  var businessName = ''.obs;
  var userRole = ''.obs;
  var comments = ''.obs;
  
  // Navigation
  var currentStep = 0.obs;
  
  // Reset all data for new evaluation
  void resetAll() {
    // Step 1: Interest Card Slider
    currentCardIndex.value = 0;
    interestedModules.clear();
    rejectedModules.clear();
    draggedModule.value = null;
    dragDirection.value = '';
    dragOffset.value = 0.0;
    isDragging.value = false;
    isCardExiting.value = false;
    cardExitDirection.value = '';
    
    // Step 2: Priority Ordering
    priorityModules.clear();
    
    // Step 3: Califications
    userCalifications.clear();
    
    // Step 4: Categories Importance
    categoryImportances.clear();
    
    // Step 5: User Data
    userName.value = '';
    userPhone.value = '';
    userEmail.value = '';
    businessName.value = '';
    userRole.value = '';
    comments.value = '';
    
    // Navigation
    currentStep.value = 0;
    
    // Reinitialize data
    initializeCategoryImportances();
    initializeCalifications();
  }
  
  @override
  void onInit() {
    super.onInit();
    initializeCategoryImportances();
    initializeCalifications();
  }
  
  void initializeCategoryImportances() {
    categoryImportances.value = categories.map((category) => 
      CategoryImportance(
        id: category.id,
        name: category.name,
        value: 5,
        maxValue: category.maxValue,
      )
    ).toList();
  }
  
  void initializeCalifications() {
    for (var calification in califications) {
      userCalifications[calification.id] = 3; // Default rating
    }
  }
  
  // Step 1 Methods
  void swipeLeft(SystemModule module) {
    HapticFeedback.lightImpact(); // Gentler feedback
    rejectedModules.add(module);
    _animateCardExit('left');
  }
  
  void swipeRight(SystemModule module) {
    HapticFeedback.lightImpact(); // Gentler feedback
    interestedModules.add(module);
    _animateCardExit('right');
  }

  void _animateCardExit(String direction) {
    isCardExiting.value = true;
    cardExitDirection.value = direction;
    
    // Wait for exit animation to complete, then show next card
    Future.delayed(const Duration(milliseconds: 400), () {
      _proceedToNextCard();
    });
  }

  void _proceedToNextCard() {
    if (currentCardIndex.value < systemModules.length - 1) {
      // First, completely reset all drag state to ensure clean slate
      _resetDragState();
      
      // Then increment the card index - new card appears instantly
      currentCardIndex.value++;
    } else {
      _resetDragState();
      goToStep(1); // Go to priority ordering
    }
  }
  
  void onDragStart(SystemModule module) {
    draggedModule.value = module;
    dragDirection.value = '';
    dragOffset.value = 0.0;
    isDragging.value = true;
  }
  
  void onDragUpdate(double dx) {
    if (isDragging.value) {
      // Apply dampening for smoother movement
      final dampedDx = dx * 0.8;
      dragOffset.value += dampedDx;
      
      // Provide haptic feedback when crossing thresholds
      final previousDirection = dragDirection.value;
      
      // Update direction based on cumulative offset with higher thresholds for smoother experience
      if (dragOffset.value < -60) { // Increased threshold
        dragDirection.value = 'left';
        if (previousDirection != 'left') {
          HapticFeedback.selectionClick(); // Gentler haptic feedback
        }
      } else if (dragOffset.value > 60) { // Increased threshold
        dragDirection.value = 'right';
        if (previousDirection != 'right') {
          HapticFeedback.selectionClick(); // Gentler haptic feedback
        }
      } else {
        dragDirection.value = '';
      }
    }
  }
  
  void onDragEnd(double velocityX) {
    if (draggedModule.value != null && isDragging.value) {
      final threshold = 120.0; // Increased threshold for less sensitive swipes
      final shouldSwipeByVelocity = velocityX.abs() > 800; // Higher velocity threshold
      final shouldSwipeByPosition = dragOffset.value.abs() > threshold;
      
      if (shouldSwipeByVelocity || shouldSwipeByPosition) {
        if (dragOffset.value < 0 || velocityX < -800) {
          swipeLeft(draggedModule.value!);
        } else if (dragOffset.value > 0 || velocityX > 800) {
          swipeRight(draggedModule.value!);
        }
      } else {
        // Reset position if not enough to trigger swipe
        _resetDragState();
      }
    }
  }
  
  void _resetDragState() {
    draggedModule.value = null;
    dragDirection.value = '';
    dragOffset.value = 0.0;
    isDragging.value = false;
    isCardExiting.value = false;
    cardExitDirection.value = '';
  }
  
  void nextCard() {
    if (currentCardIndex.value < systemModules.length - 1) {
      currentCardIndex.value++;
    } else {
      goToStep(1); // Go to priority ordering
    }
  }
  
  // Step 2 Methods
  void reorderModules(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = priorityModules.removeAt(oldIndex);
    priorityModules.insert(newIndex, item);
    priorityModules.refresh(); // Force UI update
  }
  
  // Step 3 Methods
  void updateCalification(String calificationId, int rating) {
    userCalifications[calificationId] = rating;
  }
  
  // Step 4 Methods
  void updateCategoryImportance(String categoryId, double importance) {
    final index = categoryImportances.indexWhere((ci) => ci.id == categoryId);
    if (index != -1) {
      categoryImportances[index] = categoryImportances[index].copyWith(
        value: importance.round(),
      );
      categoryImportances.refresh();
    }
  }
  
  // Navigation Methods
  void goToStep(int step) {
    if (step == 1) {
      // Prepare priority modules from interested modules
      priorityModules.clear();
      priorityModules.addAll(interestedModules);
      priorityModules.refresh();
    }
    currentStep.value = step;
  }
  
  void nextStep() {
    if (currentStep.value < 4) {
      int nextStepValue = currentStep.value + 1;
      if (nextStepValue == 1) {
        // Prepare priority modules from interested modules
        priorityModules.clear();
        priorityModules.addAll(interestedModules);
        priorityModules.refresh();
      }
      currentStep.value = nextStepValue;
    }
  }
  
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }
  
  // Final submission
  UserAnswer buildUserAnswer() {
    final priorityMap = <String, SystemModule>{};
    for (int i = 0; i < priorityModules.length; i++) {
      priorityMap[(i + 1).toString()] = priorityModules[i];
    }
    
    final userInterests = userCalifications.entries.map((entry) {
      final calification = califications.firstWhere((c) => c.id == entry.key);
      return UserInterest(
        title: calification.name,
        maxLevel: calification.maxValue,
        userLevel: entry.value,
      );
    }).toList();
    
    return UserAnswer(
      interestedModules: interestedModules,
      priorityModules: priorityMap,
      userInterests: userInterests,
      categoryImportance: categoryImportances,
      comments: comments.value.isEmpty ? null : comments.value,
    );
  }
  
  bool canProceedFromStep(int step) {
    switch (step) {
      case 0:
        return currentCardIndex.value >= systemModules.length;
      case 1:
        return interestedModules.isNotEmpty;
      case 2:
        return userCalifications.isNotEmpty;
      case 3:
        return categoryImportances.isNotEmpty;
      case 4:
        return userName.value.isNotEmpty && 
               userEmail.value.isNotEmpty && 
               businessName.value.isNotEmpty;
      default:
        return false;
    }
  }
}
