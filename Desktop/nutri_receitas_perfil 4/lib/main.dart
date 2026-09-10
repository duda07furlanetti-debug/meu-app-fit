import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/perfil_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/perfil_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PerfilProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const NutriReceitasApp(),
    ),
  );
}

class NutriReceitasApp extends StatelessWidget {
  const NutriReceitasApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'NutriReceitas',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: const PerfilScreen(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4CAF50),
        brightness: brightness,
      ),
      scaffoldBackgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        elevation: 0,
      ),
      cardColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
      chipTheme: ChipThemeData(
        backgroundColor: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
        selectedColor: const Color(0xFF2E7D32),
        labelStyle: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
