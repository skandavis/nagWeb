import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class LoginLeftPanel extends StatelessWidget {
  const LoginLeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.deepThemeColor,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 32, height: 1, color: AppColors.gold),
              const SizedBox(width: 14),
              Text(
                'TRUSTED SINCE 1776',
                style: GoogleFonts.cinzel(
                  fontSize: 10,
                  letterSpacing: 3.5,
                  color: AppColors.gold,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Welcome\n',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 52,
                  fontWeight: FontWeight.w400,
                  color: AppColors.ivory,
                  height: 1.1,
                ),
              ),
              TextSpan(
                text: 'Back',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 52,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: AppColors.goldLight,
                  height: 1.1,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 28),
          Text(
            'Your search for a meaningful connection continues. We have kept your account safe in your absence.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 17,
              height: 1.9,
              color: AppColors.ivory.withOpacity(0.75),
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Over 600 successful matches. Est. 1776.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 14,
              color: AppColors.ivory.withOpacity(0.4),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
