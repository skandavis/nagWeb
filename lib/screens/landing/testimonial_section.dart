import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class TestimonialSection extends StatelessWidget {
  const TestimonialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.deepThemeColor,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 80),
      child: Column(
        children: [
          Text(
            '“',
            style: GoogleFonts.playfairDisplay(
              fontSize: 80, color: AppColors.gold, height: 0.8,
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              'some text about how great the service is. some text about how great the service is. some text about how great the service is. some text about how great the service is.',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 22, fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: AppColors.ivory, height: 1.7,
              ),
            ),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 32, height: 1, color: AppColors.gold),
              const SizedBox(width: 12),
              Text(
                'John Doe, CEO of ExampleCorp',
                style: GoogleFonts.cinzel(
                  fontSize: 9, letterSpacing: 2.5, color: AppColors.gold,
                ),
              ),
              const SizedBox(width: 12),
              Container(width: 32, height: 1, color: AppColors.gold),
            ],
          ),
        ],
      ),
    );
  }
}
