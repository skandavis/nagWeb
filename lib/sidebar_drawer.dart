import 'package:flutter/material.dart';
import 'nav_item.dart';
import 'sidebar_tile.dart';

class SidebarDrawer extends StatefulWidget {
  final List<NavItem> mainItems;
  final List<NavItem> bottomItems;

  const SidebarDrawer({
    super.key,
    required this.mainItems,
    required this.bottomItems,
  });

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer>
    with SingleTickerProviderStateMixin {
  static const double _collapsed = 56;
  static const double _expanded = 220;

  bool _isExpanded = false;
  int _selectedIndex = 0;
  late final AnimationController _controller;
  late final Animation<double> _width;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _width = Tween(begin: _collapsed, end: _expanded).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
    _isExpanded ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _width,
      builder: (context, child) => Container(
        width: _width.value,
        color: const Color(0xFF0F1923),
        child: child,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header / logo
          GestureDetector(
            onTap: _toggle,
            child: SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    _Logo(),
                    if (_isExpanded) ...[
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Transcript',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          const Divider(color: Color(0xFF1E2A38), height: 1),
          const SizedBox(height: 8),

          // Main nav
          for (var (i, item) in widget.mainItems.indexed)
            SidebarTile(
              item: item,
              isExpanded: _isExpanded,
              isSelected: _selectedIndex == i,
              onTap: () => setState(() => _selectedIndex = i),
            ),

          const Spacer(),

          const Divider(color: Color(0xFF1E2A38), height: 1),
          const SizedBox(height: 8),

          // Bottom nav
          for (final item in widget.bottomItems)
            SidebarTile(item: item, isExpanded: _isExpanded, onTap: () {}),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(Icons.play_arrow, color: Colors.white, size: 18),
    );
  }
}
