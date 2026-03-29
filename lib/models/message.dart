import 'package:matrimonial/models/models.dart';

class Message {
  final int id;
  final String subject;
  final String date;
  final UserProfile sender;
  bool read;
  final String body;
  bool favorite;

  Message({
    required this.id,
    required this.subject,
    required this.date,
    required this.read,
    required this.body,
    required this.sender,
    this.favorite = false,
  });

  String get initials {
    final parts = sender.name.split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return sender.name[0];
  }
}
