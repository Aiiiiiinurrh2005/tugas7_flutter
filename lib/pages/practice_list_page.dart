import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/menu_card.dart';
import 'counter_page.dart';
import 'lifecycle_page.dart';
import 'passing_data_page.dart';
import 'callback_page.dart';
import 'best_practices_page.dart';

/// Halaman Tab Praktik: Menyajikan daftar modul praktik secara terstruktur
class PracticeListPage extends StatelessWidget {
  const PracticeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modul Praktik'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Banner Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.secondaryColor),
            ),
            child: Row(
              children: const [
                Icon(Icons.science_rounded, color: AppTheme.primaryColor),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Pilih salah satu modul praktik di bawah untuk mencoba interaksi langsung dan melihat kode implementasinya.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Modul 1
          MenuCard(
            moduleNumber: 'PRAKTIK 1',
            title: 'State & Counter',
            description:
                'Praktik StatefulWidget, tombol (+, -, reset), dan pembuktian UI rebuild saat memanggil setState().',
            icon: Icons.add_circle_outline_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CounterPage()),
              );
            },
          ),
          const SizedBox(height: 12),

          // Modul 2
          MenuCard(
            moduleNumber: 'PRAKTIK 2',
            title: 'Widget Lifecycle',
            description:
                'Eksperimen initState(), build(), didUpdateWidget() dari konfigurasi parent, dan dispose().',
            icon: Icons.sync_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LifecyclePage()),
              );
            },
          ),
          const SizedBox(height: 12),

          // Modul 3
          MenuCard(
            moduleNumber: 'PRAKTIK 3',
            title: 'Passing Data',
            description:
                'Pengiriman data satu arah (Props Down) dari Parent Widget ke Child StatelessWidget.',
            icon: Icons.call_split_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PassingDataPage()),
              );
            },
          ),
          const SizedBox(height: 12),

          // Modul 4
          MenuCard(
            moduleNumber: 'PRAKTIK 4',
            title: 'Callback Function',
            description:
                'Komunikasi ke atas (Events Up) menggunakan VoidCallback dari Child LikeButton ke Parent.',
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

          // Modul 5
          MenuCard(
            moduleNumber: 'PRAKTIK 5',
            title: 'Best Practices',
            description:
                'Panduan 5 praktik terbaik optimasi state, pencegahan memory leak, dan pemilihan arsitektur.',
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
    );
  }
}
