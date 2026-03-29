import 'package:flutter/material.dart';
import '../profiles/profiles_screen.dart';
import '../messages/messages_screen.dart';
import 'main_app_bar.dart';
import 'app_drawer.dart';

class MembersScreen extends StatefulWidget {
  final String currentUser;

  const MembersScreen({super.key, required this.currentUser});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  int _selectedIndex = 0;

  /// Sign out pops back to the LandingScreen (the first route).
  void _signOut() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget get _currentScreen => switch (_selectedIndex) {
    0 => const ProfilesScreen(),
    _ => const MessagesScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        selectedIndex: _selectedIndex,
        onTabChanged: (i) => setState(() => _selectedIndex = i),
        currentUser: widget.currentUser,
        onSignOut: _signOut,
      ),
      drawer: AppDrawer(
        selectedIndex: _selectedIndex,
        onTabChanged: (i) => setState(() => _selectedIndex = i),
        onSignOut: _signOut,
      ),
      body: _currentScreen,
    );
  }
}
