import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';

class AccountPage extends StatelessWidget {
  final bool isEmbedded;
  const AccountPage({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(slivers: [
        SliverAppBar(automaticallyImplyLeading: !isEmbedded, backgroundColor: AppTheme.primary, expandedHeight: 160, pinned: true, flexibleSpace: FlexibleSpaceBar(
          title: const Text('Akun Saya', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
          background: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight)))),
          actions: [IconButton(icon: const Icon(Icons.settings_outlined, color: Colors.white), onPressed: () {})]),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
          _ProfileCard(user?.name ?? 'John Doe', user?.email ?? 'johndoe@example.com'),
          const SizedBox(height: 16),
          _MenuSection(context),
        ]))),
      ]),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String name, email;
  const _ProfileCard(this.name, this.email);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Container(width: 64, height: 64, decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.person, size: 32, color: AppTheme.primary)),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
          const SizedBox(height: 4),
          Text(email, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
        ])),
      ]),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection(this.context);
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.person_outline, 'title': 'Profil', 'route': '/accountPage'},
      {'icon': Icons.receipt_long, 'title': 'Riwayat Pesanan', 'route': 'OrderHistoryPage'},
      {'icon': Icons.lock_outline, 'title': 'Ubah Password', 'route': 'ChangePasswordPage'},
      {'icon': Icons.notifications_none, 'title': 'Notifikasi', 'route': '/notifications'},
      {'icon': Icons.help_outline, 'title': 'Bantuan', 'route': '/help'},
      {'icon': Icons.logout, 'title': 'Keluar', 'route': '_logout'},
    ];
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (item['route'] == '_logout') {
                  _showLogoutDialog(context);
                } else {
                  Navigator.pushNamed(context, item['route'] as String);
                }
              },
              borderRadius: BorderRadius.vertical(bottom: isLast ? const Radius.circular(16) : Radius.zero),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(10)),
                      child: Icon(item['icon'] as IconData, color: AppTheme.primary, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(item['title'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
                    ),
                    const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
  void _showLogoutDialog(BuildContext ctx) {
    showDialog(context: ctx, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Keluar'), content: const Text('Yakin ingin keluar?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
        ElevatedButton(onPressed: () { Provider.of<AuthProvider>(ctx, listen: false).logout(); Navigator.pop(ctx); Navigator.pushReplacementNamed(ctx, 'LoginPage'); },
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: const Text('Keluar')),
      ],
    ));
  }
}
