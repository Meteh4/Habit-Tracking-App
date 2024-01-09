import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    fontFamily: 'Product',
  brightness: Brightness.dark,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF183D3D),
  ),
  colorScheme: const ColorScheme.dark(
    background : Color(0xFF93bae1),
    primary: Colors.deepPurple,
    secondary: Color(0xFF8984d6),
    outline: Color(0xFF7251b2),
    shadow: Color(0xFF8ce2ee),
    
  )

);