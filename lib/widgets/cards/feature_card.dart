import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class FeatureCard extends StatefulWidget {
  final String icon;
  final String title;
  final String body;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _hovered ? Colors.white : AppColors.warmWhite,
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: _hovered ? AppColors.deepThemeColor : AppColors.cream,
                border: Border.all(
                  color: _hovered ? AppColors.deepThemeColor : AppColors.border,
                ),
              ),
              alignment: Alignment.center,
              child: Text(widget.icon, style: const TextStyle(fontSize: 22)),
            ),
            const SizedBox(height: 28),
            Text(
              widget.title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.body,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 15,
                height: 1.8,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 24),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 2,
              width: _hovered ? 48.0 : 0.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gold, AppColors.terracotta],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
