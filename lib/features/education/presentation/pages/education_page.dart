import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';
import 'package:sipekatbc/core/session/user_session.dart';

import '../widgets/category_filter_item.dart';
import '../widgets/education_article_card.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  String selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: _buildArticleList(),
          ),
        ],
      ),
      floatingActionButton: _buildCenterFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // --- PERBAIKAN: AppBar disamakan persis dengan HomePage ---
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
              decoration: InputDecoration(
                hintText: 'Cari artikel edukasi...',
                hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppColors.grayIcon),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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

  Widget _buildArticleList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        EducationArticleCard(
          category: 'GEJALA',
          title: 'Mengenali Gejala Awal TBC yang Sering...',
          isRead: true,
          imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?q=80&w=200&auto=format&fit=crop',
        ),
        SizedBox(height: 16),
        EducationArticleCard(
          category: 'PENGOBATAN',
          title: 'Pentingnya Kepatuhan Minum Obat TBC 6 Bulan',
          isRead: false,
          imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?q=80&w=200&auto=format&fit=crop',
        ),
        SizedBox(height: 16),
        EducationArticleCard(
          category: 'MITOS',
          title: '5 Mitos Populer Tentang Penularan TBC di...',
          isRead: true,
          imageUrl: 'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?q=80&w=200&auto=format&fit=crop',
        ),
        SizedBox(height: 16),

        // --- INI YANG DIGANTI UNTUK ARTIKEL KEEMPAT ---
        EducationArticleCard(
          category: 'PENCEGAHAN',
          title: 'Cara Mencegah Penularan TBC pada Anggota...',
          isRead: false,
          // URL baru yang valid (Gambar medis/masker pencegahan)
          imageUrl: 'https://images.unsplash.com/photo-1583324113626-70df0f4deaab?q=80&w=200&auto=format&fit=crop',
        ),
      ],
    );
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
        child: const Icon(Icons.smart_toy_outlined, color: Colors.white, size: 32),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, 'Home', false, () => context.go('/dashboard')),
            _buildNavItem(Icons.map_outlined, 'Maps', false, () {}),
            const SizedBox(width: 40),
            _buildNavItem(Icons.menu_book, 'Education', true, () {}),
            _buildNavItem(Icons.person_outline, 'Profile', false, () => context.go('/profile')),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? AppColors.primaryGreen : AppColors.grayIcon),
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
    );
  }
}