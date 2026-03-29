import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class MessageRow extends StatefulWidget {
  final Message message;
  final VoidCallback onTap;

  const MessageRow({super.key, required this.message, required this.onTap});

  @override
  State<MessageRow> createState() => _MessageRowState();
}

class _MessageRowState extends State<MessageRow> {

  @override
  Widget build(BuildContext context) {
    final msg = widget.message;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color:  msg.read
                  ? Colors.white
                  : AppColors.marble,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 640;
    
              return compact
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LeadRow(message: msg),
                        const SizedBox(height: 16),
                        _MessageRowContent(
                          message: msg,
                          stacked: true,
                          onToggleFavorite: () =>
                              setState(() => msg.favorite = !msg.favorite),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LeadRow(message: msg),
                        const SizedBox(width: 18),
                        Expanded(
                          child: _MessageRowContent(
                            message: msg,
                            stacked: false,
                            onToggleFavorite: () => setState(
                              () => msg.favorite = !msg.favorite,
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _LeadRow extends StatelessWidget {
  const _LeadRow({required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _UnreadSeal(isUnread: !message.read),
        const SizedBox(width: 14),
        AvatarCircle(
          initials: message.initials,
          color: message.sender.avatarColor,
          size: 52,
          fontSize: 14,
        ),
      ],
    );
  }
}

class _UnreadSeal extends StatelessWidget {
  const _UnreadSeal({required this.isUnread});

  final bool isUnread;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isUnread ? AppColors.gold : Colors.transparent,
        border: Border.all(
          color: isUnread ? AppColors.goldDeep : AppColors.borderStrong,
          width: 1.3,
        ),
      ),
    );
  }
}

class _MessageRowContent extends StatelessWidget {
  const _MessageRowContent({
    required this.message,
    required this.stacked,
    required this.onToggleFavorite,
  });

  final Message message;
  final bool stacked;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.sender.name,
          style: GoogleFonts.playfairDisplay(
            fontSize: 21,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          message.subject,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 20,
            color: AppColors.imperialPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          message.body,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 18,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        ),
      ],
    );

    final right = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message.date,
            style: GoogleFonts.cinzel(
              fontSize: 10,
              letterSpacing: 1.5,
              color: AppColors.imperialPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: onToggleFavorite,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                message.favorite ? Icons.favorite : Icons.favorite_border,
                size: 18,
                color: message.favorite ? AppColors.terracotta : AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );

    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          left,
          const SizedBox(height: 14),
          right,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 18),
        right,
      ],
    );
  }
}
