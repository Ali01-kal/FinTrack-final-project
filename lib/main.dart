import 'package:fintrack/core/router/app_router.dart';  // Біз жаңа жасаған роутерді импорттау
import 'package:flutter/material.dart';


void main() {
  // Қолданба іске қосылғанда міндетті түрде шақырылуы керек
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const FinTrackApp());
}

class FinTrackApp extends StatelessWidget {
  const FinTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FinTrack',
      debugShowCheckedModeBanner: false, // Оң жақ жоғарыдағы "Debug" жазуын алып тастайды
      
      // Навигация баптаулары
      routerConfig: AppRouter, 
      
      // Қолданбаның тақырыбы (Theme)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // Material 3 дизайнын қолдану
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}