import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat_contact.dart';
import '../models/chat_message.dart';
import '../providers/chat_provider.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  final ChatContact contact;
  const ChatScreen({super.key, required this.contact});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    context.read<ChatProvider>().markContactRead(widget.contact.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text.trim();
    _controller.clear();
    setState(() => _isTyping = true);
    context.read<ChatProvider>().sendMessage(widget.contact.id, text);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.primary), onPressed: () => Navigator.pop(context)),
        title: Row(children: [
          CircleAvatar(radius: 18, backgroundColor: AppTheme.background,
            child: ClipOval(child: Image.asset(widget.contact.avatar, width: 36, height: 36, fit: BoxFit.cover, errorBuilder: (_, _, _) => const Icon(Icons.person, size: 20, color: AppTheme.primary)))),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.contact.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary, fontSize: 15)),
            const SizedBox(height: 2),
            const Text('Online', style: TextStyle(fontSize: 11, color: AppTheme.success)),
          ]),
        ]),
        actions: [IconButton(icon: const Icon(Icons.call, color: AppTheme.textSecondary), onPressed: () {}),
                   IconButton(icon: const Icon(Icons.more_vert, color: AppTheme.textSecondary), onPressed: () {})],
      ),
      body: Column(children: [
        Expanded(child: Consumer<ChatProvider>(
          builder: (context, provider, _) {
            final msgs = provider.getMessages(widget.contact.id);
            if (msgs.isEmpty && !_isTyping) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
                const SizedBox(height: 12),
                Text('Mulai obrolan dengan ${widget.contact.name}', style: const TextStyle(color: AppTheme.textSecondary)),
              ]));
            }
            return ListView.builder(
              controller: _scrollController,
              reverse: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              itemCount: msgs.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= msgs.length) {
                  return const _TypingIndicator();
                }
                final msg = msgs[index];
                return _MessageBubble(msg: msg);
              },
            );
          },
        )),
        _ChatInput(controller: _controller, onSend: _sendMessage, typing: _isTyping),
      ]),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage msg;
  const _MessageBubble({required this.msg});
  @override
  Widget build(BuildContext context) {
    final isMe = msg.isMe;
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe) const SizedBox(width: 8),
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isMe ? AppTheme.primary : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isMe ? 16 : 4),
              bottomRight: Radius.circular(isMe ? 4 : 16),
            ),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: Text(msg.text, style: TextStyle(fontSize: 14, color: isMe ? Colors.white : AppTheme.textPrimary)),
        ),
        if (isMe) const SizedBox(width: 8),
      ],
    ));
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(
    children: [
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16))),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          _Dot(delay: 0), _Dot(delay: 200), _Dot(delay: 400),
        ]),
      ),
    ],
  ));
}

class _Dot extends StatefulWidget {
  final int delay;
  const _Dot({required this.delay});
  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Interval(0.0, 1.0, curve: Curves.easeInOut)));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat();
    });
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: _animation, builder: (_, _) => Container(
    width: 6, height: 6, margin: const EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(color: AppTheme.primary.withValues(alpha: _animation.value), shape: BoxShape.circle),
  ));
}

class _ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool typing;
  const _ChatInput({required this.controller, required this.onSend, required this.typing});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))]),
    child: Row(children: [
      IconButton(icon: const Icon(Icons.attach_file, color: AppTheme.textSecondary), onPressed: () {}),
      Expanded(child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Ketik pesan...',
          hintStyle: const TextStyle(color: AppTheme.textSecondary),
          filled: true,
          fillColor: AppTheme.background,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        onSubmitted: (_) => onSend(),
      )),
      const SizedBox(width: 8),
      CircleAvatar(radius: 22, backgroundColor: AppTheme.primary,
        child: IconButton(icon: Icon(typing ? Icons.close : Icons.send, color: Colors.white, size: 20), onPressed: typing ? null : onSend)),
    ]),
  );
}
