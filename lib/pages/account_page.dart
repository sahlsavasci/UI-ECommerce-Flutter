import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/order_provider.dart';
import '../theme/app_theme.dart';

class AccountPage extends StatelessWidget {
  final bool isEmbedded;
  const AccountPage({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final user = authProvider.user;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(child: CustomScrollView(slivers: [
        // Header
        SliverAppBar(
          automaticallyImplyLeading: !isEmbedded,
          backgroundColor: AppTheme.primary,
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Akun Saya',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            titlePadding: const EdgeInsets.only(left: 16, bottom: 14),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(children: [
                Positioned(
                  right: -30, top: -30,
                  child: Container(width: 140, height: 140,
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.07), shape: BoxShape.circle),
                  ),
                ),
                Positioned(
                  left: -20, bottom: -20,
                  child: Container(width: 100, height: 100,
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), shape: BoxShape.circle),
                  ),
                ),
              ]),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        // Avatar + stats
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4)),
              ]),
              child: Row(children: [
                Container(width: 64, height: 64, decoration: BoxDecoration(color: AppTheme.primaryLight, borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.person, size: 32, color: AppTheme.primary)),
                const SizedBox(width: 16),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(user?.name ?? 'John Doe', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  const SizedBox(height: 4),
                  Text(user?.email ?? 'johndoe@example.com', style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                  const SizedBox(height: 8),
                  Row(children: [
                    _statBadge(count: '${orderProvider.totalOrders}', label: 'Pesanan'),
                    const SizedBox(width: 8),
                    _statBadge(count: '0', label: 'Wishlist'),
                  ]),
                ])),
              ]),
            ),
          ),
        ),
        // Menu sections
        SliverToBoxAdapter(child: const SizedBox(height: 16)),
        SliverToBoxAdapter(child: _buildSectionTitle('Akun')),
        SliverToBoxAdapter(child: _MenuList(context, items: [
          MenuItem(icon: Icons.person_outline, title: 'Profil', route: '/accountPage'),
          MenuItem(icon: Icons.lock_outline, title: 'Ubah Password', route: 'ChangePasswordPage'),
          MenuItem(icon: Icons.notifications_none, title: 'Notifikasi', route: '/notifications'),
        ])),
        SliverToBoxAdapter(child: const SizedBox(height: 8)),
        SliverToBoxAdapter(child: _buildSectionTitle('Pesanan')),
        SliverToBoxAdapter(child: _MenuList(context, items: [
          MenuItem(icon: Icons.receipt_long, title: 'Riwayat Pesanan', route: 'OrderHistoryPage'),
          MenuItem(icon: Icons.local_shipping_outlined, title: 'Lacak Pesanan', route: '/notifications'),
        ])),
        SliverToBoxAdapter(child: const SizedBox(height: 8)),
        SliverToBoxAdapter(child: _buildSectionTitle('Lainnya')),
        SliverToBoxAdapter(child: _MenuList(context, items: [
          MenuItem(icon: Icons.help_outline, title: 'Bantuan', route: '/help'),
          MenuItem(icon: Icons.logout, title: 'Keluar', route: '_logout', isDestructive: true),
        ])),
        SliverToBoxAdapter(child: const SizedBox(height: 24)),
      ])),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
    child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
  );

  Widget _statBadge({required String count, required String label}) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Text(count, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primary)),
        Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
      ]),
    ),
  );
}

class _MenuList extends StatelessWidget {
  final BuildContext context;
  final List<MenuItem> items;
  const _MenuList(this.context, {required this.items});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (item.route == '_logout') {
                  _showLogoutDialog(context);
                } else {
                  Navigator.pushNamed(context, item.route);
                }
              },
              borderRadius: BorderRadius.vertical(bottom: isLast ? const Radius.circular(16) : Radius.zero),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: item.isDestructive ? AppTheme.error.withValues(alpha: 0.1) : AppTheme.background, borderRadius: BorderRadius.circular(10)),
                    child: Icon(item.icon, color: item.isDestructive ? AppTheme.error : AppTheme.primary, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Text(item.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: item.isDestructive ? AppTheme.error : AppTheme.textPrimary))),
                  Icon(Icons.chevron_right, color: AppTheme.textSecondary),
                ]),
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
        ElevatedButton(onPressed: () {
          Provider.of<AuthProvider>(ctx, listen: false).logout();
          Navigator.pop(ctx);
          Navigator.pushReplacementNamed(ctx, 'LoginPage');
        },
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: const Text('Keluar')),
      ],
    ));
  }
}

class MenuItem {
  final IconData icon;
  final String title;
  final String route;
  final bool isDestructive;
  const MenuItem({required this.icon, required this.title, required this.route, this.isDestructive = false});
}
