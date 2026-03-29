import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/landing/landing_screen.dart';

void main() {
  runApp(const MatrimonialApp());
}

class MatrimonialApp extends StatelessWidget {
  const MatrimonialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matrimonial',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LandingScreen(),
    );
  }
}
