import 'package:flutter/material.dart';

import 'package:matrimonial/widgets/widgets.dart';

import '../../models/models.dart';
import '../../theme/app_colors.dart';
import 'profile_detail_info.dart';
import 'profile_image_gallery.dart';

class ProfileDetailScreen extends StatefulWidget {
  final UserProfile user;

  const ProfileDetailScreen({super.key, required this.user});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmWhite,
      appBar: detailAppBar(
        title: 'Member Profile',
        trailing: _ProfileActions(
          user: widget.user,
          onToggleBlock: () => setState(() => widget.user.blocked = !widget.user.blocked),
          onToggleFavorite: () => setState(() => widget.user.favorite = !widget.user.favorite),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF9F2E8),
              AppColors.warmWhite,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: purplePanel(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                child: Column(
                  children: [
                    ProfileImageGallery(imageUrls: widget.user.imageUrls),
                    ProfileDetailInfo(user: widget.user),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileActions extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onToggleBlock;
  final VoidCallback onToggleFavorite;

  const _ProfileActions({
    required this.user,
    required this.onToggleBlock,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ProfileActionButton(
          icon: user.blocked ? Icons.block : Icons.block_outlined,
          color: user.blocked ? AppColors.goldLight : AppColors.ivory,
          onPressed: onToggleBlock,
        ),
        const SizedBox(width: 8),
        _ProfileActionButton(
          icon: user.favorite ? Icons.favorite : Icons.favorite_border,
          color: user.favorite ? AppColors.terracotta : AppColors.ivory,
          onPressed: onToggleFavorite,
        ),
      ],
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  const _ProfileActionButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.goldLight.withValues(alpha: 0.32)),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
