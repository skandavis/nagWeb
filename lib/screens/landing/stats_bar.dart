import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class StatsBar extends StatelessWidget {
  final bool isWide;

  const StatsBar({super.key, required this.isWide});

  static const _stats = [
    ('1,200', '+', 'Happy Families'),
    ('600',   '+', 'Matches'),
    ('30',    '+', 'Years of Service'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cream,
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.border),
        ),
      ),
      child: isWide
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < _stats.length; i++)
                  StatItem(
                    number: _stats[i].$1,
                    suffix: _stats[i].$2,
                    label: _stats[i].$3,
                    hasBorder: i < _stats.length - 1,
                  ),
              ],
            )
          : Column(
              children: _stats
                  .map((s) => StatItem(
                        number: s.$1,
                        suffix: s.$2,
                        label: s.$3,
                        hasBorder: false,
                      ))
                  .toList(),
            ),
    );
  }
}
