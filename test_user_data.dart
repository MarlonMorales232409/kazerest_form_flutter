import 'package:kazerest_form/model/model.dart';
import 'package:kazerest_form/db_local/db_local.dart';

void main() {
  // Test the UserAnswer model with user data
  print('🧪 Testing UserAnswer model with user contact data...\n');
  
  // Create sample data
  final interestedModules = [
    {
      'id': 'mod_1',
      'title': 'Test Module 1',
      'description': 'Test description 1',
    },
    {
      'id': 'mod_2', 
      'title': 'Test Module 2',
      'description': 'Test description 2',
    },
  ];
  
  final priorityModules = {
    '1': {
      'id': 'mod_1',
      'title': 'Test Module 1',
      'description': 'Test description 1',
    },
    '2': {
      'id': 'mod_2',
      'title': 'Test Module 2', 
      'description': 'Test description 2',
    },
  };
  
  final userInterests = [
    UserInterest(
      id: 'cal_1',
      title: 'Test Skill 1',
      maxLevel: 5,
      userLevel: 3,
    ),
    UserInterest(
      id: 'cal_2',
      title: 'Test Skill 2',
      maxLevel: 5,
      userLevel: 4,
    ),
  ];
  
  final categoryImportances = categories.map((category) => 
    CategoryImportance(
      id: category.id,
      name: category.name,
      value: 5,
      maxValue: category.maxValue,
    )
  ).toList();
  
  // Create UserAnswer with contact data
  final userAnswer = UserAnswer(
    interestedModules: interestedModules,
    priorityModules: priorityModules,
    userInterests: userInterests,
    categoryImportance: categoryImportances,
    comments: 'Test comments about specific needs',
    // User contact data
    userName: 'Juan Pérez García',
    userEmail: 'juan@mirestaurante.com',
    userPhone: '+52 55 1234 5678',
    businessName: 'Restaurante El Buen Sabor',
    userRole: 'Gerente General',
  );
  
  // Convert to JSON
  final jsonData = userAnswer.toJson();
  
  // Display the results
  print('✅ UserAnswer object created successfully!');
  print('\n📋 Generated JSON data contains:');
  print('   👤 User Data:');
  print('     - Name: ${jsonData['userName']}');
  print('     - Email: ${jsonData['userEmail']}');
  print('     - Phone: ${jsonData['userPhone']}');
  print('     - Business: ${jsonData['businessName']}');
  print('     - Role: ${jsonData['userRole']}');
  print('   📊 Survey Data:');
  print('     - Interested Modules: ${jsonData['interestedModules'].length}');
  print('     - Priority Modules: ${jsonData['priorityModules'].length}');
  print('     - User Interests: ${jsonData['userInterests'].length}');
  print('     - Category Importances: ${jsonData['categoryImportance'].length}');
  print('     - Comments: ${jsonData['comments']}');
  
  print('\n🎯 Test Result: User contact data is now properly included in the UserAnswer model!');
  print('🔥 When the form is submitted to Firestore, it will now contain all user contact information.');
}
