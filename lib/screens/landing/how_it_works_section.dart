import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  static const _steps = [
    ('01', 'Step 1',      'some text about signing up. some text about signing up. some text about signing up.'),
    ('02', 'Step 2',     'some text about the matchmaking process. some text about the matchmaking process. some text about the matchmaking process.'),
    ('03', 'Step 3',    'some text about meeting online. some text about meeting online. some text about meeting online.'),
    ('04', 'Step 4',     'some text about finding your match. some text about finding your match. some text about finding your match.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.warmWhite,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 80),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Four Simple Steps',
            style: GoogleFonts.playfairDisplay(
              fontSize: 36, fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 60),
          ...List.generate(_steps.length, (i) => _StepRow(
            number: _steps[i].$1,
            title:  _steps[i].$2,
            body:   _steps[i].$3,
            isLast: i == _steps.length - 1,
          )),
        ],
      ),
    );
  }
}

// ─── Step row ─────────────────────────────────────────────────────────────────

class _StepRow extends StatelessWidget {
  final String number;
  final String title;
  final String body;
  final bool isLast;

  const _StepRow({
    required this.number,
    required this.title,
    required this.body,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StepIndicator(number: number, isLast: isLast),
          const SizedBox(width: 32),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 48),
              child: _StepContent(title: title, body: body),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final String number;
  final bool isLast;

  const _StepIndicator({required this.number, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52, height: 52,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            color: AppColors.cream,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: GoogleFonts.cinzel(
              fontSize: 13, letterSpacing: 1,
              color: AppColors.gold, fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (!isLast)
          Expanded(child: Container(width: 1, color: AppColors.border)),
      ],
    );
  }
}

class _StepContent extends StatelessWidget {
  final String title;
  final String body;

  const _StepContent({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            fontSize: 20, fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          body,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 16, height: 1.8,
            color: AppColors.textSecondary, fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
