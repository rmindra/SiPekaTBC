import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 32),
            _buildStatsCard(),
            const SizedBox(height: 24),
            _buildMenuList(),
            const SizedBox(height: 32),
            _buildLogoutButton(context),
            const SizedBox(height: 40), // Spacing ekstra bawah
          ],
        ),
      ),
      floatingActionButton: _buildCenterFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white, // 1. Ubah jadi putih polos
      surfaceTintColor: Colors.transparent, // 2. Wajib! Mencegah warna putihnya berubah kusam di Material 3
      elevation: 4, // 3. Menambahkan ketebalan bayangan
      shadowColor: Colors.black.withValues(alpha: 0.08), // 4. Bikin bayangannya sangat soft/halus
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
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                fit: BoxFit.cover,
                width: 36,
                height: 36,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- PROFILE HEADER (Foto, Nama, Email) ---
  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4), // Border putih luar
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.grayForm,
                backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop', // Ganti dengan asset lokal nanti
                ),
              ),
            ),
            // Tombol Edit (Pensil)
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Budi Santoso',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'budi.santoso@email.com',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // --- STATS CARD (Statistik Belajar) ---
  Widget _buildStatsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFE3E9E8), // Sesuai warna menu grid sebelumnya
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.menu_book, color: AppColors.primaryGreen, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Statistik Belajar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                    children: [
                      TextSpan(text: 'Kamu telah membaca '),
                      TextSpan(
                        text: '4 Artikel',
                        style: TextStyle(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' minggu ini!'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- MENU LIST TILE ---
  Widget _buildMenuList() {
    return Column(
      children: [
        _buildMenuListItem(Icons.history, 'Riwayat Bacaan', () {}),
        const SizedBox(height: 12),
        _buildMenuListItem(Icons.info_outline, 'Tentang SiPekaTBC', () {}),
        const SizedBox(height: 12),
        _buildMenuListItem(Icons.health_and_safety_outlined, 'Syarat & Ketentuan /\nDisclaimer Medis', () {}),
      ],
    );
  }

  Widget _buildMenuListItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grayForm), // Border tipis
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.grayIcon),
          ],
        ),
      ),
    );
  }

  // --- LOGOUT BUTTON ---
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton.icon(
        onPressed: () {
          // TODO: Implementasi logika logout Supabase
          context.go('/login');
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.redButton.withValues(alpha: 0.1), // Efek merah sangat transparan
          side: const BorderSide(color: AppColors.redButtonBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        icon: const Icon(Icons.logout, color: AppColors.redButtonText),
        label: const Text(
          'Keluar',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.redButtonText,
          ),
        ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(Icons.smart_toy_outlined, color: Colors.white, size: 32),
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
            // Home ditambahkan fungsi klik
            InkWell(
              onTap: () => context.go('/dashboard'),
              child: _buildNavItem(Icons.home_outlined, 'Home', false),
            ),
            _buildNavItem(Icons.map_outlined, 'Maps', false),

            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                SizedBox(height: 28),
                Text('Chatbot', style: TextStyle(fontSize: 10, color: AppColors.grayIcon)),
              ],
            ),

            _buildNavItem(Icons.menu_book_outlined, 'Education', false),
            // Profile dibuat menjadi tab aktif (hijau)
            InkWell(
              onTap: () {},
              child: _buildNavItem(Icons.person, 'Profile', true),
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