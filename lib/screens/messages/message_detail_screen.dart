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
      backgroundColor: AppColors.warmWhite,
      appBar: detailAppBar(
        title: 'Message',
        trailing: _MessageFavoriteAction(
          message: widget.message,
          onToggle: () => setState(() => widget.message.favorite = !widget.message.favorite),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionEyebrow(text: 'Messages'),
                  const SizedBox(height: 20),
                  _SubjectHeading(subject: widget.message.subject),
                  const SizedBox(height: 32),
                  _SenderRow(message: widget.message),
                  const SizedBox(height: 40),
                  _BodyText(body: widget.message.body),
                  const SizedBox(height: 64),
                  const GoldDivider(),
                  const SizedBox(height: 40),
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
    );
  }

  void _sendReply(BuildContext context) {
    if (_replyController.text.trim().isEmpty && _subjectController.text.trim().isEmpty) return;
    _replyController.clear();
    _subjectController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Your reply has been sent.',
          style: GoogleFonts.cormorantGaramond(fontSize: 15),
        ),
        backgroundColor: AppColors.deepThemeColor,
      ),
    );
  }
}

class _MessageFavoriteAction extends StatelessWidget {
  final Message message;
  final VoidCallback onToggle;

  const _MessageFavoriteAction({required this.message, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggle,
      tooltip: message.favorite ? 'Remove favorite' : 'Add favorite',
      icon: Icon(
        message.favorite ? Icons.favorite : Icons.favorite_border,
        size: 18,
        color: message.favorite ? AppColors.terracotta : AppColors.textMuted,
      ),
    );
  }
}

class _SubjectHeading extends StatelessWidget {
  final String subject;

  const _SubjectHeading({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Text(
      subject,
      style: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.3,
      ),
    );
  }
}

class _SenderRow extends StatelessWidget {
  final Message message;

  const _SenderRow({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        children: [
          AvatarCircle(
            initials: message.initials,
            color: message.sender.avatarColor,
            size: 52,
            fontSize: 14,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.sender.name,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message.date,
                style: GoogleFonts.cinzel(
                  fontSize: 9,
                  letterSpacing: 2,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  final String body;

  const _BodyText({required this.body});

  @override
  Widget build(BuildContext context) {
    final normalizedBody = body.replaceAll(RegExp(r'\s+'), ' ').trim();

    return Text(
      normalizedBody,
      style: GoogleFonts.cormorantGaramond(
        fontSize: 17,
        color: AppColors.textSecondary,
        height: 1.9,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _ReplySection extends StatelessWidget {
  final TextEditingController bodyController;
  final TextEditingController subjectController;
  final VoidCallback onSend;

  const _ReplySection({required this.bodyController, required this.subjectController, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR REPLY',
          style: GoogleFonts.cinzel(
            fontSize: 10,
            letterSpacing: 2.5,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 14),
        messageInput(controller: subjectController, maxLines: 1, hintText: 'Write your subject here...'),
        const SizedBox(height: 14),
        messageInput(controller: bodyController, maxLines: 6, hintText: 'Write your body here...'),
        const SizedBox(height: 14),
        FilledCtaButton(
          label: 'Send Reply',
          onTap: onSend,
          backgroundColor: AppColors.deepThemeColor,
        ),
      ],
    );
  }
}
