import 'package:flutter/material.dart';
import 'package:matrimonial/widgets/widgets.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import 'profile_image_gallery.dart';
import 'profile_detail_info.dart';

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
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              children: [
                ProfileImageGallery(imageUrls: widget.user.imageUrls),
                ProfileDetailInfo(user: widget.user),
              ],
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
        _ProfileBlockAction(user: user, onToggle: onToggleBlock),
        _ProfileFavoriteAction(user: user, onToggle: onToggleFavorite),
      ],
    );
  }
}

class _ProfileBlockAction extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onToggle;

  const _ProfileBlockAction({required this.user, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggle,
      tooltip: user.blocked ? 'Unblock profile' : 'Block profile',
      icon: Icon(
        user.blocked ? Icons.block : Icons.block_outlined,
        size: 18,
        color: user.blocked ? AppColors.deepThemeColor : AppColors.textMuted,
      ),
    );
  }
}

class _ProfileFavoriteAction extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onToggle;

  const _ProfileFavoriteAction({required this.user, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggle,
      tooltip: user.favorite ? 'Remove favorite' : 'Add favorite',
      icon: Icon(
        user.favorite ? Icons.favorite : Icons.favorite_border,
        size: 18,
        color: user.favorite ? AppColors.terracotta : AppColors.textMuted,
      ),
    );
  }
}
