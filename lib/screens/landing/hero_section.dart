import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onCreateProfile;
  final VoidCallback onBrowseMatches;

  const HeroSection({
    super.key,
    required this.onCreateProfile,
    required this.onBrowseMatches,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    return SizedBox(
      height: size.height,
      child: isWide
          ? Row(children: [
              Expanded(child: _HeroLeft(onCreateProfile: onCreateProfile, onBrowseMatches: onBrowseMatches)),
              const Expanded(child: _HeroRight()),
            ])
          : Column(children: [
              Expanded(flex: 6, child: _HeroLeft(onCreateProfile: onCreateProfile, onBrowseMatches: onBrowseMatches)),
              const Expanded(flex: 5, child: _HeroRight()),
            ]),
    );
  }
}

class _HeroLeft extends StatelessWidget {
  final VoidCallback onCreateProfile;
  final VoidCallback onBrowseMatches;

  const _HeroLeft({required this.onCreateProfile, required this.onBrowseMatches});

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
                  fontSize: 10, letterSpacing: 3.5,
                  color: AppColors.gold, fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Where People\n',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 58, fontWeight: FontWeight.w400,
                  color: AppColors.ivory, height: 1.05,
                ),
              ),
              TextSpan(
                text: 'Find Their\n',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 58, fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: AppColors.goldLight, height: 1.05,
                ),
              ),
              TextSpan(
                text: 'Match',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 58, fontWeight: FontWeight.w400,
                  color: AppColors.ivory, height: 1.05,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 32),
          Text(
            'some text about the service, how it works, and why it\'s different from other dating sites. this should be a couple of sentences that entice users to sign up and create a profile.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 17, height: 1.9,
              color: AppColors.ivory.withOpacity(0.75),
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              FilledCtaButton(
                label: 'Create Profile',
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                onTap: onCreateProfile,
              ),
              const SizedBox(width: 16),
              OutlineCtaButton(label: 'Browse Matches', onTap: onBrowseMatches),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroRight extends StatelessWidget {
  const _HeroRight();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cream,
      padding: const EdgeInsets.all(60),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Emblem circle
            Container(
              width: 180, height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gold.withOpacity(0.4), width: 1),
                color: AppColors.ivory,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('✦', style: TextStyle(color: AppColors.gold, fontSize: 28)),
                  const SizedBox(height: 12),
                  Text(
                    'EST. 1776',
                    style: GoogleFonts.cinzel(
                      fontSize: 11, letterSpacing: 3, color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            const _InfoTile(icon: '🔒', label: 'All profiles verified'),
            const SizedBox(height: 12),
            const _InfoTile(icon: '⭐', label: 'Over 600 successful matches'),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String icon;
  final String label;

  const _InfoTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.warmWhite,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 15, color: AppColors.textSecondary,
              fontWeight: FontWeight.w300, letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
