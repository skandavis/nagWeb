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
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final msg = widget.message;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: _hovered
              ? AppColors.cream
              : msg.read
                  ? AppColors.warmWhite
                  : AppColors.ivory,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _UnreadDot(isUnread: !msg.read),
                const SizedBox(width: 16),
                AvatarCircle(
                  initials: msg.initials,
                  color: msg.sender.avatarColor,
                  size: 44,
                  fontSize: 12,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _MessageRowContent(
                    message: msg,
                    onToggleFavorite: () => setState(() => msg.favorite = !msg.favorite),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UnreadDot extends StatelessWidget {
  final bool isUnread;

  const _UnreadDot({required this.isUnread});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isUnread ? AppColors.gold : Colors.transparent,
        ),
      ),
    );
  }
}

class _MessageRowContent extends StatelessWidget {
  final Message message;
  final VoidCallback onToggleFavorite;

  const _MessageRowContent({required this.message, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.sender.name,
              style: GoogleFonts.playfairDisplay(
                fontSize: 15,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              message.subject,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            SizedBox(
              width: MediaQuery.of(context).size.width*.5,
              child: Text(
                message.body,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 13,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              message.date,
              style: GoogleFonts.cinzel(
                fontSize: 10,
                letterSpacing: 1.5,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: onToggleFavorite,
              child: Icon(
                message.favorite ? Icons.favorite : Icons.favorite_border,
                size: 16,
                color: message.favorite ? AppColors.terracotta : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
