import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';

class TentangSipekatbcPage extends StatelessWidget {
  const TentangSipekatbcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      // SingleChildScrollView akan berfungsi maksimal karena teksnya sekarang panjang
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            _buildAppLogo(),
            const SizedBox(height: 32),
            _buildMisiKamiCard(),
            const SizedBox(height: 20),
            _buildApaItuCard(), // Kotak ini sekarang isinya panjang
            const SizedBox(height: 40),
          ],
        ),
      ),
      // Navbar dan FAB tidak ada di halaman ini
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primaryGreen),
        onPressed: () => context.pop(),
      ),
      centerTitle: true,
      title: const Text(
        'Tentang SiPekaTBC',
        style: TextStyle(
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(24)
          ),
          child: const Icon(Icons.monitor_heart_outlined, color: Colors.white, size: 45),
        ),
        const SizedBox(height: 16),
        const Text(
            'SiPekaTBC',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primaryGreen)
        ),
        const SizedBox(height: 4),
        const Text(
            'Versi 2.4.0 (Stabil)',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary)
        ),
      ],
    );
  }

  Widget _buildMisiKamiCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grayForm)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12)
            ),
            child: const Icon(Icons.verified_outlined, color: AppColors.primaryGreen, size: 24),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Misi Kami',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)
                ),
                SizedBox(height: 8),
                Text(
                  'Memberdayakan masyarakat melalui edukasi digital yang akurat dan pendampingan kesehatan yang responsif untuk menanggulangi TBC di Indonesia.',
                  style: TextStyle(fontSize: 15, color: AppColors.textPrimary, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApaItuCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grayForm)
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Apa itu SiPekaTBC?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryGreen)
          ),
          SizedBox(height: 12),
          // --- TEKS DIPERPANJANG DI SINI AGAR BISA SCROLL ---
          Text(
            'SiPekaTBC adalah platform digital komprehensif yang dirancang untuk menjadi pendamping setia dalam perjalanan kesehatan Anda. Kami fokus pada penyediaan informasi yang mudah dipahami mengenai pencegahan, deteksi dini, dan manajemen pengobatan Tuberkulosis (TBC).\n\nMelalui integrasi sistem kesehatan digital, aplikasi ini dilengkapi dengan berbagai fitur pendukung inovatif. Anda dapat mengakses berbagai artikel edukasi yang selalu diperbarui oleh tim profesional, memanfaatkan fitur Chatbot pintar untuk menjawab pertanyaan seputar TBC dengan cepat kapan saja, serta mengeksplorasi fitur pemetaan (Maps) fasilitas kesehatan terdekat untuk memudahkan akses pengobatan dan konsultasi.\n\nSelain itu, sistem kami dirancang dengan antarmuka yang sangat ramah pengguna (user-friendly) agar dapat diakses oleh semua kalangan masyarakat. Kami percaya bahwa edukasi yang baik adalah langkah pertama menuju kesembuhan. Oleh karena itu, kami terus berupaya menghadirkan informasi yang relevan, menepis mitos yang beredar di masyarakat, dan memberikan panduan pengobatan yang sesuai dengan standar medis.\n\nKami berharap kehadiran SiPekaTBC tidak hanya sekadar menjadi aplikasi di ponsel Anda, tetapi benar-benar memberikan dampak nyata. Dengan pemantauan yang rutin, terpadu, dan edukasi yang masif, mari bersama-sama kita wujudkan masyarakat yang lebih sehat, menghapus stigma negatif tentang penderita TBC, dan mendukung program pemerintah dalam mengeliminasi TBC di Indonesia.',
            style: TextStyle(fontSize: 15, color: AppColors.textPrimary, height: 1.5),
          ),
        ],
      ),
    );
  }
}