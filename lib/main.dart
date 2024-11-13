//import 'package:coffe_zone/pages/home.dart';
import 'package:coffe_zone/pages/init.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Zone',
      theme: ThemeData(
        primaryColor: const Color(0xFF6F4E37), // Marrón oscuro
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF6F4E37),
          secondary: Colors.amber[700],
          surface: const Color(0xFFF5F5DC), // Crema
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface : Colors.brown[900],
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5DC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6F4E37),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.brown, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.brown),
          titleLarge: TextStyle(
            color: Color(0xFF6F4E37), // Marrón oscuro
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.amber[700],
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.brown[300],
          backgroundColor: const Color(0xFF6F4E37),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFFFAF3E0), // Color de fondo para el Drawer
        ),
      ),
      home: const Init()
    );
  }
}