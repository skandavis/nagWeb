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
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NameRow(user: user),
          const SizedBox(height: 28),
          _AttributeGrid(user: user),
          const SizedBox(height: 28),
          _AboutSection(bio: user.bio),
        ],
      ),
    );
  }
}

class _NameRow extends StatelessWidget {
  const _NameRow({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 620;
        final content = [
          AvatarCircle(
            initials: user.initials,
            color: user.avatarColor,
            size: 76,
            fontSize: 22,
          ),
          const SizedBox(width: 20, height: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 34,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 14),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _InfoChip(label: user.profession),
                    _InfoChip(label: user.location),
                    _InfoChip(label: '${user.age} years'),
                  ],
                ),
              ],
            ),
          ),
        ];

        return compact
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content,
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content,
              );
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.64),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: Text(
        label,
        style: GoogleFonts.cormorantGaramond(
          fontSize: 16,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _AttributeGrid extends StatelessWidget {
  const _AttributeGrid({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    final attrs = [
      _Attr(label: 'Age', value: '${user.age} years'),
      _Attr(label: 'Profession', value: user.profession),
      _Attr(label: 'Location', value: user.location),
      _Attr(label: 'Annual Income', value: user.salary.toString()),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth > 560 ? 2 : 1;
        final width = (constraints.maxWidth - (crossCount - 1) * 14) / crossCount;

        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: attrs
              .map((a) => SizedBox(width: width, child: _AttributeTile(attr: a)))
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
  const _AttributeTile({required this.attr});

  final _Attr attr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            AppColors.marble,
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            attr.label.toUpperCase(),
            style: GoogleFonts.cinzel(
              fontSize: 9,
              letterSpacing: 2.8,
              color: AppColors.goldDeep,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            attr.value,
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({required this.bio});

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(
            bio,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              height: 1.75,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
