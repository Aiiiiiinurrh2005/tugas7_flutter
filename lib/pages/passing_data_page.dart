import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/profile_card.dart';

/// ============================================================================
/// MATERI 3: PASSING DATA BETWEEN WIDGETS (PARENT TO CHILD)
/// ============================================================================
/// Konsep Unidirectional Data Flow (Aliran Data Satu Arah):
/// Data mengalir ke bawah (Props Down) dari Parent Widget ke Child Widget.
///
/// Halaman ini berfungsi sebagai Parent Widget:
/// 1. Mengelola state data yang dimasukkan melalui TextField.
/// 2. Menyediakan tombol "Kirim Data".
/// 3. Mengirimkan nilai variabel state ke Child Widget (ProfileCard) melalui constructor.
/// ============================================================================
class PassingDataPage extends StatefulWidget {
  const PassingDataPage({super.key});

  @override
  State<PassingDataPage> createState() => _PassingDataPageState();
}

class _PassingDataPageState extends State<PassingDataPage> {
  // Controller untuk input TextField
  late final TextEditingController _inputNameController;
  late final TextEditingController _inputRoleController;

  // ---------------------------------------------------------------------------
  // STATE PARENT:
  // Data ini disimpan di Parent dan diteruskan ke Child Widget
  // ---------------------------------------------------------------------------
  String _submittedName = 'Budi Santoso';
  String _submittedRole = 'Flutter Developer';
  String _lastSentTime = 'Aplikasi Dimuat';
  int _sendCount = 0;

  @override
  void initState() {
    super.initState();
    _inputNameController = TextEditingController(text: _submittedName);
    _inputRoleController = TextEditingController(text: _submittedRole);
  }

  @override
  void dispose() {
    // Wajib dispose controller
    _inputNameController.dispose();
    _inputRoleController.dispose();
    super.dispose();
  }

  /// Helper untuk mendapatkan string waktu saat ini
  String _formatTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
  }

  /// Method untuk mengirim data dari Parent ke Child melalui setState()
  void _sendDataToChild() {
    final nameInput = _inputNameController.text.trim();
    if (nameInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan nama terlebih dahulu!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Memanggil setState() di Parent untuk memperbarui state.
    // Saat Parent dirender ulang, Child Widget (ProfileCard) diinstansiasi
    // dengan constructor parameter baru (Passing Data).
    setState(() {
      _submittedName = nameInput;
      _submittedRole = _inputRoleController.text.trim().isEmpty
          ? 'Mobile Engineer'
          : _inputRoleController.text.trim();
      _lastSentTime = _formatTime();
      _sendCount++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data "$_submittedName" berhasil dikirim ke Child Widget!'),
        backgroundColor: AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _applyQuickPreset(String name, String role) {
    _inputNameController.text = name;
    _inputRoleController.text = role;
    _sendDataToChild();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passing Data Between Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Penjelasan Aliran Data Card
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
                    Icons.call_split_rounded,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Konsep "Props Down": Data mengalir satu arah dari Parent ke Child '
                      'melalui constructor parameter bertipe "final" dengan kata kunci "required".',
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

            // Card Form Input Parent Widget
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Parent Widget',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'PassingDataPage (StatefulWidget)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Input Nama
                    TextField(
                      controller: _inputNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        hintText: 'Contoh: Siti Rahma',
                        prefixIcon: Icon(Icons.person_rounded),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Input Peran/Role
                    TextField(
                      controller: _inputRoleController,
                      decoration: const InputDecoration(
                        labelText: 'Peran / Jabatan',
                        hintText: 'Contoh: UI/UX Designer',
                        prefixIcon: Icon(Icons.badge_rounded),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tombol Kirim Data
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _sendDataToChild,
                        icon: const Icon(Icons.send_rounded),
                        label: const Text('Kirim Data ke Child Widget'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Contoh preset cepat
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          'Preset:',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        ActionChip(
                          label: const Text('Dewi Sartika'),
                          onPressed: () => _applyQuickPreset(
                            'Dewi Sartika',
                            'Lead Engineer',
                          ),
                        ),
                        ActionChip(
                          label: const Text('Ki Hajar'),
                          onPressed: () => _applyQuickPreset(
                            'Ki Hajar Dewantara',
                            'Educator & Founder',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Panah visual aliran data
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_downward_rounded,
                      size: 16,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Data mengalir ke Child ($_sendCount kali dikirim)',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Child Widget Target: ProfileCard (StatelessWidget)
            ProfileCard(
              name: _submittedName,
              subtitle: _submittedRole,
              timestamp: _lastSentTime,
            ),
            const SizedBox(height: 20),

            // Code Anatomy Card
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
                    '// Parent memanggil Child dengan argument parameter:',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'ProfileCard(\n'
                    '  name: _submittedName, // final String\n'
                    '  subtitle: _submittedRole,\n'
                    ');',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      color: Color(0xFF93C5FD),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '// Child Widget menerima parameter di constructor:',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'class ProfileCard extends StatelessWidget {\n'
                    '  final String name; // immutable\n'
                    '  const ProfileCard({super.key, required this.name});\n'
                    '  ...\n'
                    '}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      color: Color(0xFF86EFAC),
                      height: 1.4,
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
