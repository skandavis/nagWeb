import 'package:flutter/material.dart';

class NavItem {
  final IconData icon;
  final String label;
  final bool isExternal;

  const NavItem({
    required this.icon,
    required this.label,
    this.isExternal = false,
  });
}
