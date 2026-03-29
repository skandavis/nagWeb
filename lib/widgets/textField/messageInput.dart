import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial/theme/app_colors.dart';

class messageInput extends StatefulWidget {
  final TextEditingController controller;
  final int maxLines;
  String hintText;
  messageInput({super.key, required this.controller, required this.maxLines, required this.hintText});

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
        fontSize: 16,
        color: AppColors.textPrimary,
        height: 2,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.cormorantGaramond(
          fontSize: 16,
          color: AppColors.textMuted,
          fontStyle: FontStyle.italic,
        ),
        filled: true,
        fillColor: AppColors.ivory,
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.gold.withOpacity(0.6)),
        ),
      ),
    );
  }
}