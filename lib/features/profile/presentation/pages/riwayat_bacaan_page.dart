import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';

class RiwayatBacaanPage extends StatelessWidget {
  const RiwayatBacaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            const SizedBox(height: 20),
            _buildSearchAndFilter(),
            const SizedBox(height: 24),
            _buildSectionHeader('Hari Ini'),
            const SizedBox(height: 12),
            _buildHistoryCard(
              title: 'Mengenal Gejala Awal TBC pada Dewasa',
              date: '14 Okt 2023 • 09:15',
              imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?w=200&auto=format&fit=crop',
            ),
            _buildHistoryCard(
              title: 'Pentingnya Nutrisi Selama Masa Pengobatan',
              date: '14 Okt 2023 • 07:30',
              imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=200&auto=format&fit=crop',
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('Kemarin'),
            const SizedBox(height: 12),
            _buildHistoryCard(
              title: 'Mitos dan Fakta Seputar Penularan TBC',
              date: '13 Okt 2023 • 19:45',
              imageUrl: 'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?w=200&auto=format&fit=crop',
            ),
            _buildHistoryCard(
              title: 'Cara Benar Minum Obat TBC Agar Cepat Sembuh',
              date: '13 Okt 2023 • 14:10',
              imageUrl: 'https://images.unsplash.com/photo-1585435557343-3b092031a831?w=200&auto=format&fit=crop',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      // Navbar dan FAB sudah dihapus agar fokus pada konten
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
        'Riwayat Bacaan',
        style: TextStyle(
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Selesai',
                style: TextStyle(fontSize: 13, color: AppColors.primaryGreen, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                '12 Artikel',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.menu_book, color: AppColors.primaryGreen, size: 26),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari riwayat...',
                hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppColors.grayIcon),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: AppColors.grayForm)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: AppColors.grayForm)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: AppColors.primaryGreen)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 48, width: 48,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.grayForm)),
          child: const Icon(Icons.filter_list, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: const TextStyle(fontSize: 15, color: AppColors.textSecondary, fontWeight: FontWeight.bold));
  }

  Widget _buildHistoryCard({required String title, required String date, required String imageUrl}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl, width: 85, height: 85, fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(width: 85, height: 85, color: AppColors.grayForm, child: const Icon(Icons.broken_image, color: AppColors.grayIcon)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF26C6DA), borderRadius: BorderRadius.circular(12)),
                  child: const Text('Selesai Dibaca', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Row(children: [const Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.textSecondary), const SizedBox(width: 6), Text(date, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}