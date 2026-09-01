import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/categories_widget.dart';
import '../widgets/items_widget.dart';
import '../widgets/bottom_navbar.dart';
import 'account_page.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() { _pageController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().totalItemCount;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomePageContent(),
          CartPage(isEmbedded: true, hideBottomBar: true),
          AccountPage(isEmbedded: true),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        cartBadge: cartCount > 0 ? cartCount : null,
        onTap: (i) {
          setState(() => _currentIndex = i);
          _pageController.jumpToPage(i);
        },
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const SliverToBoxAdapter(child: HomeAppBar()),
      const SliverToBoxAdapter(child: SizedBox(height: 12)),
      const SliverToBoxAdapter(child: _SearchBar()),
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      const SliverToBoxAdapter(child: CategoriesWidget()),
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      const SliverToBoxAdapter(child: _PromoBanner()),
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      const SliverToBoxAdapter(child: _SectionHeader(title: 'Produk Terlaris')),
      SliverToBoxAdapter(child: ItemsWidget()),
      const SliverToBoxAdapter(child: SizedBox(height: 80)),
    ]);
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2)),
        ]),
        child: Row(
          children: [
            const Icon(Icons.search, size: 20, color: AppTheme.textSecondary),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(border: InputBorder.none, hintText: 'Search Products', hintStyle: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.tune, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 4),
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.mic, size: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Lower Shelf\nPrices', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: const Text('See Deals', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primary)),
              ),
            ])),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 12),
              width: 80, height: 80,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.percent, size: 48, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
      TextButton(onPressed: () {}, child: const Text('See All', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600))),
    ]),
  );
}
