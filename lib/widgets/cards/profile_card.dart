import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../layout/purplePanel.dart';

class ProfileCard extends StatefulWidget {
  final UserProfile user;
  final VoidCallback onTap;

  const ProfileCard({super.key, required this.user, required this.onTap});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: purplePanel(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 760;

            if (isCompact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardMainContent(user: widget.user, isCompact: true),
                  const SizedBox(height: 14),
                  _CardActions(user: widget.user),
                ],
              );
            }

            return _CardMainContent(user: widget.user, isCompact: false);
          },
        ),
      ),
    );
  }
}

class _CardMainContent extends StatelessWidget {
  const _CardMainContent({required this.user, required this.isCompact});

  final UserProfile user;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileImage(
                imageUrl:
                    user.imageUrls.isNotEmpty ? user.imageUrls.first : null,
              ),
              const SizedBox(width: 16),
              Expanded(child: _CardDetails(user: user)),
            ],
          ),
          const SizedBox(height: 14),
          _CardBio(bio: user.bio),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileImage(
              imageUrl: user.imageUrls.isNotEmpty ? user.imageUrls.first : null,
            ),
            const SizedBox(height: 12),
            _CardActions(user: user),
          ],
        ),
        const SizedBox(width: 18),
        SizedBox(
          width: 400,
          child: _CardDetails(user: user),
        ),
        const SizedBox(width: 18),
        const SizedBox(height: 180, child: VerticalGoldDivider()),
        const SizedBox(width: 18),
        Expanded(
          child: _CardBio(bio: user.bio),
        ),
      ],
    );
  }
}

class _CardDetails extends StatelessWidget {
  const _CardDetails({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          style: GoogleFonts.playfairDisplay(
            fontSize: 26,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 8),
        _IncomeBadge(salary: user.salary),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _UserLabel(label: '${user.age} years'),
            _UserLabel(label: user.location),
            _UserLabel(label: user.profession),
          ],
        ),
      ],
    );
  }
}

class _IncomeBadge extends StatelessWidget {
  const _IncomeBadge({required this.salary});

  final int salary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.royalPlum,
            AppColors.imperialPurple,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on,
              color: AppColors.goldLight, size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Annual Income',
                style: GoogleFonts.cinzel(
                  fontSize: 9,
                  color: AppColors.ivory.withValues(alpha: 0.82),
                  letterSpacing: 2.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$salary USD',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 19,
                  color: AppColors.ivory,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.marble,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppColors.goldLight.withValues(alpha: 0.72),
          width: 1.6,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalPlum.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _UserLabel extends StatelessWidget {
  const _UserLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: Text(
        label,
        style: GoogleFonts.cormorantGaramond(
          fontSize: 18,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CardBio extends StatelessWidget {
  const _CardBio({required this.bio});

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.56),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bio,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 18,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              height: 1.45,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _CardActions extends StatefulWidget {
  const _CardActions({required this.user});

  final UserProfile user;

  @override
  State<_CardActions> createState() => _CardActionsState();
}

class _CardActionsState extends State<_CardActions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ActionSeal(
          icon: widget.user.blocked ? Icons.block : Icons.block_outlined,
          active: widget.user.blocked,
          activeColor: AppColors.deepThemeColor,
          onTap: () =>
              setState(() => widget.user.blocked = !widget.user.blocked),
        ),
        const SizedBox(width: 10),
        _ActionSeal(
          icon: widget.user.favorite ? Icons.favorite : Icons.favorite_border,
          active: widget.user.favorite,
          activeColor: AppColors.terracotta,
          onTap: () =>
              setState(() => widget.user.favorite = !widget.user.favorite),
        ),
      ],
    );
  }
}

class _ActionSeal extends StatelessWidget {
  const _ActionSeal({
    required this.icon,
    required this.active,
    required this.activeColor,
    required this.onTap,
  });

  final IconData icon;
  final bool active;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: active
              ? activeColor.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: active
                ? activeColor.withValues(alpha: 0.4)
                : AppColors.borderStrong,
          ),
        ),
        child: Icon(
          icon,
          size: 17,
          color: active ? activeColor : AppColors.textMuted,
        ),
      ),
    );
  }
}

class VerticalGoldDivider extends StatelessWidget {
  const VerticalGoldDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.border.withValues(alpha: 0.15),
            AppColors.gold,
            AppColors.border.withValues(alpha: 0.15),
          ],
        ),
      ),
    );
  }
}
