import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';
import 'package:sipekatbc/features/education/data/article_repository.dart';
import 'package:sipekatbc/features/education/data/models/article_model.dart';

class ArticleDetailPage extends StatefulWidget {
  final String articleId;

  const ArticleDetailPage({super.key, required this.articleId});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final ArticleRepository _repository = ArticleRepository();
  late Future<Article> _articleFuture;

  @override
  void initState() {
    super.initState();
    _articleFuture = _repository.fetchArticleById(widget.articleId);
    _repository.markRead(widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: FutureBuilder<Article>(
        future: _articleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat artikel'));
          }

          final article = snapshot.data;

          if (article == null) {
            return const Center(child: Text('Artikel tidak ditemukan'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroImageAndBadge(article),
                const SizedBox(height: 20),
                _buildArticleTitle(article),
                const SizedBox(height: 8),
                if (article.createdAt != null) _buildDate(article.createdAt!),
                const SizedBox(height: 20),
                _buildArticleBody(article),
                if (article.sourceUrl != null && article.sourceUrl!.isNotEmpty)
                  _buildSourceLink(article.sourceUrl!),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
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
  Widget _buildHeroImageAndBadge(Article article) {
    final coverUrl = article.coverUrl;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: coverUrl == null || coverUrl.isEmpty
              ? _buildImagePlaceholder()
              : Image.network(
                  coverUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildImagePlaceholder(),
                ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: _getCategoryColor(article.category),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              article.category,
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
  Widget _buildArticleTitle(Article article) {
    return Text(
      article.title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.3,
      ),
    );
  }

  // --- KONTEN TEKS ARTIKEL ---
  Widget _buildArticleBody(Article article) {
    return Text(
      article.content,
      style: const TextStyle(
        fontSize: 15,
        color: AppColors.textPrimary,
        height: 1.6,
      ),
    );
  }

  Widget _buildSourceLink(String url) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          children: [
            const TextSpan(text: 'Lihat artikel asli: '),
            TextSpan(
              text: url,
              style: const TextStyle(
                color: AppColors.primaryGreen,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDate(DateTime createdAt) {
    return Text(
      'Diunggah: ${_formatDate(createdAt)}',
      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 220,
      color: AppColors.grayForm,
      child: const Icon(
        Icons.broken_image,
        color: AppColors.grayIcon,
        size: 50,
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toUpperCase()) {
      case 'GEJALA':
        return Colors.teal;
      case 'PENGOBATAN':
        return Colors.orange;
      case 'MITOS':
        return Colors.grey;
      case 'PENCEGAHAN':
        return Colors.cyan;
      default:
        return const Color(0xFF26C6DA);
    }
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}
