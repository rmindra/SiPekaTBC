import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';
import 'package:sipekatbc/core/session/user_session.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Temukan Faskes',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Cari fasilitas kesehatan terdekat untuk\npenanganan TBC yang cepat dan\nprofesional.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            _buildBigMapButton(), // Tombol Bulat Besar

            const SizedBox(height: 40),
            _buildInfoCard(), // Kartu Pencarian Cerdas

            const SizedBox(height: 40), // Spasi bawah agar lega
          ],
        ),
      ),
      floatingActionButton: _buildCenterFAB(context),
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

  // --- TOMBOL BULAT BESAR UNTUK MAPS ---
  Widget _buildBigMapButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Shape Kotak Melengkung di belakang (Bayangan/Alas)
        Container(
          width: 240,
          height: 260,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F6F6), // Abu-abu sangat muda/transparan
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        // Shape Lingkaran Utama
        InkWell(
          onTap: () {
            // TODO: Aksi ketika tombol Maps besar diklik (misal buka Google Maps API)
          },
          borderRadius: BorderRadius.circular(150),
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              color: const Color(0xFF26B6A5), // Warna Hijau Tosca terang sesuai UI
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF26B6A5).withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lingkaran kecil transparan di belakang ikon pin
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Cari Faskes TBC',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- KARTU INFO PENCARIAN CERDAS ---
  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grayForm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFBE9E7), // Warna background oren muda
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.info,
              color: Color(0xFF8D6E63), // Warna ikon coklat/oren gelap
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pencarian Cerdas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Gunakan GPS untuk menemukan puskesmas atau rumah sakit rujukan TBC dalam radius 5km dari posisi Anda.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- REUSABLE COMPONENTS BOTTOM NAV & FAB ---
  Widget _buildCenterFAB(BuildContext context) { // <-- Tambahan BuildContext
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 65,
      width: 65,
      child: FloatingActionButton(
        onPressed: () {
          context.push('/chatbot'); // <-- Isi perintah push
        },
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

            // --- MAPS AKTIF (TRUE) ---
            _buildNavItem(Icons.map, 'Maps', true, () => context.go('/maps')),

            const SizedBox(width: 40),
            _buildNavItem(Icons.menu_book, 'Education', false, () => context.go('/education')),
            _buildNavItem(Icons.person_outline, 'Profile', false, () => context.go('/profile')),
          ],
        ),
      ),
    );
  }

  // Navbar item logic untuk menampilkan warna hijau pill saat aktif
  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          // Jika aktif, beri background hijau pudar seperti di desain UI
          color: isActive ? AppColors.primaryGreen.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
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
      ),
    );
  }
}