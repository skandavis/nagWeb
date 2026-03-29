import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';

class MessageDetailScreen extends StatefulWidget {
  final Message message;

  const MessageDetailScreen({super.key, required this.message});

  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  final _replyController = TextEditingController();
  final _subjectController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailAppBar(
        title: 'Message',
        trailing: _MessageFavoriteAction(
          message: widget.message,
          onToggle: () => setState(() => widget.message.favorite = !widget.message.favorite),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F1E7),
              AppColors.warmWhite,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: purplePanel(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    _SubjectHeading(subject: widget.message.subject),
                    const SizedBox(height: 28),
                    _SenderRow(message: widget.message),
                    const SizedBox(height: 28),
                    _BodyText(body: widget.message.body),
                    const SizedBox(height: 28),
                    _ReplySection(
                      bodyController: _replyController,
                      subjectController: _subjectController,
                      onSend: () => _sendReply(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendReply(BuildContext context) {
    if (_replyController.text.trim().isEmpty &&
        _subjectController.text.trim().isEmpty) {
      return;
    }
    _replyController.clear();
    _subjectController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Your reply has been sent.',
          style: GoogleFonts.cormorantGaramond(fontSize: 18),
        ),
        backgroundColor: AppColors.deepThemeColor,
      ),
    );
  }
}

class _MessageFavoriteAction extends StatelessWidget {
  const _MessageFavoriteAction({
    required this.message,
    required this.onToggle,
  });

  final Message message;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.goldLight.withValues(alpha: 0.32)),
      ),
      child: IconButton(
        onPressed: onToggle,
        tooltip: message.favorite ? 'Remove favorite' : 'Add favorite',
        icon: Icon(
          message.favorite ? Icons.favorite : Icons.favorite_border,
          size: 18,
          color: message.favorite ? AppColors.terracotta : AppColors.ivory,
        ),
      ),
    );
  }
}

class _SubjectHeading extends StatelessWidget {
  const _SubjectHeading({required this.subject});

  final String subject;

  @override
  Widget build(BuildContext context) {
    return Text(
      subject,
      style: GoogleFonts.playfairDisplay(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.2,
      ),
    );
  }
}

class _SenderRow extends StatelessWidget {
  const _SenderRow({required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          AvatarCircle(
            initials: message.initials,
            color: message.sender.avatarColor,
            size: 62,
            fontSize: 17,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender.name,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message.date,
                  style: GoogleFonts.cinzel(
                    fontSize: 9,
                    letterSpacing: 2.5,
                    color: AppColors.imperialPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText({required this.body});

  final String body;

  @override
  Widget build(BuildContext context) {
    final normalizedBody = body.replaceAll(RegExp(r'\s+'), ' ').trim();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.56),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        normalizedBody,
        style: GoogleFonts.cormorantGaramond(
          fontSize: 22,
          color: AppColors.textSecondary,
          height: 1.7,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ReplySection extends StatelessWidget {
  const _ReplySection({
    required this.bodyController,
    required this.subjectController,
    required this.onSend,
  });

  final TextEditingController bodyController;
  final TextEditingController subjectController;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.46),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          messageInput(
            controller: subjectController,
            maxLines: 1,
            hintText: 'Write your subject here...',
          ),
          const SizedBox(height: 14),
          messageInput(
            controller: bodyController,
            maxLines: 6,
            hintText: 'Write your body here...',
          ),
          const SizedBox(height: 18),
          FilledCtaButton(
            label: 'Send Reply',
            onTap: onSend,
            backgroundColor: AppColors.royalPlum,
          ),
        ],
      ),
    );
  }
}
