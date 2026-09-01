class ChatContact {
  final String id;
  final String name;
  final String avatar;
  bool unread;

  ChatContact({
    required this.id,
    required this.name,
    required this.avatar,
    this.unread = false,
  });
}
