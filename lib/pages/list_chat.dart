import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({super.key});

  final List<Map<String, String>> chats = [
    {
      'name': 'Nike Official',
      'message': 'Segera Pesan Sebelum Kehabisan',
      'time': '12:30',
      'avatar': 'images/1.png',
    },
    {
      'name': 'Expander',
      'message': 'Halo, Selamat Datang di Nike Official.',
      'time': '12:05',
      'avatar': 'images/1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppTheme.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'List Chat',
          style: AppTheme.heading2,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 8),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Semua',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Belum Dibaca',
                    style: TextStyle(color: AppTheme.textSecondaryColor),
                  ),
                ),
              ],
            ),
          ),

          // Chat List
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: AppTheme.backgroundColor,
                    child: ClipOval(
                      child: Image.asset(
                        chat['avatar']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.person,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    chat['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    chat['message']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: SizedBox(
                    height: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          chat['time']!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        if (index == 0) ...[
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "ChatDetail");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
