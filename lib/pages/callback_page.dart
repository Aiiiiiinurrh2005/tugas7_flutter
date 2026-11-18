import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/like_button.dart';

/// ============================================================================
/// MATERI 4: CALLBACK FUNCTION & EVENT PROPAGATION (PARENT WIDGET)
/// ============================================================================
/// Konsep "Events Up":
/// Child Widget tidak dapat mengubah state Parent secara langsung.
/// Child berkomunikasi ke atas melalui Callback Function (VoidCallback).
/// Parent menyediakan implementasi fungsi callback tersebut dan memanggil
/// setState() di dalam tubuh Parent untuk memperbarui state.
/// ============================================================================
class CallbackPage extends StatefulWidget {
  const CallbackPage({super.key});

  @override
  State<CallbackPage> createState() => _CallbackPageState();
}

class _CallbackPageState extends State<CallbackPage> {
  // ---------------------------------------------------------------------------
  // STATE PARENT:
  // Nilai awal like adalah 0 sesuai spesifikasi tugas
  // ---------------------------------------------------------------------------
  int _likeCount = 0;
  final List<String> _eventHistory = [];

  String _getTimeString() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
  }

  // ===========================================================================
  // CALLBACK HANDLER:
  // Fungsi ini diteruskan ke Child Widget (LikeButton) sebagai VoidCallback.
  // Ketika tombol di Child ditekan, Child memanggil onLike(), yang mengeksekusi
  // method _handleChildLike() ini di Parent.
  // ===========================================================================
  void _handleChildLike() {
    setState(() {
      _likeCount++;
      _eventHistory.insert(
        0,
        'Event [onLike] diterima dari Child -> Like kini: $_likeCount (${_getTimeString()})',
      );
    });
  }

  /// Callback untuk mereset jumlah like
  void _handleChildReset() {
    setState(() {
      _likeCount = 0;
      _eventHistory.insert(
        0,
        'Event [onReset] diterima dari Child -> Like direset (${_getTimeString()})',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Callback Function'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Penjelasan Konsep Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.secondaryColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.call_made_rounded,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Konsep "Events Up": Child Widget memberitahu Parent via VoidCallback. '
                      'Parent menerima callback tersebut, lalu memanggil setState() untuk mengupdate UI.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Card Penampil State Like di Parent
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'State di Parent Widget',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Counter Real-time dengan Ikon Hati
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 130,
                          color: _likeCount > 0
                              ? AppTheme.errorColor.withValues(alpha: 0.12)
                              : const Color(0xFFF1F5F9),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$_likeCount',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: _likeCount > 0
                                    ? AppTheme.errorColor
                                    : AppTheme.textSecondary,
                              ),
                            ),
                            const Text(
                              'Total Likes',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _likeCount == 0
                          ? 'Belum ada like. Tekan tombol child di bawah!'
                          : '$_likeCount orang menyukai konten ini!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _likeCount > 0
                            ? AppTheme.textPrimary
                            : AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Bagian Child Widget (LikeButton)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.touch_app_rounded, color: AppTheme.primaryColor, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Child Widget: LikeButton',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Child Widget yang memanggil onLike & onReset
                  LikeButton(
                    onLike: _handleChildLike,
                    onReset: _likeCount > 0 ? _handleChildReset : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Live Event Propagation Log
            Row(
              children: const [
                Icon(Icons.sync_alt_rounded, color: AppTheme.primaryColor, size: 20),
                SizedBox(width: 8),
                Text(
                  'Event Propagation History',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (_eventHistory.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Center(
                  child: Text(
                    'Riwayat event callback akan muncul di sini saat tombol ditekan.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _eventHistory.take(5).length,
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_upward_rounded,
                          size: 14,
                          color: AppTheme.successColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _eventHistory[index],
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            const SizedBox(height: 20),

            // Kode Penjelasan
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '// Child memicu VoidCallback saat tombol diklik:',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'onPressed: () => widget.onLike(); // Memicu callback',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Color(0xFFFCA5A5),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '// Parent mendengarkan dan memanggil setState():',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'LikeButton(\n'
                    '  onLike: () {\n'
                    '    setState(() => _likeCount++); // UI Parent di-rebuild\n'
                    '  },\n'
                    ')',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Color(0xFF93C5FD),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
