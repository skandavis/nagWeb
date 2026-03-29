import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/data.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import 'message_detail_screen.dart';
import 'message_row.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Message> get _messages =>
      totalMessages.where((message) => !message.sender.blocked).toList();

  void _openMessage(Message message) {
    setState(() => message.read = true);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MessageDetailScreen(message: message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = _messages;
    final unreadCount = messages.where((message) => !message.read).length;

    return Container(
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InboxHeader(unreadCount: unreadCount),
            const SizedBox(height: 24),
            Expanded(
              child: messages.isEmpty
                  ? const _EmptyInbox()
                  : purplePanel(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
                      child: ListView.separated(
                        itemCount: messages.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, i) => MessageRow(
                          message: messages[i],
                          onTap: () => _openMessage(messages[i]),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InboxHeader extends StatelessWidget {
  const _InboxHeader({
    required this.unreadCount,
  });

  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 720;

        final title = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Messages',
              style: GoogleFonts.playfairDisplay(
                fontSize: 36,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            if (unreadCount > 0) const SizedBox(height: 10),
          ],
        );

        final stats = _StatPill(label: 'Unread', value: '$unreadCount');

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              const SizedBox(height: 20),
              stats,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: title),
            const SizedBox(width: 20),
            stats,
          ],
        );
      },
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.royalPlum,
            AppColors.imperialPurple,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.cinzel(
              fontSize: 9,
              letterSpacing: 2.2,
              color: AppColors.ivory.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              color: AppColors.ivory,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyInbox extends StatelessWidget {
  const _EmptyInbox();

  @override
  Widget build(BuildContext context) {
    return purplePanel(
      padding: const EdgeInsets.all(28),
      child: Center(
        child: Text(
          'No more messages.',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 22,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
