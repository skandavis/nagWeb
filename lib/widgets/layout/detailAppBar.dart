import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial/theme/app_colors.dart';

class detailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;

  const detailAppBar({super.key, required this.title, this.trailing});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.royalPlum,
            AppColors.imperialPurple,
            AppColors.themeColor,
          ],
        ),
        border: Border(bottom: BorderSide(color: AppColors.goldDeep)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 16,
                  color: AppColors.ivory,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.cinzel(
                  fontSize: 12,
                  letterSpacing: 3.2,
                  color: AppColors.ivory,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
