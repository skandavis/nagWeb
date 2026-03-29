import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class ProfileDetailInfo extends StatelessWidget {
  final UserProfile user;

  const ProfileDetailInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NameRow(user: user),
          const SizedBox(height: 24),
          const GoldDivider(),
          const SizedBox(height: 32),
          _AttributeGrid(user: user),
          const SizedBox(height: 32),
          const GoldDivider(),
          const SizedBox(height: 32),
          _AboutSection(bio: user.bio),
        ],
      ),
    );
  }
}

class _NameRow extends StatelessWidget {
  final UserProfile user;

  const _NameRow({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AvatarCircle(
          initials: user.initials,
          color: user.avatarColor,
          size: 64,
          fontSize: 18,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                user.location,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 15,
                  color: AppColors.textMuted,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AttributeGrid extends StatelessWidget {
  final UserProfile user;

  const _AttributeGrid({required this.user});

  @override
  Widget build(BuildContext context) {
    final attrs = [
      _Attr(label: 'Age',        value: '${user.age} years'),
      _Attr(label: 'Profession', value: user.profession),
      _Attr(label: 'Location',   value: user.location),
      _Attr(label: 'Annual Income', value: user.salary),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth > 500 ? 2 : 1;
        return Wrap(
          spacing: 2,
          runSpacing: 2,
          children: attrs
              .map((a) => SizedBox(
                    width: (constraints.maxWidth - (crossCount - 1) * 2) / crossCount,
                    child: _AttributeTile(attr: a),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _Attr {
  final String label;
  final String value;
  const _Attr({required this.label, required this.value});
}

class _AttributeTile extends StatelessWidget {
  final _Attr attr;

  const _AttributeTile({required this.attr});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.cream,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            attr.label.toUpperCase(),
            style: GoogleFonts.cinzel(
              fontSize: 8,
              letterSpacing: 2.5,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            attr.value,
            style: GoogleFonts.playfairDisplay(
              fontSize: 16,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final String bio;

  const _AboutSection({required this.bio});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionEyebrow(text: 'About'),
        const SizedBox(height: 20),
        Text(
          bio,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 17,
            height: 1.9,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
