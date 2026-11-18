import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/menu_card.dart';
import 'counter_page.dart';
import 'lifecycle_page.dart';
import 'passing_data_page.dart';
import 'callback_page.dart';
import 'best_practices_page.dart';

/// ============================================================================
/// HALAMAN UTAMA: DASHBOARD PEMBELAJARAN
/// ============================================================================
/// Menampilkan:
/// - AppBar bertuliskan "State Management Demo"
/// - Deskripsi singkat aplikasi
/// - 5 Menu/Card Pembelajaran Materi Pokok
/// ============================================================================
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management Demo'),
        actions: [
          IconButton(
            tooltip: 'Panduan Singkat',
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () {
              _showQuickGuide(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Deskripsi Singkat Aplikasi
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryColor, Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.school_rounded, color: Colors.white, size: 14),
                            SizedBox(width: 6),
                            Text(
                              'Praktik Flutter',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Media Pembelajaran\nState Management Dasar',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pelajari cara mengelola data lokal, daur hidup widget, pengiriman data antar komponen, dan callback function murni menggunakan setState().',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Judul Bagian Menu Pembelajaran
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Modul Pembelajaran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '5 Materi',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // -----------------------------------------------------------------
            // 1. Menu Card: State & Counter
            // -----------------------------------------------------------------
            MenuCard(
              moduleNumber: 'MATERI 1',
              title: 'State & Counter',
              description:
                  'Pelajari konsep dasar StatefulWidget, State, dan bagaimana setState() memicu proses rebuild antarmuka.',
              icon: Icons.add_circle_outline_rounded,
              iconColor: AppTheme.primaryColor,
              iconBgColor: AppTheme.secondaryColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CounterPage()),
                );
              },
            ),
            const SizedBox(height: 12),

            // -----------------------------------------------------------------
            // 2. Menu Card: Widget Lifecycle
            // -----------------------------------------------------------------
            MenuCard(
              moduleNumber: 'MATERI 2',
              title: 'Widget Lifecycle',
              description:
                  'Pahami siklus hidup widget: initState(), build(), didUpdateWidget(), dan dispose() dengan live event log.',
              icon: Icons.sync_rounded,
              iconColor: const Color(0xFF0284C7),
              iconBgColor: const Color(0xFFE0F2FE),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LifecyclePage()),
                );
              },
            ),
            const SizedBox(height: 12),

            // -----------------------------------------------------------------
            // 3. Menu Card: Passing Data
            // -----------------------------------------------------------------
            MenuCard(
              moduleNumber: 'MATERI 3',
              title: 'Passing Data',
              description:
                  'Demonstrasi aliran data satu arah dari Parent Widget ke Child StatelessWidget via constructor parameter.',
              icon: Icons.call_split_rounded,
              iconColor: const Color(0xFF7C3AED),
              iconBgColor: const Color(0xFFEDE9FE),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PassingDataPage()),
                );
              },
            ),
            const SizedBox(height: 12),

            // -----------------------------------------------------------------
            // 4. Menu Card: Callback Function
            // -----------------------------------------------------------------
            MenuCard(
              moduleNumber: 'MATERI 4',
              title: 'Callback Function',
              description:
                  'Pelajari komunikasi ke atas dari Child Widget LikeButton ke Parent menggunakan VoidCallback dan event propagation.',
              icon: Icons.favorite_border_rounded,
              iconColor: AppTheme.errorColor,
              iconBgColor: const Color(0xFFFEE2E2),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CallbackPage()),
                );
              },
            ),
            const SizedBox(height: 12),

            // -----------------------------------------------------------------
            // 5. Menu Card: Best Practices
            // -----------------------------------------------------------------
            MenuCard(
              moduleNumber: 'MATERI 5',
              title: 'Best Practices',
              description:
                  'Kaidah penulisan kode efisien: scoping state, optimasi rebuild, pembersihan controller, dan scoping provider.',
              icon: Icons.verified_outlined,
              iconColor: AppTheme.successColor,
              iconBgColor: const Color(0xFFDCFCE7),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BestPracticesPage()),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showQuickGuide(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: AppTheme.primaryColor),
            SizedBox(width: 8),
            Text('Panduan Belajar'),
          ],
        ),
        content: const Text(
          'Urutan belajar yang disarankan:\n\n'
          '1. Mulai dari "State & Counter" untuk memahami peran setState().\n'
          '2. Buka "Widget Lifecycle" untuk mengamati siklus hidup StatefulWidget.\n'
          '3. Pelajari "Passing Data" untuk mengetahui cara mengoper data ke bawah.\n'
          '4. Lanjutkan ke "Callback Function" untuk komunikasi ke atas.\n'
          '5. Terakhir, baca "Best Practices" untuk optimasi penulisan kode.',
          style: TextStyle(fontSize: 13.5, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Mengerti'),
          ),
        ],
      ),
    );
  }
}
