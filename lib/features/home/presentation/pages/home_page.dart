import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';
import 'package:sipekatbc/core/session/user_session.dart';
import 'package:sipekatbc/features/education/data/article_repository.dart';
import 'package:sipekatbc/features/education/data/models/article_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final ArticleRepository _articleRepository = ArticleRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreetingSection(),
            const SizedBox(height: 24),
            _buildChatbotCard(),
            const SizedBox(height: 24),
            _buildMenuGrid(),
            const SizedBox(height: 32),
            _buildEducationSection(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: _buildCenterFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // --- APP BAR ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.08),
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

  // --- GREETING SECTION ---
  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Hello, ${UserSession.currentUser?.name ?? 'Nama Pengguna'} ',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const Text('👋', style: TextStyle(fontSize: 28)),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Yuk, tambah wawasan kesehatanmu hari ini!',
          style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  // --- CHATBOT CARD ---
  Widget _buildChatbotCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondaryGreen,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Punya pertanyaan seputar TBC\natau ragu dengan gejalanya?\nTanya SiPeka sekarang!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              // ERROR 1 DIPERBAIKI: texttextGreen menjadi textGreen
              color: AppColors.textGreen,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            icon: const Icon(Icons.chat_bubble_outline, size: 18),
            label: const Text(
              'Mulai Chat',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // --- MENU GRID ---
  Widget _buildMenuGrid() {
    final List<Map<String, dynamic>> menus = [
      {'icon': Icons.search, 'label': 'Kenali\nGejala'},
      {'icon': Icons.coronavirus_outlined, 'label': 'Cara\nPenularan'},
      {'icon': Icons.compare_arrows, 'label': 'Mitos vs\nFakta'},
      {'icon': Icons.shield_outlined, 'label': 'Pencegahan'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: menus.map((menu) {
        return Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(
                  0xFFE3E9E8,
                ), // Menggunakan kode warna dari kamu
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                menu['icon'],
                color: AppColors.primaryGreen,
                size: 28,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              menu['label'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.3,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // --- EDUCATION SECTION ---
  Widget _buildEducationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Edukasi Terbaru',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () => context.go('/education'),
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: FutureBuilder<List<Article>>(
            future: _articleRepository.fetchArticles(limit: 5),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Gagal memuat artikel'));
              }

              final articles = snapshot.data ?? [];

              if (articles.isEmpty) {
                return const Center(child: Text('Belum ada artikel'));
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemCount: articles.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final article = articles[index];
                  final coverUrl = article.coverUrl ?? '';

                  return InkWell(
                    onTap: () => context.push('/article-detail/${article.id}'),
                    child: _buildEduCard(
                      imageUrl: coverUrl,
                      title: article.title,
                      desc: _buildExcerpt(article.content),
                      time: _estimateReadTime(article.content),
                      isNew: index == 0,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String _buildExcerpt(String content) {
    final normalized = content.replaceAll(RegExp(r'\s+'), ' ').trim();

    if (normalized.isEmpty) {
      return 'Belum ada ringkasan artikel.';
    }

    if (normalized.length <= 90) {
      return normalized;
    }

    return '${normalized.substring(0, 87)}...';
  }

  String _estimateReadTime(String content) {
    final normalized = content.replaceAll(RegExp(r'\s+'), ' ').trim();

    if (normalized.isEmpty) {
      return '1 menit baca';
    }

    final wordCount = normalized.split(' ').length;
    final minutes = (wordCount / 200).ceil();
    final displayMinutes = minutes < 1 ? 1 : minutes;

    return '$displayMinutes menit baca';
  }

  Widget _buildEduCard({
    required String imageUrl,
    required String title,
    required String desc,
    required String time,
    required bool isNew,
  }) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ERROR 2 DIPERBAIKI: withOpacity menjadi withValues
            color: Colors.grey.withValues(alpha: 0.08),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                  imageUrl,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (isNew)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      // ERROR 2 DIPERBAIKI: withOpacity menjadi withValues
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Baru',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.grayIcon,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grayIcon,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- FLOATING ACTION BUTTON ---
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

  // --- BOTTOM NAVIGATION BAR ---
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
                  _buildNavItem(Icons.home_outlined, 'Home', true, () {}),
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
                  _buildNavItem(
                    Icons.menu_book,
                    'Education',
                    false,
                    () => context.go('/education'),
                  ),
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
