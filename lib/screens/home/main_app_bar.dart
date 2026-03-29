import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final String currentUser;
  final VoidCallback onSignOut;

  static const _tabs = ['Profiles','Messages'];

  const MainAppBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    required this.currentUser,
    required this.onSignOut,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.warmWhite,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              _DrawerButton(),
              const SizedBox(width: 8),
              const AppLogo(iconSize: 36, fontSize: 13),
              const Spacer(),
              TabToggle(
                tabs: _tabs,
                selectedIndex: selectedIndex,
                onChanged: onTabChanged,
              ),
              const SizedBox(width: 20),
              Text(
                currentUser,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(width: 12),
              _SignOutButton(onTap: onSignOut),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Drawer hamburger ─────────────────────────────────────────────────────────

class _DrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) => IconButton(
        tooltip: 'Menu',
        onPressed: () => Scaffold.of(ctx).openDrawer(),
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) => Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : 5),
            child: Container(width: 22, height: 1.5, color: AppColors.textSecondary),
          )),
        ),
      ),
    );
  }
}

// ─── Sign-out button ──────────────────────────────────────────────────────────

class _SignOutButton extends StatefulWidget {
  final VoidCallback onTap;
  const _SignOutButton({required this.onTap});

  @override
  State<_SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<_SignOutButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hovered ? AppColors.terracotta : AppColors.border,
            ),
          ),
          child: Text(
            'SIGN OUT',
            style: GoogleFonts.cinzel(
              fontSize: 8,
              letterSpacing: 2,
              color: _hovered ? AppColors.terracotta : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
