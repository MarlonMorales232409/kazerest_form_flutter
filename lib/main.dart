import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:kazerest_form/view/questionnaire/welcome_screen_view.dart';
import 'package:kazerest_form/config/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KazeRest Form - Evaluación de Producto',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: DarkTheme.backgroundPrimary,
        appBarTheme: const AppBarTheme(
          backgroundColor: DarkTheme.backgroundSecondary,
          foregroundColor: DarkTheme.textPrimary,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: DarkTheme.textPrimary),
          bodyMedium: TextStyle(color: DarkTheme.textSecondary),
          headlineLarge: TextStyle(color: DarkTheme.textPrimary),
          headlineMedium: TextStyle(color: DarkTheme.textPrimary),
          headlineSmall: TextStyle(color: DarkTheme.textPrimary),
        ),
        colorScheme: const ColorScheme.dark(
          primary: DarkTheme.primaryPurple,
          secondary: DarkTheme.primaryPurpleLight,
          surface: DarkTheme.backgroundCard,
          onPrimary: DarkTheme.textPrimary,
          onSecondary: DarkTheme.textPrimary,
          onSurface: DarkTheme.textPrimary,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'System',
      ),
      home: const WelcomeScreenView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
