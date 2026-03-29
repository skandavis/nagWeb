import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class TabToggle extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const TabToggle({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < tabs.length; i++)
          GestureDetector(
            onTap: () => onChanged(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selectedIndex == i ? AppColors.deepThemeColor : Colors.transparent,
                border: Border.all(
                  color: selectedIndex == i ? AppColors.deepThemeColor : AppColors.border,
                ),
              ),
              child: Text(
                tabs[i].toUpperCase(),
                style: GoogleFonts.cinzel(
                  fontSize: 9,
                  letterSpacing: 2,
                  color: selectedIndex == i ? AppColors.ivory : AppColors.textSecondary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
