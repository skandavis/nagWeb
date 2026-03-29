import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  final void Function(String username) onSuccess;

  const LoginForm({super.key, required this.onSuccess});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() => _error = 'Please enter your credentials to proceed.');
      return;
    }

    setState(() { _loading = true; _error = null; });
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    widget.onSuccess(username);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.warmWhite,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(iconSize: 42, fontSize: 14),
              const SizedBox(height: 48),
              const SectionEyebrow(text: 'Member Login'),
              const SizedBox(height: 16),
              Text(
                'Sign in to your account',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 40),
              const _FieldLabel(text: 'USERNAME OR EMAIL'),
              const SizedBox(height: 10),
              _StyledTextField(
                controller: _usernameController,
                hint: 'your.name@example.com',
                obscure: false,
                onSubmit: _submit,
              ),
              const SizedBox(height: 24),
              const _FieldLabel(text: 'PASSWORD'),
              const SizedBox(height: 10),
              _StyledTextField(
                controller: _passwordController,
                hint: '••••••••••',
                obscure: true,
                onSubmit: _submit,
              ),
              const SizedBox(height: 32),
              if (_error != null) ...[
                Text(
                  _error!,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 14,
                    color: AppColors.terracotta,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              SizedBox(
                width: double.infinity,
                child: FilledCtaButton(
                  label: _loading ? 'Signing In…' : 'Sign In',
                  onTap: _loading ? null : _submit,
                  backgroundColor: AppColors.deepThemeColor,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Any username & password will work for this demonstration.',
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 13,
                  color: AppColors.textMuted,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Small helpers ─────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.cinzel(
        fontSize: 9,
        letterSpacing: 2.5,
        color: AppColors.textMuted,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final VoidCallback onSubmit;

  const _StyledTextField({
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      onSubmitted: (_) => onSubmit(),
      style: GoogleFonts.cormorantGaramond(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.cormorantGaramond(
          fontSize: 16,
          color: AppColors.textMuted,
        ),
        filled: true,
        fillColor: AppColors.ivory,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.gold.withOpacity(0.6)),
        ),
      ),
    );
  }
}
