import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final VoidCallback onSignOut;

  static const _tabs = [
    _DrawerTab(label: 'Profiles',  icon: Icons.person_outline,  sub: 'Browse member profiles'),
    _DrawerTab(label: 'Messages',  icon: Icons.mail_outline,    sub: 'Your messages and conversations'),
  ];

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.warmWhite,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 40, 32, 48),
              child: AppLogo(iconSize: 38, fontSize: 13),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
            ),
            const SizedBox(height: 24),
            for (int i = 0; i < _tabs.length; i++)
              _DrawerNavItem(
                tab: _tabs[i],
                isSelected: selectedIndex == i,
                onTap: () {
                  onTabChanged(i);
                  Navigator.of(context).pop();
                },
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Matrimonial Service — Est. 1776',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      onSignOut();
                    },
                    child: Text(
                      'SIGN OUT',
                      style: GoogleFonts.cinzel(
                        fontSize: 9,
                        letterSpacing: 2.5,
                        color: AppColors.terracotta,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTab {
  final String label;
  final IconData icon;
  final String sub;
  const _DrawerTab({required this.label, required this.icon, required this.sub});
}

class _DrawerNavItem extends StatelessWidget {
  final _DrawerTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerNavItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cream : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected ? AppColors.gold : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Row(
          children: [
            Icon(
              tab.icon,
              size: 20,
              color: isSelected ? AppColors.gold : AppColors.textMuted,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tab.label.toUpperCase(),
                  style: GoogleFonts.cinzel(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  tab.sub,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 13,
                    color: AppColors.textMuted,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
