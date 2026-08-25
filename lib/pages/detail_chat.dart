import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;

  const ChatScreen({super.key, required this.contactName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Daftar pesan obrolan awal secara lokal
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hallo',
      'isMe': true,
      'time': '12:40'
    },
    {
      'text': 'Ada yang bisa di bantu?',
      'isMe': false,
      'time': '12:42'
    }
  ];

  final TextEditingController _controller = TextEditingController();

  // Helper untuk memformat waktu saat ini ke format HH:mm
  String _formatCurrentTime() {
    final now = TimeOfDay.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  // Fungsi untuk mengirim pesan baru secara lokal
  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          'text': _controller.text.trim(),
          'isMe': true,
          'time': _formatCurrentTime()
        });
      });
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contactName,
          style: const TextStyle(color: Color(0xFF4C53A5), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF4C53A5)),
      ),
      body: Column(
        children: [
          // Area tampilan chat
          Expanded(
            child: ListView.builder(
              reverse: true, // Urutan terbalik (pesan terbaru di bawah)
              itemCount: messages.length,
              itemBuilder: (context, index) {
                // Membalik indeks agar pesan yang ditambahkan terakhir muncul di bagian bawah
                final message = messages[messages.length - index - 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Align(
                    alignment: message['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: message['isMe'] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        // Balon Chat (Bubble Chat)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            // Warna oranye muda untuk pengirim (isMe: true), abu-abu muda untuk penerima (isMe: false)
                            color: message['isMe'] ? Colors.orange[100] : Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(message['isMe'] ? 16 : 0),
                              bottomRight: Radius.circular(message['isMe'] ? 0 : 16),
                            ),
                          ),
                          child: Text(
                            message['text'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black, // Teks berwarna hitam agar kontras dan mudah dibaca
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Menampilkan string waktu (timestamp) di bawah balon chat
                        Text(
                          message['time'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Area input teks chat
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF4C53A5),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
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