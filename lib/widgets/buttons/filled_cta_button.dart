import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class FilledCtaButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;

  const FilledCtaButton({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundColor = AppColors.deepThemeColor,
    this.foregroundColor = AppColors.ivory,
  });

  @override
  State<FilledCtaButton> createState() => _FilledCtaButtonState();
}

class _FilledCtaButtonState extends State<FilledCtaButton> {
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
          color: _hovered ? AppColors.themeColor : widget.backgroundColor,
          boxShadow: _hovered
              ? [BoxShadow(
                  color: AppColors.deepThemeColor.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                )]
              : [],
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
                color: widget.foregroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
