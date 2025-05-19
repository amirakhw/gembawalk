// lib/main.dart

import 'package:flutter/material.dart';
import 'package:gembawalk_front/NotifierProviders/all_data.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/gemba_walk/gemba_walk_menu_screen.dart';
import 'config/theme.dart';
import 'package:provider/provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {  
  dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocalDB(),
      child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gemba Walk',
      theme: attijariTheme,
      // 1️⃣ Use named routes for both login and menu
      initialRoute: '/',
      routes: {
        // When the app starts, show LoginScreen
        '/': (ctx) => const LoginScreen(),
        // Define '/menu' to point at your GembaWalkMenuScreen
        '/menu': (ctx) => const GembaWalkMenuScreen(
              formId: 1,
              regionId: 1,
              groupId: 1,
              agenceId: 1,
              // Removed: regionName: 'Région',
              // Removed: groupName: 'Groupe',
              // Removed: agenceName: 'Agence',
            ),
      },
      // You can still catch other pushes with onGenerateRoute if needed
      onGenerateRoute: (settings) {
        // fallback logic here…
        return null;
      },
    );
  }
}