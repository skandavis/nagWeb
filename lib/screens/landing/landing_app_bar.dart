import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class LandingAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const LandingAppBar({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  State<LandingAppBar> createState() => _LandingAppBarState();
}

class _LandingAppBarState extends State<LandingAppBar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        color: AppColors.warmWhite,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              // Logo
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 1.5),
                ),
                alignment: Alignment.center,
                child: const Text('✦', style: TextStyle(color: AppColors.gold, fontSize: 14)),
              ),
              const SizedBox(width: 12),
              Text(
                'Matrimonial',
                style: GoogleFonts.cinzel(
                  fontSize: 14, fontWeight: FontWeight.w500,
                  letterSpacing: 1.5, color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (isWide) ...[
                NavTextButton(label: 'Login', onTap: widget.onLogin),
                const SizedBox(width: 12),
              ],
              FilledCtaButton(label: 'Register Free', onTap: widget.onRegister),
            ],
          ),
        ),
      ),
    );
  }
}
