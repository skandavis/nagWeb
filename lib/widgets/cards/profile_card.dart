import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../layout/avatar_circle.dart';
// import '../layout/gold_divider.dart';

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
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border, width: 1.5),
          ),
          padding: const EdgeInsets.only(top: 20, left: 0, right: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: _CardHeader(user: widget.user)
              ),
              const VerticalGoldDivider(),
              Expanded(child: _CardBio(bio: widget.user.bio)),
              const VerticalGoldDivider(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final UserProfile user;

  const _CardHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.goldLight, width: 3),
            color: AppColors.textMuted.withOpacity(0.1),
          ),
          child: Column(
            children: [
              AvatarCircle(
                initials: user.initials,
                color: user.avatarColor,
                size: 150,
                fontSize: 16,
              ),
              _CardEndFooter(user: user)
            ],
          ),
        ),
        const SizedBox(width: 20),
        Container(
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${user.age} · ${user.profession}',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      user.location,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ANNUAL INCOME',
                    style: GoogleFonts.cinzel(
                      fontSize: 8,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    "${user.salary} USD",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 10,
                      color: AppColors.deepThemeColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardBio extends StatelessWidget {
  final String bio;

  const _CardBio({required this.bio});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        bio,
        style: GoogleFonts.cormorantGaramond(
          fontSize: 14,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w300,
        ),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _CardEndFooter extends StatefulWidget {
  final UserProfile user;
  const _CardEndFooter({required this.user});

  @override
  State<_CardEndFooter> createState() => _CardEndFooterState();
}

class _CardEndFooterState extends State<_CardEndFooter> {
  @override

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => widget.user.blocked = !widget.user.blocked),
            child: Icon(
              widget.user.blocked ? Icons.block : Icons.block_outlined,
              size: 24,
              color: widget.user.blocked ? AppColors.deepThemeColor : AppColors.textMuted,
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () => setState(() => widget.user.favorite = !widget.user.favorite),
            child: Icon(
              widget.user.favorite ? Icons.favorite : Icons.favorite_border,
              size: 24,
              color: widget.user.favorite ? AppColors.terracotta : AppColors.textMuted,
            ),
          ),
        ],
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
      height: 100,
      color: AppColors.gold,
    );
  }
}
