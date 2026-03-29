import 'package:flutter/material.dart';
import '../login/login_screen.dart';
import '../../widgets/widgets.dart';
import 'landing_app_bar.dart';
import 'hero_section.dart';
import 'stats_bar.dart';
import 'features_section.dart';
import 'how_it_works_section.dart';
import 'testimonial_section.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  void _goToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: LandingAppBar(
        onLogin: _goToLogin,
        onRegister: _goToLogin,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(
              onCreateProfile: _goToLogin,
              onBrowseMatches: _goToLogin,
            ),
            StatsBar(isWide: isWide),
            FeaturesSection(isWide: isWide),
            const HowItWorksSection(),
            const TestimonialSection(),
            AppFooter(isWide: isWide),
          ],
        ),
      ),
    );
  }
}
