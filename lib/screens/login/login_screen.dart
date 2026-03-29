import 'package:flutter/material.dart';
import '../home/members_screen.dart';
import 'login_left_panel.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onLogin(BuildContext context, String username) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MembersScreen(currentUser: username)),
      // Keep the LandingScreen at the bottom of the stack
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: isWide ? _wideLayout(context) : _narrowLayout(context),
    );
  }

  Widget _wideLayout(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: LoginLeftPanel()),
        Expanded(child: LoginForm(onSuccess: (u) => _onLogin(context, u))),
      ],
    );
  }

  Widget _narrowLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 280, child: LoginLeftPanel()),
          LoginForm(onSuccess: (u) => _onLogin(context, u)),
        ],
      ),
    );
  }
}
