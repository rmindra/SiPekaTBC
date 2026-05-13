import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';
import 'package:sipekatbc/core/session/user_session.dart';
import 'package:sipekatbc/features/education/data/article_repository.dart';
import 'package:sipekatbc/features/education/data/models/article_model.dart';

import '../widgets/category_filter_item.dart';
import '../widgets/education_article_card.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  String selectedCategory = 'Semua';
  String _searchQuery = '';
  final ArticleRepository _repository = ArticleRepository();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final List<Article> _articles = [];
  Map<String, int> _progressByArticleId = {};
  bool _isLoading = false;
  bool _hasMore = true;
  String? _errorMessage;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadInitial();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadInitial() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final articles = await _repository.fetchArticles(limit: _pageSize);
      final progressMap = await _repository.fetchReadingProgressMap();

      setState(() {
        _articles
          ..clear()
          ..addAll(articles);
        _progressByArticleId = progressMap;
        _hasMore = articles.length == _pageSize;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat artikel';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _refreshData() async {
    await _loadInitial();
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final next = await _repository.fetchArticles(
        limit: _pageSize,
        offset: _articles.length,
      );

      setState(() {
        _articles.addAll(next);
        _hasMore = next.length == _pageSize;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat artikel';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Konten Utama
          Column(
            children: [
              _buildSearchAndFilter(),
              Expanded(child: _buildArticleList()),
            ],
          ),

          // --- TAMBAHAN: Button + di pojok kanan bawah ---
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              heroTag:
                  'add_article_btn', // Penting agar tidak bentrok dengan FAB Chatbot
              onPressed: () async {
                await context.push('/create-article');
                await _refreshData();
              },
              backgroundColor: AppColors.primaryGreen,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildCenterFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'SiPekaTBC',
        style: TextStyle(
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.grayForm,
            child: ClipOval(
              child: UserSession.currentUser?.avatarUrl != null
                  ? Image.network(
                      UserSession.currentUser!.avatarUrl!,
                      fit: BoxFit.cover,
                      width: 36,
                      height: 36,
                    )
                  : const Icon(Icons.person, color: AppColors.grayIcon),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim();
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari artikel edukasi...',
                hintStyle: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search, color: AppColors.grayIcon),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.grayForm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.grayForm),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primaryGreen),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CategoryFilterItem(
                  label: 'Semua',
                  isActive: selectedCategory == 'Semua',
                  onTap: () => setState(() => selectedCategory = 'Semua'),
                ),
                CategoryFilterItem(
                  label: 'Gejala',
                  isActive: selectedCategory == 'Gejala',
                  onTap: () => setState(() => selectedCategory = 'Gejala'),
                ),
                CategoryFilterItem(
                  label: 'Pengobatan',
                  isActive: selectedCategory == 'Pengobatan',
                  onTap: () => setState(() => selectedCategory = 'Pengobatan'),
                ),
                CategoryFilterItem(
                  label: 'Mitos',
                  isActive: selectedCategory == 'Mitos',
                  onTap: () => setState(() => selectedCategory = 'Mitos'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- BAGIAN YANG DITAMBAHKAN ONTAP ---
  Widget _buildArticleList() {
    if (_errorMessage != null && _articles.isEmpty) {
      return Center(child: Text(_errorMessage!));
    }

    if (_isLoading && _articles.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_articles.isEmpty) {
      return const Center(child: Text('Belum ada artikel'));
    }

    final filteredArticles = _articles.where((article) {
      if (selectedCategory == 'Semua') {
        return _matchesSearch(article);
      }

      final matchesCategory =
          article.category.toLowerCase() == selectedCategory.toLowerCase();

      return matchesCategory && _matchesSearch(article);
    }).toList();

    if (filteredArticles.isEmpty) {
      return const Center(child: Text('Kategori belum tersedia'));
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        itemCount: filteredArticles.length + (_hasMore ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          if (index >= filteredArticles.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final article = filteredArticles[index];
          final progress = _progressByArticleId[article.id] ?? 0;
          final coverUrl = article.coverUrl ?? '';

          return InkWell(
            onTap: () async {
              await context.push('/article-detail/${article.id}');
              await _refreshData();
            },
            child: EducationArticleCard(
              category: article.category.toUpperCase(),
              title: article.title,
              isRead: progress >= 1,
              imageUrl: coverUrl,
            ),
          );
        },
      ),
    );
  }

  bool _matchesSearch(Article article) {
    if (_searchQuery.isEmpty) {
      return true;
    }

    final query = _searchQuery.toLowerCase();

    return article.title.toLowerCase().contains(query) ||
        article.content.toLowerCase().contains(query) ||
        article.category.toLowerCase().contains(query);
  }

  Widget _buildCenterFAB() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 65,
      width: 65,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryGreen,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(
          Icons.smart_toy_outlined,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      elevation: 10,
      child: SizedBox(
        height: 65,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    Icons.home_outlined,
                    'Home',
                    false,
                    () => context.go('/dashboard'),
                  ),
                  _buildNavItem(
                    Icons.map_outlined,
                    'Maps',
                    false,
                    () => context.go('/maps'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 72),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.menu_book, 'Education', true, () {}),
                  _buildNavItem(
                    Icons.person_outline,
                    'Profile',
                    false,
                    () => context.go('/profile'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          // Jika aktif, beri background hijau pudar seperti di desain UI
          color: isActive
              ? AppColors.primaryGreen.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primaryGreen : AppColors.grayIcon,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? AppColors.primaryGreen : AppColors.grayIcon,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
