import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double iconSize;
  final double fontSize;
  final Color textColor;

  const AppLogo({
    super.key,
    this.iconSize = 38,
    this.fontSize = 14,
    this.textColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.gold, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            '✦',
            style: TextStyle(color: AppColors.gold, fontSize: iconSize * 0.37),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Matrimonial',
          style: GoogleFonts.cinzel(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
