import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroImageAndBadge(),
            const SizedBox(height: 20),

            _buildArticleTitle(),
            const SizedBox(height: 12),

            _buildSourceLink(),
            const SizedBox(height: 20),

            _buildArticleBody(),
            const SizedBox(height: 24),

            _buildImportantStepsCard(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- APP BAR ---
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
        'Article Detail',
        style: TextStyle(
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // --- GAMBAR UTAMA & BADGE KATEGORI ---
  Widget _buildHeroImageAndBadge() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?w=500&auto=format&fit=crop',
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: double.infinity,
              height: 220,
              color: AppColors.grayForm,
              child: const Icon(Icons.broken_image, color: AppColors.grayIcon, size: 50),
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF26C6DA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Pengobatan',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- JUDUL ARTIKEL ---
  Widget _buildArticleTitle() {
    return const Text(
      'Cara Benar Minum Obat TBC Agar Cepat Sembuh',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.3,
      ),
    );
  }

  // --- LINK SUMBER ---
  Widget _buildSourceLink() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
        children: [
          TextSpan(text: 'Sumber : '),
          TextSpan(
            text: 'tbc.org/pedoman_minum',
            style: TextStyle(
              color: AppColors.primaryGreen,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // --- KONTEN TEKS ARTIKEL ---
  Widget _buildArticleBody() {
    return const Text(
      'Pengobatan Tuberkulosis (TBC) membutuhkan komitmen tinggi. Kunci utama kesembuhan adalah minum obat secara rutin tanpa terputus selama minimal 6 bulan.',
      style: TextStyle(
        fontSize: 15,
        color: AppColors.textPrimary,
        height: 1.6,
      ),
    );
  }

  // --- KARTU LANGKAH PENTING PENGOBATAN ---
  Widget _buildImportantStepsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.verified, color: AppColors.primaryGreen, size: 28),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Langkah Penting\nPengobatan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildStepItem(
            number: '1',
            title: 'Patuhi Jadwal',
            desc: 'Minum obat di waktu yang sama setiap hari. Buat alarm sebagai pengingat.',
          ),
          const SizedBox(height: 20),

          _buildStepItem(
            number: '2',
            title: 'Jangan Putus Obat',
            desc: 'Meskipun sudah merasa sehat, obat harus tetap diminum sampai waktu yang ditentukan oleh dokter (minimal 6 bulan).',
          ),
          const SizedBox(height: 20),

          _buildStepItem(
            number: '3',
            title: 'Kenali Efek Samping',
            desc: 'Warna urine menjadi kemerahan adalah hal wajar. Namun jika mengalami mual berlebih, segera konsultasikan ke Faskes.',
          ),
          const SizedBox(height: 20),

          _buildStepItem(
            number: '4',
            title: 'Gunakan Masker',
            desc: 'Terutama di 2 bulan pertama pengobatan untuk mencegah penularan kepada orang-orang di rumah.',
          ),
          const SizedBox(height: 20),

          _buildStepItem(
            number: '5',
            title: 'Periksa Dahak Rutin',
            desc: 'Lakukan pemeriksaan dahak ulang sesuai jadwal untuk memantau keberhasilan pengobatan.',
          ),
        ],
      ),
    );
  }

  // --- WIDGET REUSABLE UNTUK ITEM LANGKAH ---
  Widget _buildStepItem({required String number, required String title, required String desc}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFF26C6DA),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}