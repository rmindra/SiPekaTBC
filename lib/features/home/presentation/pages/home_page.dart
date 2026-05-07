import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';
import 'package:sipekatbc/core/session/user_session.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            _buildEducationSection(),
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
  Widget _buildEducationSection() {
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
              onPressed: () {},
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _buildEduCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?q=80&w=500&auto=format&fit=crop',
                title: 'Memahami Gejala Awal TBC dan Kapan Harus ke Dokter',
                desc:
                    'Kenali tanda-tanda awal tuberkulosis agar bisa mendapatkan penanganan lebih cepat',
                time: '3 menit baca',
                isNew: true,
              ),
              const SizedBox(width: 16),
              _buildEduCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?q=80&w=500&auto=format&fit=crop',
                title: 'Langkah Tepat Mencegah Penularan TBC di Rumah',
                desc:
                    'Praktik kebersihan dan sirkulasi udara untuk melindungi keluarga tercinta',
                time: '5 menit baca',
                isNew: false,
              ),
            ],
          ),
        ),
      ],
    );
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', true),
            _buildNavItem(Icons.map_outlined, 'Maps', false),

            // Spacing untuk Chatbot di tengah
            const SizedBox(width: 40),

            _buildNavItem(Icons.menu_book_outlined, 'Education', false),

            // --- UBAH BAGIAN INI ---
            InkWell(
              onTap: () {
                context.go(
                  '/profile',
                ); // Perintah untuk pindah ke halaman profile
              },
              child: _buildNavItem(Icons.person_outline, 'Profile', false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
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
    );
  }
}
