import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImportantNotice(),
            const SizedBox(height: 24),
            _buildMedicalDisclaimerCard(),
            const SizedBox(height: 24),
            _buildGeneralTermsCard(), // Tambahan agar bisa scroll
            const SizedBox(height: 40),
          ],
        ),
      ),
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
        'Syarat & Ketentuan',
        style: TextStyle(
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // --- KOTAK PEMBERITAHUAN PENTING (Warna Hijau Pudar/Teal) ---
  Widget _buildImportantNotice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1), // Teal/Hijau pudar sesuai UI
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.gavel_rounded, color: Color(0xFF00796B), size: 24),
              SizedBox(width: 12),
              Text(
                'Pemberitahuan Penting',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF004D40),
                height: 1.5,
              ),
              children: [
                TextSpan(
                    text:
                    'Aplikasi SiPekaTBC dirancang khusus untuk tujuan edukasi dan pemantauan mandiri. Informasi di dalamnya '),
                TextSpan(
                  text: 'bukan merupakan pengganti saran medis profesional, diagnosis, atau perawatan.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- KARTU DISCLAIMER MEDIS ---
  Widget _buildMedicalDisclaimerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grayForm),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '01. DISCLAIMER MEDIS',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Seluruh konten, termasuk teks, grafis, gambar, dan informasi yang tersedia melalui aplikasi ini bersifat umum. Kami sangat menyarankan Anda untuk selalu berkonsultasi dengan dokter atau tenaga medis profesional lainnya terkait kondisi kesehatan Anda.\n\nJangan pernah mengabaikan saran medis profesional atau menunda mencarinya karena sesuatu yang Anda baca di aplikasi SiPekaTBC. Jika Anda merasa mengalami keadaan darurat medis, segera hubungi dokter atau layanan ambulans terdekat.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // --- KARTU TAMBAHAN BIAR BISA SCROLL ---
  Widget _buildGeneralTermsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grayForm),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '02. PENGGUNAAN LAYANAN',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Dengan menggunakan SiPekaTBC, Anda setuju untuk memberikan data yang akurat demi efektivitas pemantauan kesehatan Anda. Kami berkomitmen untuk menjaga kerahasiaan data pribadi Anda sesuai dengan kebijakan privasi yang berlaku.\n\nPlatform ini dilarang digunakan untuk tujuan ilegal atau menyebarkan informasi palsu yang dapat membahayakan kesehatan orang lain di komunitas.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}