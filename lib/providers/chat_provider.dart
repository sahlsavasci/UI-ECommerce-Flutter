import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/chat_contact.dart';
import '../models/chat_message.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatContact> _contacts = [
    ChatContact(id: 'nike', name: 'Nike Official', avatar: 'images/1.png', unread: true),
    ChatContact(id: 'adidas', name: 'Adidas Store', avatar: 'images/2.png', unread: true),
    ChatContact(id: 'zara', name: 'Zara Fashion', avatar: 'images/3.png', unread: false),
    ChatContact(id: 'uniqlo', name: 'Uniqlo ID', avatar: 'images/4.png', unread: false),
    ChatContact(id: 'h&M', name: 'H&M Indonesia', avatar: 'images/5.png', unread: true),
  ];

  final Map<String, List<ChatMessage>> _messages = {};

  List<ChatContact> get contacts => List.unmodifiable(_contacts);
  List<ChatMessage> getMessages(String contactId) => List.unmodifiable(_messages[contactId] ?? []);

  int get totalUnread => _contacts.where((c) => c.unread).length;

  void markAllRead() {
    for (final c in _contacts) {
      c.unread = false;
    }
    notifyListeners();
  }

  void markContactRead(String contactId) {
    final c = _contacts.firstWhere((c) => c.id == contactId, orElse: () => _contacts[0]);
    c.unread = false;
    notifyListeners();
  }

  void sendMessage(String contactId, String text) {
    _messages.putIfAbsent(contactId, () => []);
    final now = DateTime.now();
    _messages[contactId]!.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isMe: true,
      time: '${now.hour}:${now.minute.toString().padLeft(2, '0')}',
    ));
    notifyListeners();
    _simulateReply(contactId);
  }

  void _simulateReply(String contactId) {
    Timer(const Duration(seconds: 1), () {
      final replies = _getDummyReply(contactId);
      final now = DateTime.now();
      _messages.putIfAbsent(contactId, () => []);
      _messages[contactId]!.add(ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: replies,
        isMe: false,
        time: '${now.hour}:${now.minute.toString().padLeft(2, '0')}',
      ));
      notifyListeners();
    });
  }

  String _getDummyReply(String contactId) {
    final replies = {
      'nike': [
        'Halo! Terima kasih sudah menghubungi Nike Official 😊',
        'Produk yang kamu tanyakan sedang promo 20% hari ini!',
        'Besok barang akan sampai. Terima kasih!',
        'Ada yang bisa kami bantu lagi? 🙌',
      ],
      'adidas': [
        'Hai! Selamat datang di Adidas Indonesia 🏃',
        'Untuk ukuran XL masih tersedia, ready stock!',
        'Promo gratis ongkir untuk pembelian di atas 500rb ya!',
        'Sip, pesanan sudah kami proses. Semoga puas! 💪',
      ],
      'zara': [
        'Halo! Terima kasih telah menghubungi Zara Fashion ✨',
        'Koleksi baru musim panas sudah datang lho!',
        'Bisa kami ganti warna atau ukurannya ya.',
        'Terima kasih! Happy shopping! 🛍️',
      ],
      'uniqlo': [
        'Selamat datang di Uniqlo Indonesia! 👋',
        'HEATTECH series terbaru sudah ready stock.',
        'Diskon 30% untuk member baru ya!',
        'Barang sudah dikirim via JNE, estimasi 2-3 hari.',
      ],
      'h&M': [
        'Hi! Welcome to H&M Indonesia 🎉',
        'Sale season sedang berlangsung, diskon up to 50%!',
        'Untuk size M masih tersedia, mau kami pesan?',
        'Trims! Pesanan kamu akan segera diproses. 📦',
      ],
    };
    final list = replies[contactId] ?? ['Terima kasih! Kami akan membalas segera.'];
    return list[(DateTime.now().second % list.length)];
  }
}
