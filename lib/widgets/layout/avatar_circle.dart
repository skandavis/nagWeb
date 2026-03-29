import 'package:flutter/material.dart';
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
        border: Border.all(color: AppColors.goldLight, width: 3),
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Image.network(
          'https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
    // return Container(
    //   width: size,
    //   height: size,
    //   decoration: BoxDecoration(
    //     shape: BoxShape.circle,
    //     color: color,
    //     border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
    //   ),
    //   alignment: Alignment.center,
    //   child: Text(
    //     initials,
    //     style: GoogleFonts.cinzel(
    //       fontSize: fontSize,
    //       color: Colors.white,
    //       letterSpacing: 1,
    //       fontWeight: FontWeight.w500,
    //     ),
    //   ),
    // );
  }
}
