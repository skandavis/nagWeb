import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Transcript',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animController;
  late Animation<double> _widthAnimation;

  static const double _collapsedWidth = 56.0;
  static const double _expandedWidth = 220.0;

  int _selectedIndex = 0;

  final List<_NavItem> _mainItems = const [
    _NavItem(icon: Icons.history_outlined, label: 'Your History'),
    _NavItem(icon: Icons.tv_outlined, label: 'Channel Info'),
    _NavItem(icon: Icons.playlist_play_outlined, label: 'Extract From Playlist'),
    _NavItem(icon: Icons.grid_view_outlined, label: 'Extract From CSV'),
    _NavItem(icon: Icons.api_outlined, label: 'API'),
  ];

  final List<_NavItem> _bottomItems = const [
    _NavItem(icon: Icons.discord, label: 'Join us on Discord', isExternal: true),
    _NavItem(icon: Icons.extension_outlined, label: 'Chrome Extension', isExternal: true),
    _NavItem(icon: Icons.dark_mode_outlined, label: 'Toggle Dark/Light'),
    _NavItem(icon: Icons.person_outline, label: 'Account'),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _widthAnimation = Tween<double>(
      begin: _collapsedWidth,
      end: _expandedWidth,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animController.forward();
      } else {
        _animController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          AnimatedBuilder(
            animation: _widthAnimation,
            builder: (context, child) {
              return Container(
                width: _widthAnimation.value,
                color: const Color(0xFF0F1923),
                child: child,
              );
            },
            child: _SidebarContent(
              isExpanded: _isExpanded,
              widthAnimation: _widthAnimation,
              selectedIndex: _selectedIndex,
              mainItems: _mainItems,
              bottomItems: _bottomItems,
              onToggle: _toggleDrawer,
              onItemTap: (i) => setState(() => _selectedIndex = i),
            ),
          ),

          // Main content area
          Expanded(
            child: Container(
              color: const Color(0xFF0D1117),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.youtube_searched_for,
                        size: 64, color: Colors.red.withOpacity(0.7)),
                    const SizedBox(height: 16),
                    Text(
                      'YouTube Transcript',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select an option from the sidebar',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarContent extends StatelessWidget {
  final bool isExpanded;
  final Animation<double> widthAnimation;
  final int selectedIndex;
  final List<_NavItem> mainItems;
  final List<_NavItem> bottomItems;
  final VoidCallback onToggle;
  final ValueChanged<int> onItemTap;

  const _SidebarContent({
    required this.isExpanded,
    required this.widthAnimation,
    required this.selectedIndex,
    required this.mainItems,
    required this.bottomItems,
    required this.onToggle,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo / Header
        _SidebarHeader(isExpanded: isExpanded, onToggle: onToggle),

        const Divider(color: Color(0xFF1E2A38), height: 1),
        const SizedBox(height: 8),

        // Main nav items
        ...mainItems.asMap().entries.map((entry) {
          return _SidebarTile(
            item: entry.value,
            index: entry.key,
            isSelected: selectedIndex == entry.key,
            isExpanded: isExpanded,
            widthAnimation: widthAnimation,
            onTap: () => onItemTap(entry.key),
          );
        }),

        const Spacer(),

        const Divider(color: Color(0xFF1E2A38), height: 1),
        const SizedBox(height: 8),

        // Bottom items
        ...bottomItems.map((item) {
          return _SidebarTile(
            item: item,
            index: -1,
            isSelected: false,
            isExpanded: isExpanded,
            widthAnimation: widthAnimation,
            onTap: () {},
          );
        }),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _SidebarHeader extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;

  const _SidebarHeader({required this.isExpanded, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            // YouTube-style icon
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.play_arrow, color: Colors.white, size: 18),
            ),
            if (isExpanded) ...[
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Transcript',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SidebarTile extends StatefulWidget {
  final _NavItem item;
  final int index;
  final bool isSelected;
  final bool isExpanded;
  final Animation<double> widthAnimation;
  final VoidCallback onTap;

  const _SidebarTile({
    required this.item,
    required this.index,
    required this.isSelected,
    required this.isExpanded,
    required this.widthAnimation,
    required this.onTap,
  });

  @override
  State<_SidebarTile> createState() => _SidebarTileState();
}

class _SidebarTileState extends State<_SidebarTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.isSelected
        ? const Color(0xFF1A2535)
        : _hovering
            ? const Color(0xFF141F2E)
            : Colors.transparent;

    final iconColor = widget.isSelected
        ? Colors.white
        : Colors.white.withOpacity(0.55);

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
            color: bg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(widget.item.icon, color: iconColor, size: 19),
              if (widget.isExpanded) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.item.label,
                    style: TextStyle(
                      color: widget.isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.65),
                      fontSize: 13.5,
                      fontWeight: widget.isSelected
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.item.isExternal)
                  Icon(Icons.open_in_new,
                      size: 13,
                      color: Colors.white.withOpacity(0.3)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final bool isExternal;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isExternal = false,
  });
}