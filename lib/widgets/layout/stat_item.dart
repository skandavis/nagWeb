import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class StatItem extends StatelessWidget {
  final String number;
  final String suffix;
  final String label;
  final bool hasBorder;

  const StatItem({
    super.key,
    required this.number,
    required this.suffix,
    required this.label,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: hasBorder
          ? const BoxDecoration(border: Border(right: BorderSide(color: AppColors.border)))
          : null,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 40),
      child: Column(
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: number,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 48, fontWeight: FontWeight.w400,
                  color: AppColors.deepThemeColor, height: 1,
                ),
              ),
              TextSpan(
                text: suffix,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20, color: AppColors.gold, height: 1,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 10),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.cinzel(
              fontSize: 9, letterSpacing: 2.5, color: AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
