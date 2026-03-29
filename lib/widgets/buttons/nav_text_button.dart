import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class NavTextButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const NavTextButton({super.key, required this.label, this.onTap});

  @override
  State<NavTextButton> createState() => _NavTextButtonState();
}

class _NavTextButtonState extends State<NavTextButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                widget.label,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 15,
                  color: _hovered ? AppColors.textPrimary : AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 1,
              width: _hovered ? 80.0 : 0.0,
              color: AppColors.gold,
            ),
          ],
        ),
      ),
    );
  }
}
