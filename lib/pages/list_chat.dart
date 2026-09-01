import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../theme/app_theme.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({super.key});

  final List<Map<String, String>> chats = [
    {'name': 'Nike Official', 'message': 'Segera Pesan Sebelum Kehabisan', 'time': '12:30', 'avatar': 'images/1.png'},
    {'name': 'Expander', 'message': 'Halo, Selamat Datang di Nike Official.', 'time': '12:05', 'avatar': 'images/1.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppTheme.primary,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Chat', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.primary),
            onPressed: () {},
          ),
          if (chatProvider.totalUnread > 0)
            Badge(
              isLabelVisible: true,
              label: Text('${chatProvider.totalUnread}'),
              child: const Icon(Icons.notifications_none, color: AppTheme.primary),
            ),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(children: [
            _TabChip(label: 'Semua', active: true),
            const SizedBox(width: 10),
            _TabChip(label: 'Belum Dibaca', active: false),
          ]),
        ),
        Expanded(child: ListView.builder(
          itemCount: chatProvider.contacts.length,
          itemBuilder: (context, index) {
            final contact = chatProvider.contacts[index];
            final msgs = chatProvider.getMessages(contact.id);
            final lastMsg = msgs.isEmpty ? 'Mulai obrolan...' : msgs.last.text;
            final lastTime = msgs.isEmpty ? '--:--' : msgs.last.time;
            return ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: AppTheme.background,
                child: ClipOval(
                  child: Image.asset(contact.avatar, width: 50, height: 50, fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(Icons.person, size: 28, color: AppTheme.primary)),
                ),
              ),
              title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              subtitle: Text(lastMsg, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppTheme.textSecondary)),
              trailing: SizedBox(
                height: 40,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(lastTime, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  if (contact.unread) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                      child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ]),
              ),
              onTap: () {
                chatProvider.markContactRead(contact.id);
                Navigator.pushNamed(context, 'ChatDetail', arguments: contact);
              },
            );
          },
        )),
      ]),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool active;
  const _TabChip({required this.label, required this.active});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: active ? AppTheme.primary.withValues(alpha: 0.1) : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: active ? AppTheme.primary : AppTheme.border),
    ),
    child: Text(label, style: TextStyle(fontSize: 13, fontWeight: active ? FontWeight.bold : FontWeight.normal, color: active ? AppTheme.primary : AppTheme.textSecondary)),
  );
}
