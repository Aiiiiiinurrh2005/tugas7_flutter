import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// ============================================================================
/// MATERI 1: KONSEP STATE & setState()
/// ============================================================================
/// Mengapa menggunakan StatefulWidget?
/// StatelessWidget tidak memiliki memori internal untuk mengingat perubahan data.
/// StatefulWidget memiliki pasangan objek State yang tetap hidup di memori
/// ketika widget dibangun ulang (rebuild).
/// ============================================================================
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // ---------------------------------------------------------------------------
  // STATE DATA:
  // Nilai counter dimulai dari 0 sesuai ketentuan tugas.
  // Variabel ini berada di dalam objek State sehingga nilainya dapat bertahan
  // dan dimodifikasi sepanjang lifecycle halaman ini.
  // ---------------------------------------------------------------------------
  int _counter = 0;
  int _rebuildCount = 0;
  String _lastAction = 'Halaman dimuat (Initial State)';

  /// Method untuk menambah counter (+)
  void _incrementCounter() {
    // setState memberitahu Flutter bahwa state internal telah berubah
    setState(() {
      _counter++;
      _lastAction = 'Increment (+1) dipanggil pada setState()';
    });
  }

  /// Method untuk mengurangi counter (-)
  void _decrementCounter() {
    setState(() {
      _counter--;
      _lastAction = 'Decrement (-1) dipanggil pada setState()';
    });
  }

  /// Method untuk mereset counter (0)
  void _resetCounter() {
    setState(() {
      _counter = 0;
      _lastAction = 'Reset (kembali ke 0) dipanggil pada setState()';
    });
  }

  /// Method untuk penambahan nilai tertentu (+5)
  void _addByStep(int step) {
    setState(() {
      _counter += step;
      _lastAction = 'Tambah (+$step) dipanggil pada setState()';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild counter bertambah setiap kali build() dieksekusi oleh framework
    _rebuildCount++;

    return Scaffold(
      appBar: AppBar(
        title: const Text('State & Counter'),
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
                    Icons.lightbulb_rounded,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Perubahan state melalui setState() menandai widget sebagai dirty dan '
                      'memicu method build() untuk melakukan rebuild UI secara otomatis.',
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

            // Card Counter Utama
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'NILAI COUNTER SAAT INI',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tampilan Angka Counter Modern
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Container(
                        key: ValueKey<int>(_counter),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: _counter > 0
                              ? AppTheme.primaryColor.withValues(alpha: 0.08)
                              : _counter < 0
                                  ? AppTheme.errorColor.withValues(alpha: 0.08)
                                  : AppTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _counter > 0
                                ? AppTheme.primaryColor.withValues(alpha: 0.3)
                                : _counter < 0
                                    ? AppTheme.errorColor.withValues(alpha: 0.3)
                                    : const Color(0xFFE2E8F0),
                            width: 2,
                          ),
                        ),
                        child: Text(
                          '$_counter',
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w900,
                            color: _counter > 0
                                ? AppTheme.primaryColor
                                : _counter < 0
                                    ? AppTheme.errorColor
                                    : AppTheme.textPrimary,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    // Indikator Status Nilai
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _counter > 0
                            ? AppTheme.successColor.withValues(alpha: 0.12)
                            : _counter < 0
                                ? AppTheme.warningColor.withValues(alpha: 0.12)
                                : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _counter > 0
                            ? 'Status: Positif (State > 0)'
                            : _counter < 0
                                ? 'Status: Negatif (State < 0)'
                                : 'Status: Netral (State = 0)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _counter > 0
                              ? AppTheme.successColor
                              : _counter < 0
                                  ? AppTheme.warningColor
                                  : AppTheme.textSecondary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 20),

                    // Tombol Kontrol Utama: Tambah (+), Kurang (-), Reset
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tombol Kurang (-)
                        ElevatedButton(
                          onPressed: _decrementCounter,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF1F5F9),
                            foregroundColor: AppTheme.textPrimary,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(18),
                            elevation: 0,
                          ),
                          child: const Icon(Icons.remove, size: 28),
                        ),
                        const SizedBox(width: 16),

                        // Tombol Reset
                        OutlinedButton.icon(
                          onPressed: _resetCounter,
                          icon: const Icon(Icons.refresh_rounded, size: 18),
                          label: const Text('Reset'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Tombol Tambah (+)
                        ElevatedButton(
                          onPressed: _incrementCounter,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(18),
                            elevation: 2,
                          ),
                          child: const Icon(Icons.add, size: 28),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    // Tombol Tambahan Preset Cepat (+5, +10)
                    Wrap(
                      spacing: 8,
                      children: [
                        ActionChip(
                          avatar: const Icon(Icons.exposure_plus_1, size: 16),
                          label: const Text('+1'),
                          onPressed: _incrementCounter,
                        ),
                        ActionChip(
                          avatar: const Icon(Icons.add, size: 16),
                          label: const Text('+5'),
                          onPressed: () => _addByStep(5),
                        ),
                        ActionChip(
                          avatar: const Icon(Icons.add, size: 16),
                          label: const Text('+10'),
                          onPressed: () => _addByStep(10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Live Inspector Card (Bukti Rebuild)
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
                        Icon(
                          Icons.insights_rounded,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Flutter State Inspector',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      label: 'Total Rebuild Method build():',
                      value: '$_rebuildCount kali',
                      valueColor: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      label: 'Aksi Terakhir:',
                      value: _lastAction,
                      valueColor: AppTheme.textPrimary,
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      label: 'Status State:',
                      value: 'Dirty -> Clean (Rendered)',
                      valueColor: AppTheme.successColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Code Explanation Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.code, color: Color(0xFF94A3B8), size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Pola Kode setState()',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'void _incrementCounter() {\n'
                    '  setState(() {\n'
                    '    _counter++; // Mengubah variabel state\n'
                    '  }); // Memicu build(BuildContext context)\n'
                    '}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Color(0xFF93C5FD),
                      fontSize: 12.5,
                      height: 1.5,
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

  Widget _buildInfoRow({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
