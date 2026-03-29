import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial/theme/app_colors.dart';

class AvatarCircle extends StatelessWidget {
  final String initials;
  final Color color;
  final double size;
  final double fontSize;

  const AvatarCircle({
    super.key,
    required this.initials,
    required this.color,
    this.size = 52,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.goldLight,
            AppColors.gold,
            AppColors.goldDeep,
          ],
        ),
        borderRadius: BorderRadius.circular(size * 0.16),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalPlum.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * 0.13),
          border: Border.all(color: AppColors.ivory.withValues(alpha: 0.7)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.95),
              AppColors.themeColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: GoogleFonts.cinzel(
            fontSize: fontSize,
            color: AppColors.ivory,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
