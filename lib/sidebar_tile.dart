import 'package:flutter/material.dart';
import 'nav_item.dart';

class SidebarTile extends StatefulWidget {
  final NavItem item;
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback onTap;

  const SidebarTile({
    super.key,
    required this.item,
    required this.isExpanded,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  State<SidebarTile> createState() => _SidebarTileState();
}

class _SidebarTileState extends State<SidebarTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF1A2535)
                : _hovering
                    ? const Color(0xFF141F2E)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                widget.item.icon,
                size: 19,
                color: isSelected ? Colors.white : Colors.white54,
              ),
              if (widget.isExpanded) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.item.label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: isSelected ? Colors.white : Colors.white60,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
                if (widget.item.isExternal)
                  const Icon(Icons.open_in_new,
                      size: 13, color: Colors.white30),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
