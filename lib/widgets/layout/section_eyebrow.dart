import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class SectionEyebrow extends StatelessWidget {
  final String text;

  const SectionEyebrow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 36, height: 1, color: AppColors.gold),
        const SizedBox(width: 14),
        Text(
          text.toUpperCase(),
          style: GoogleFonts.cinzel(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            letterSpacing: 3.5,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(width: 14),
        Container(width: 36, height: 1, color: AppColors.gold),
      ],
    );
  }
}
