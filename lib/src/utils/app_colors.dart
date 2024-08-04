import 'package:flutter/widgets.dart';

class AppColors {
  AppColors._();
  static const Color sideBarColor = Color(0xFF090319);
  static const Color darkPink = Color(0xFF7508CB);
  static const Color lightPink = Color(0xFFEA00FF);
  static const Color dialogColor = Color(0xFF0A051B);
  static const List<Color> selectioncolors = [
    Color(0xFF4D07C6),
    Color(0xFFCD02DD),
  ];
  static const gradientText = LinearGradient(
    begin: Alignment(-0.93, -0.37), // Adjusted start position
    end: Alignment(1.14, 0.87), // Adjusted end position
    colors: [
      Color(0xFF2A08B3),
      Color(0xFFEB72FF),
    ],
  );
  static const gradientButton = LinearGradient(
    begin: Alignment(-0.9, -0.28), // Adjusted for angle
    end: Alignment(1.1, 0.87), // Adjusted for angle
    colors: [
      Color(0xFF1D09BD),
      Color(0xFFEB01E3),
    ],
  );
  static const selectionGradient = LinearGradient(
    colors: [
      Color(0xFF4D07C6),
      Color(0xFFCD02DD),
    ],
    stops: [0.0218, 1.0015], // Adjust stops slightly if needed
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const RadialGradient mainGradient = RadialGradient(
    colors: [
      Color(0xFF4D0775),
      Color(0xFF251337),
      Color(0xFF040013),
      Color(0xFF1A0229),
      Color(0xFF2A033F),
    ],
    stops: [0.0, 0.2271, 0.4719, 0.6521, 0.8241], // Matches CSS stops
    center: Alignment(-0.7, -0.5), // Example: adjust these
    radius: 1.6, // Example: adjust as needed
  );
}
