import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/data.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import 'message_row.dart';
import 'message_detail_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Message> get _messages =>
      totalMessages.where((message) => !message.sender.blocked).toList();

  int get _unreadCount => _messages.where((m) => !m.read).length;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InboxHeader(unreadCount: _unreadCount),
        Expanded(
          child: _messages.isEmpty
              ? const _EmptyInbox()
              : ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, i) => MessageRow(
                    message: _messages[i],
                    onTap: () => _openMessage(_messages[i]),
                  ),
                ),
        ),
      ],
    );
  }
}

class _InboxHeader extends StatelessWidget {
  final int unreadCount;

  const _InboxHeader({required this.unreadCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 48, 40, 32),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionEyebrow(text: 'Your Inbox'),
              const SizedBox(height: 16),
              Text(
                'Messages',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.gold,
              child: Text(
                '$unreadCount UNREAD',
                style: GoogleFonts.cinzel(
                  fontSize: 9,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
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
    return Center(
      child: Text(
        'No messages to display.',
        style: GoogleFonts.cormorantGaramond(
          fontSize: 20,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
