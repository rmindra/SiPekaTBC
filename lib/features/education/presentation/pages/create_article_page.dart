import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';
import 'package:sipekatbc/core/session/user_session.dart';
import 'package:sipekatbc/features/education/data/article_repository.dart';

class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({super.key});

  @override
  State<CreateArticlePage> createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage> {
  String _selectedCategory = 'Gejala'; // Default terpilih sesuai UI
  final ArticleRepository _repository = ArticleRepository();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _sourceUrlController = TextEditingController();
  final TextEditingController _coverUrlController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _sourceUrlController.dispose();
    _coverUrlController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih bersih
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Article Title'),
            _buildTextField(
              hint: 'Enter article title',
              controller: _titleController,
            ),
            const SizedBox(height: 24),

            _buildLabel('Category'),
            _buildCategoryChips(),
            const SizedBox(height: 24),

            _buildLabel('Cover Image URL'),
            _buildTextField(
              hint: 'https://...jpg',
              controller: _coverUrlController,
            ),
            const SizedBox(height: 24),

            _buildLabel('Put Your Link Article'),
            _buildTextField(
              hint: 'https://...',
              controller: _sourceUrlController,
            ),
            const SizedBox(height: 24),

            _buildLabel('Article Content'),
            _buildTextField(
              hint: 'Write your article content here...',
              controller: _contentController,
              maxLines: 6, // Biar kotaknya lebih besar ke bawah
            ),
            const SizedBox(height: 24),

            _buildInfoCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      // Tombol Publish menempel di bawah
      bottomNavigationBar: _buildBottomPublishButton(),
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
        'Create Article',
        style: TextStyle(
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.bold,
          fontSize: 18,
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

  // --- HELPER LABEL ---
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  // --- HELPER TEXTFIELD ---
  Widget _buildTextField({
    required String hint,
    int maxLines = 1,
    TextEditingController? controller,
  }) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
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
    );
  }

  // --- CATEGORY CHIPS ---
  Widget _buildCategoryChips() {
    final categories = ['Gejala', 'Pengobatan', 'Pencegahan', 'Mitos'];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: categories.map((cat) {
        final isSelected = _selectedCategory == cat;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = cat;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryGreen : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.primaryGreen : AppColors.grayForm,
              ),
            ),
            child: Text(
              cat,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // --- INFO CARD ---
  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Hijau sangat muda
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: AppColors.primaryGreen, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your article will be reviewed by the clinical team before being published to the community forum.',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- BOTTOM PUBLISH BUTTON ---
  Widget _buildBottomPublishButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.grayForm.withValues(alpha: 0.3)),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: _isSubmitting ? null : _handlePublish,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
            icon: const Icon(Icons.send, color: Colors.white, size: 18),
            label: Text(
              _isSubmitting ? 'Publishing...' : 'Publish Article',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePublish() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final coverUrl = _coverUrlController.text.trim();
    final sourceUrl = _sourceUrlController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      _showSnackBar('Judul dan konten wajib diisi');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _repository.createArticle(
        title: title,
        content: content,
        category: _selectedCategory,
        coverUrl: coverUrl.isEmpty ? null : coverUrl,
        sourceUrl: sourceUrl.isEmpty ? null : sourceUrl,
      );

      if (!mounted) {
        return;
      }

      _showSnackBar('Artikel berhasil dipublish');
      context.pop();
    } catch (e) {
      _showSnackBar('Gagal publish artikel');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
