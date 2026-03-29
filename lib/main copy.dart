import 'package:flutter/material.dart';
import 'package:matrimonial/nav_item.dart';
import 'package:matrimonial/sidebar_drawer.dart';
import 'top_nav_bar.dart';

void main() => runApp(const MyApp());

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

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const _mainItems = [
    NavItem(icon: Icons.history_outlined, label: 'Your History'),
    NavItem(icon: Icons.tv_outlined, label: 'Channel Info'),
    NavItem(icon: Icons.playlist_play_outlined, label: 'Extract From Playlist'),
    NavItem(icon: Icons.grid_view_outlined, label: 'Extract From CSV'),
    NavItem(icon: Icons.api_outlined, label: 'API'),
  ];

  static const _bottomItems = [
    NavItem(icon: Icons.discord, label: 'Join us on Discord', isExternal: true),
    NavItem(icon: Icons.extension_outlined, label: 'Chrome Extension', isExternal: true),
    NavItem(icon: Icons.dark_mode_outlined, label: 'Toggle Dark/Light'),
    NavItem(icon: Icons.person_outline, label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopNavBar(),
      body: Row(
        children: [
          SidebarDrawer(mainItems: _mainItems, bottomItems: _bottomItems),
          // Your main content here
          Expanded(child: _Placeholder()),
        ],
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.youtube_searched_for, size: 64, color: Colors.red.withOpacity(0.7)),
          const SizedBox(height: 16),
          Text('YouTube Transcript',
              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 22)),
          const SizedBox(height: 8),
          Text('Select an option from the sidebar',
              style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 13)),
        ],
      ),
    );
  }
}