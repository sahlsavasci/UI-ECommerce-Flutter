class ChatMessage {
  final String id;
  final String text;
  final bool isMe;
  final String time;
  final String? senderName;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
    this.senderName,
  });
}
