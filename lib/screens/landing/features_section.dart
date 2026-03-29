import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class FeaturesSection extends StatelessWidget {
  final bool isWide;

  const FeaturesSection({super.key, required this.isWide});

  static const _features = [
    ('🔒', 'Trusted Profiles',
        'Some text about trusted profiles. Some text about trusted profiles. Some text about trusted profiles.'),
    ('✦', 'Perfect Matches',
        'Some text about perfect matches. Some text about perfect matches. Some text about perfect matches.'),
    ('📞', 'Call People',
        'Some text about calling people. Some text about calling people. Some text about calling people.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 80),
      child: Column(
        children: [
          const SectionEyebrow(text: 'What We Have',),
          const SizedBox(height: 20),
          isWide
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < _features.length; i++) ...[
                        if (i > 0) Container(width: 2, color: AppColors.border),
                        Expanded(
                          child: FeatureCard(
                            icon: _features[i].$1,
                            title: _features[i].$2,
                            body: _features[i].$3,
                          ),
                        ),
                      ],
                    ],
                  ),
                )
              : Column(
                  children: [
                    for (int i = 0; i < _features.length; i++) ...[
                      if (i > 0) const SizedBox(height: 2),
                      FeatureCard(
                        icon: _features[i].$1,
                        title: _features[i].$2,
                        body: _features[i].$3,
                      ),
                    ],
                  ],
                ),
        ],
      ),
    );
  }
}
