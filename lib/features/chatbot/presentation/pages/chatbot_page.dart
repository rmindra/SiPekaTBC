import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipekatbc/core/constants/app_colors.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Background abu-abu sangat muda/putih
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          // Area Chat (Scrollable)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildDateBadge('Hari ini'),
                const SizedBox(height: 20),
                _buildBotMessage(
                  message: 'Halo! Saya SiPeka. Ada yang ingin kamu tanyakan seputar TBC hari ini?',
                  time: '09:41',
                ),
                const SizedBox(height: 16),
                _buildUserMessage(
                  message: 'Apa saja gejala awal TBC?',
                  time: '09:42',
                ),
                const SizedBox(height: 16),
                _buildBotMessage(
                  message: 'Gejala awal TBC yang paling umum meliputi:\n\n•  Batuk berdahak lebih dari 2 minggu\n•  Demam ringan yang hilang timbul\n•  Keringat malam tanpa sebab jelas\n•  Penurunan berat badan drastis',
                  time: '09:42',
                ),
              ],
            ),
          ),

          // Area Bawah (Disclaimer, Suggestions, Input)
          _buildBottomInputArea(),
        ],
      ),
    );
  }

  // --- APP BAR ---
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primaryGreen),
        onPressed: () => context.pop(),
      ),
      // --- DUA BARIS INI YANG MEMBUATNYA KE TENGAH ---
      centerTitle: true,
      titleSpacing: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min, // <--- Memastikan Row-nya pas di tengah
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dr. Peka',
                style: TextStyle(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50), // Hijau terang untuk status online
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Online',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // --- Menambahkan kotak kosong di kanan agar benar-benar seimbang (optional) ---
      actions: const [
        SizedBox(width: 48), // Selebar IconButton leading
      ],
    );
  }

  // --- BADGE TANGGAL ---
  Widget _buildDateBadge(String date) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEBEBEB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          date,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  // --- BUBBLE CHAT BOT ---
  Widget _buildBotMessage({required String message, required String time}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Avatar Bot
        Container(
          margin: const EdgeInsets.only(bottom: 20), // Angkat sedikit dari waktu
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: AppColors.primaryGreen,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.smart_toy, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 8),
        // Bubble Pesan
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), // Siku di kiri atas
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(width: 40), // Jarak agar tidak mentok kanan
      ],
    );
  }

  // --- BUBBLE CHAT USER ---
  Widget _buildUserMessage({required String message, required String time}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(width: 60), // Jarak agar tidak mentok kiri
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: const BoxDecoration(
                  color: Color(0xFFE2E6E9), // Abu-abu terang
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(4), // Siku di kanan atas
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- AREA BAWAH (INPUT & SUGGESTIONS) ---
  Widget _buildBottomInputArea() {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.grayForm.withValues(alpha: 0.5)),
        ),
      ),
      child: Column(
        children: [
          // Disclaimer
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'SiPeka bukan pengganti diagnosis dokter. Segera kunjungi\npuskesmas jika gejala memburuk.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Suggestions (Horizontal Scroll)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildSuggestionChip('Apa itu TBC?'),
                _buildSuggestionChip('Gejala Awal'),
                _buildSuggestionChip('Apakah TBC bisa sembuh?'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Input Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F6F6), // Abu-abu kehijauan
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.grayForm),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add_circle_outline, color: AppColors.textSecondary),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Ketik pertanyaanmu di sini...',
                              hintStyle: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.send, color: Colors.white, size: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grayForm),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}