import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class AppFooter extends StatelessWidget {
  final bool isWide;

  const AppFooter({super.key, required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.charcoal,
      padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 80),
      child: isWide
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_brand(), _links()],
            )
          : Column(
              children: [
                _brand(),
                const SizedBox(height: 24),
                _links(),
                const SizedBox(height: 24),
              ],
            ),
    );
  }

  Widget _brand() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.gold.withOpacity(0.4)),
          ),
          alignment: Alignment.center,
          child: const Text('✦', style: TextStyle(color: AppColors.gold, fontSize: 14)),
        ),
        const SizedBox(width: 14),
        Text(
          'Matrimonial',
          style: GoogleFonts.cinzel(
            fontSize: 12,
            letterSpacing: 1.5,
            color: AppColors.ivory.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _links() {
    return Wrap(
      spacing: 28,
      runSpacing: 12,
      children: ['Privacy Policy', 'Terms of Service', 'Contact Us', 'Help Center']
          .map((l) => Text(
                l,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 14,
                  color: AppColors.ivory.withOpacity(0.4),
                  letterSpacing: 0.5,
                ),
              ))
          .toList(),
    );
  }
}
