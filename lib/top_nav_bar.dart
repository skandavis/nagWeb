import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: const Color(0xFF0F1923),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _NavLink(label: 'Pricing', onTap: () {}),
          _NavLink(label: 'API', onTap: () {}),
          const _DropdownNavLink(label: 'Bulk'),
          _NavLink(label: 'Support', onTap: () {}),
          const SizedBox(width: 8),
          _AccountButton(onTap: () {}),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 13.5,
              color: _hovering ? Colors.white : Colors.white70,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownNavLink extends StatefulWidget {
  final String label;

  const _DropdownNavLink({required this.label});

  @override
  State<_DropdownNavLink> createState() => _DropdownNavLinkState();
}

class _DropdownNavLinkState extends State<_DropdownNavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13.5,
                color: _hovering ? Colors.white : Colors.white70,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 15,
              color: _hovering ? Colors.white : Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountButton extends StatefulWidget {
  final VoidCallback onTap;

  const _AccountButton({required this.onTap});

  @override
  State<_AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<_AccountButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.account_circle_outlined,
                size: 18,
                color: _hovering ? Colors.white : Colors.white70,
              ),
              const SizedBox(width: 6),
              Text(
                'My Account',
                style: TextStyle(
                  fontSize: 13.5,
                  color: _hovering ? Colors.white : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
