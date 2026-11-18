import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// ============================================================================
/// MATERI 5: BEST PRACTICES UNTUK STATE MANAGEMENT
/// ============================================================================
/// Halaman ini merangkum 5 praktik terbaik dalam mengelola state pada Flutter:
/// 1. Letakkan state sedekat mungkin dengan widget yang menggunakannya.
/// 2. Gunakan setState() seminimal mungkin.
/// 3. Selalu dispose() controller dan resource.
/// 4. Gunakan setState() untuk state lokal (Ephemeral State).
/// 5. Gunakan state management (Provider/Bloc) jika state digunakan lintas banyak halaman.
/// ============================================================================
class BestPracticesPage extends StatelessWidget {
  const BestPracticesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Practices State Management'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Banner Pengantar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.secondaryColor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.verified_rounded,
                  color: AppTheme.primaryColor,
                  size: 26,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Penerapan best practices memastikan performa aplikasi tetap cepat (60/120 fps), '
                    'bebas memory leak, dan struktur kode mudah dipelihara saat aplikasi bertumbuh.',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: AppTheme.textPrimary,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Praktik 1
          _buildPracticeCard(
            number: '1',
            title: 'Letakkan State Sedekat Mungkin',
            principle:
                'State Scoping: Jangan letakkan state di root atau widget teratas jika hanya satu komponen kecil yang membutuhkannya.',
            explanation:
                'Memindahkan state ke bawah (state colocation) mencegah rebuild seluruh halaman secara tidak perlu saat hanya sebagian kecil tampilan yang berubah.',
            goodExample:
                '// BAIK: State diletakkan di dalam CustomButton\n'
                'class CustomButton extends StatefulWidget {\n'
                '  // Hanya button ini yang rebuild saat ditekan\n'
                '}',
            badExample:
                '// KURANG BAIK: Menaruh state hover/press di HomePage\n'
                '// yang menyebabkan seluruh Scaffold & AppBar ikut rebuild',
            tip: 'Hanya lakukan "Lifting State Up" jika data benar-benar dibagi antara 2 widget bersaudara.',
          ),
          const SizedBox(height: 16),

          // Praktik 2
          _buildPracticeCard(
            number: '2',
            title: 'Gunakan setState() Seminimal Mungkin',
            principle:
                'Batasi lingkup kode yang ada di dalam method setState() hanya untuk assignment variabel state.',
            explanation:
                'Jangan menaruh operasi berat (HTTP request, disk I/O, parsing JSON rumit) di dalam blok setState(). Jalankan komputasi terlebih dahulu, baru perbarui variabel state.',
            goodExample:
                '// BAIK:\n'
                'final result = hitungKomputasi();\n'
                'setState(() {\n'
                '  _hasil = result;\n'
                '});',
            badExample:
                '// KURANG BAIK:\n'
                'setState(() {\n'
                '  // Memanggil API atau looping berat di sini\n'
                '  _hasil = fetchFromInternet();\n'
                '});',
            tip: 'Gunakan kata kunci "const" pada widget statis agar Flutter melewatinya saat proses rebuild.',
          ),
          const SizedBox(height: 16),

          // Praktik 3
          _buildPracticeCard(
            number: '3',
            title: 'Selalu dispose() Controller dan Resource',
            principle:
                'Setiap controller, stream listener, atau timer yang dibuat di initState() WAJIB dibersihkan di dispose().',
            explanation:
                'Jika controller (seperti TextEditingController, AnimationController, ScrollController) tidak di-dispose, objek tersebut akan tetap tertahan di RAM meskipun halaman sudah ditutup, menyebabkan Memory Leak.',
            goodExample:
                '@override\n'
                'void dispose() {\n'
                '  _controller.dispose(); // Bersihkan resource\n'
                '  _timer?.cancel();      // Batalkan timer aktif\n'
                '  super.dispose();       // Panggil super di akhir\n'
                '}',
            badExample:
                '// KURANG BAIK: Lupa mengoverride method dispose(),\n'
                '// Controller tetap aktif dan menghabiskan memori RAM.',
            tip: 'Jadikan kebiasaan: setiap kali menulis TextEditingController(), langsung tulis dispose()-nya.',
          ),
          const SizedBox(height: 16),

          // Praktik 4
          _buildPracticeCard(
            number: '4',
            title: 'Gunakan setState() untuk State Lokal',
            principle:
                'Gunakan setState() hanya untuk Ephemeral State (state yang hanya relevan untuk satu widget / layar).',
            explanation:
                'Contoh state lokal yang ideal untuk setState(): animasi switch, tab index yang aktif, validasi field form, atau tombol expandable/accordion.',
            goodExample:
                '// BAIK: Toggle expand/collapse card lokal\n'
                'bool _isExpanded = false;\n'
                'void _toggle() {\n'
                '  setState(() => _isExpanded = !_isExpanded);\n'
                '}',
            badExample:
                '// KURANG BAIK: Menyimpan data sesi login atau\n'
                '// keranjang belanja e-commerce hanya di setState() lokal\n'
                '// karena data akan hilang saat berpindah halaman.',
            tip: 'Ephemeral State = State jangka pendek & tertutup di dalam widget itu sendiri.',
          ),
          const SizedBox(height: 16),

          // Praktik 5
          _buildPracticeCard(
            number: '5',
            title: 'Gunakan Provider/Bloc untuk State Lintas Halaman',
            principle:
                'Pilih solusi App-Wide State Management untuk App State (data yang dibagi ke banyak rute/halaman).',
            explanation:
                'Jika data perlu diakses oleh banyak halaman yang tidak berhubungan langsung (contoh: status login user, tema gelap/terang, item cart belanja), gunakan Provider, Riverpod, atau Bloc agar terhindar dari "prop drilling" (mengoper data berjenjang terlalu dalam).',
            goodExample:
                '// Arsitektur yang tepat:\n'
                '- Ephemeral State (Lokal)   -> setState()\n'
                '- App State (Lintas Layar)  -> Provider / Riverpod / Bloc',
            badExample:
                '// KURANG BAIK: Mengoper callback melalui 5 tingkatan\n'
                '// widget bertingkat hanya untuk mengubah nama user.',
            tip: 'Pahami setState() terlebih dahulu sebelum melangkah ke Provider atau Bloc karena setState() adalah fondasi dasar semua state management di Flutter.',
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPracticeCard({
    required String number,
    required String title,
    required String principle,
    required String explanation,
    required String goodExample,
    required String badExample,
    required String tip,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Nomor & Judul
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppTheme.primaryColor,
                  child: Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Prinsip Utama
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    size: 16,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      principle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Penjelasan
            Text(
              explanation,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),

            // Good Example Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.check_circle_rounded,
                          size: 14, color: AppTheme.successColor),
                      SizedBox(width: 6),
                      Text(
                        'Praktik Baik (DO)',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.successColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    goodExample,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: Color(0xFF166534),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Bad Example Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFECACA)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.cancel_rounded,
                          size: 14, color: AppTheme.errorColor),
                      SizedBox(width: 6),
                      Text(
                        'Hindari (DON\'T)',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.errorColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    badExample,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: Color(0xFF991B1B),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Pro Tip
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.tips_and_updates_outlined,
                  size: 14,
                  color: AppTheme.warningColor,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Tip: $tip',
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
