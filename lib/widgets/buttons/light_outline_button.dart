import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

/// A bordered CTA button for use on light backgrounds (cream, warmWhite).
/// Uses dark text unlike [OutlineCtaButton] which is for dark backgrounds.
class LightOutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const LightOutlineButton({super.key, required this.label, this.onTap});

  @override
  State<LightOutlineButton> createState() => _LightOutlineButtonState();
}

class _LightOutlineButtonState extends State<LightOutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: _hovered ? AppColors.gold : AppColors.border,
          ),
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            child: Text(
              widget.label.toUpperCase(),
              style: GoogleFonts.cinzel(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.5,
                color: _hovered ? AppColors.gold : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
