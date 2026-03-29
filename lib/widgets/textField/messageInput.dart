import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial/theme/app_colors.dart';

class messageInput extends StatefulWidget {
  final TextEditingController controller;
  final int maxLines;
  final String hintText;

  const messageInput({
    super.key,
    required this.controller,
    required this.maxLines,
    required this.hintText,
  });

  @override
  State<messageInput> createState() => _messageInputState();
}

class _messageInputState extends State<messageInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      style: GoogleFonts.cormorantGaramond(
        fontSize: 18,
        color: AppColors.textPrimary,
        height: 1.7,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.cormorantGaramond(
          fontSize: 18,
          color: AppColors.textMuted,
          fontStyle: FontStyle.italic,
        ),
        filled: true,
        fillColor: AppColors.marble,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: AppColors.borderStrong),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: AppColors.gold.withValues(alpha: 0.6)),
        ),
      ),
    );
  }
}
