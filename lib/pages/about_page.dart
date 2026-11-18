import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Halaman Informasi & Tentang Aplikasi
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Header Logo & App Title
          Center(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primaryColor, width: 2),
                  ),
                  child: const Icon(
                    Icons.flutter_dash,
                    color: AppTheme.primaryColor,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'State Management Demo App',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Versi 1.0.0 • Media Pembelajaran Flutter',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Tujuan Aplikasi
          _buildSectionCard(
            title: 'Tujuan Pembelajaran',
            icon: Icons.track_changes_rounded,
            content:
                'Aplikasi ini dirancang sebagai media pembelajaran interaktif untuk '
                'memahami konsep dasar pengelolaan State di Flutter tanpa menggunakan '
                'library pihak ketiga (murni menggunakan setState & bawaan framework).',
          ),
          const SizedBox(height: 16),

          // 5 Pilar Materi
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.menu_book_rounded, color: AppTheme.primaryColor),
                      SizedBox(width: 8),
                      Text(
                        '5 Materi Pokok yang Diterapkan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildPillarItem(
                    number: '1',
                    title: 'Konsep State & Counter',
                    desc: 'StatefulWidget, memori state, dan setState() memicu rebuild.',
                  ),
                  _buildPillarItem(
                    number: '2',
                    title: 'Widget Lifecycle',
                    desc: 'initState(), build(), didUpdateWidget(), dan dispose().',
                  ),
                  _buildPillarItem(
                    number: '3',
                    title: 'Passing Data',
                    desc: 'Aliran data satu arah (Props Down) dari Parent ke Child.',
                  ),
                  _buildPillarItem(
                    number: '4',
                    title: 'Callback Function',
                    desc: 'Komunikasi anak ke induk (Events Up) via VoidCallback.',
                  ),
                  _buildPillarItem(
                    number: '5',
                    title: 'Best Practices',
                    desc: 'Optimasi rebuild, pencegahan memory leak, dan scoping.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Spesifikasi Teknologi
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.terminal_rounded, color: AppTheme.primaryColor),
                      SizedBox(width: 8),
                      Text(
                        'Spesifikasi Teknologi',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTechRow('Framework', 'Flutter 3.x'),
                  _buildTechRow('Bahasa', 'Dart (Sound Null Safety)'),
                  _buildTechRow('Desain UI', 'Material Design 3'),
                  _buildTechRow('State Engine', 'setState() murni'),
                  _buildTechRow('Palet Warna', 'Primary: #2563EB | Secondary: #DBEAFE'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required String content,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildPillarItem({
    required String number,
    required String title,
    required String desc,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: AppTheme.secondaryColor,
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildTechRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

