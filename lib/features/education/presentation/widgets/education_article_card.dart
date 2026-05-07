import 'package:flutter/material.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';

class EducationArticleCard extends StatelessWidget {
  final String category;
  final String title;
  final bool isRead;
  final String imageUrl;

  const EducationArticleCard({
    super.key,
    required this.category,
    required this.title,
    required this.isRead,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grayForm.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          // Thumbnail Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              // --- PERBAIKAN: Tambahkan width dan height di sini pada errorBuilder ---
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100, // Ukuran tetap agar tidak menciut
                height: 100, // Ukuran tetap agar tidak menciut
                color: AppColors.grayForm,
                child: const Icon(Icons.broken_image, color: AppColors.grayIcon, size: 40),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getCategoryColor(category).withValues(alpha: 0.8),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                _buildStatusButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton() {
    if (isRead) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2F1), // Warna hijau sangat muda
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 14, color: AppColors.primaryGreen),
            SizedBox(width: 4),
            Text(
              'Selesai Dibaca',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    } else {
      return Row(
        children: [
          const Text(
            'Baca Artikel',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward, size: 14, color: AppColors.primaryGreen),
        ],
      );
    }
  }

  Color _getCategoryColor(String cat) {
    switch (cat.toUpperCase()) {
      case 'GEJALA': return Colors.teal;
      case 'PENGOBATAN': return Colors.orange;
      case 'MITOS': return Colors.grey;
      case 'PENCEGAHAN': return Colors.cyan;
      default: return AppColors.primaryGreen;
    }
  }
}