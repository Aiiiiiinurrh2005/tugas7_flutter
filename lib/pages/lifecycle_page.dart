import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Model untuk mencatat riwayat event lifecycle
class LifecycleLogItem {
  final String methodName;
  final String description;
  final String timestamp;
  final Color badgeColor;

  LifecycleLogItem({
    required this.methodName,
    required this.description,
    required this.timestamp,
    required this.badgeColor,
  });
}

/// ============================================================================
/// MATERI 2: WIDGET LIFECYCLE (PARENT WIDGET)
/// ============================================================================
/// Halaman ini mendemonstrasikan siklus hidup (lifecycle) dari StatefulWidget:
/// 1. initState()
/// 2. didChangeDependencies()
/// 3. build()
/// 4. didUpdateWidget() -> Melalui perubahan konfigurasi pada Child Widget
/// 5. dispose()
/// ============================================================================
class LifecyclePage extends StatefulWidget {
  const LifecyclePage({super.key});

  @override
  State<LifecyclePage> createState() => _LifecyclePageState();
}

class _LifecyclePageState extends State<LifecyclePage> {
  // ---------------------------------------------------------------------------
  // Resource Controller: Wajib di-dispose di dispose() untuk mencegah memory leak
  // ---------------------------------------------------------------------------
  late final TextEditingController _nameController;

  // State data konfigurasi yang akan dikirim ke Child Widget
  String _configuredName = 'Ahmad Dahlan';
  int _configVersion = 1;
  bool _isChildMounted = true;
  int _parentBuildCount = 0;

  // Daftar log lifecycle
  final List<LifecycleLogItem> _logs = [];

  // Helper untuk format waktu
  String _getTimestamp() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}.'
        '${now.millisecond.toString().padLeft(3, '0')}';
  }

  void _addLog(String method, String description, Color color) {
    setState(() {
      _logs.insert(
        0,
        LifecycleLogItem(
          methodName: method,
          description: description,
          timestamp: _getTimestamp(),
          badgeColor: color,
        ),
      );
    });
  }

  // ===========================================================================
  // 1. initState()
  // Dipanggil tepat SATU KALI saat objek State pertama kali dimasukkan ke tree.
  // Digunakan untuk inisialisasi controller, variabel, listener, atau fetch data.
  // ===========================================================================
  @override
  void initState() {
    super.initState();
    // Inisialisasi controller
    _nameController = TextEditingController(text: _configuredName);

    // Menambahkan log initState
    _logs.add(
      LifecycleLogItem(
        methodName: 'initState()',
        description:
            'Parent State diinisialisasi. TextEditingController dibuat.',
        timestamp: _getTimestamp(),
        badgeColor: AppTheme.successColor,
      ),
    );
  }

  // ===========================================================================
  // 2. didChangeDependencies()
  // Dipanggil setelah initState() dan setiap kali objek dependensi (InheritedWidget)
  // seperti Theme, MediaQuery, atau Locale berubah.
  // ===========================================================================
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // ===========================================================================
  // 3. dispose()
  // Dipanggil saat objek State dihapus permanen dari widget tree.
  // WAJIB digunakan untuk membersihkan (cleanup) resources seperti controller,
  // stream subscriptions, animation controllers, dan timer.
  // ===========================================================================
  @override
  void dispose() {
    // Membersihkan resource controller agar tidak terjadi memory leak
    _nameController.dispose();
    debugPrint('[LifecyclePage] dispose() dipanggil: Controller telah dibersihkan.');
    super.dispose();
  }

  /// Memperbarui konfigurasi yang dikirimkan ke Child Widget
  void _updateChildConfiguration() {
    final newName = _nameController.text.trim();
    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama tidak boleh kosong!')),
      );
      return;
    }

    // Memanggil setState pada parent akan memicu rebuild parent.
    // Parent kemudian mem-passing props baru (_configuredName, _configVersion)
    // ke LifecycleObserverWidget.
    // Karena widget anak menerima konfigurasi baru, Flutter akan memanggil
    // didUpdateWidget() pada State widget anak!
    setState(() {
      _configuredName = newName;
      _configVersion++;
    });
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
      _addLog('Log Cleared', 'Daftar log telah direset.', AppTheme.textMuted);
    });
  }

  // ===========================================================================
  // 4. build()
  // Dipanggil setiap kali UI perlu dirender ulang, misalnya setelah setState().
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    _parentBuildCount++;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Lifecycle'),
        actions: [
          IconButton(
            tooltip: 'Bersihkan Log',
            icon: const Icon(Icons.delete_sweep_rounded),
            onPressed: _clearLogs,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Penjelasan Lifecycle Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.secondaryColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.loop_rounded, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      const Text(
                        'Alur Lifecycle StatefulWidget',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Parent Rebuild: $_parentBuildCount',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1. initState() -> Dipanggil 1x saat pertama kali dibuat.\n'
                    '2. build() -> Dipanggil untuk merender UI.\n'
                    '3. didUpdateWidget() -> Dipanggil saat Parent mengirim konfigurasi baru.\n'
                    '4. dispose() -> Dipanggil saat widget dihapus untuk membersihkan memori.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: AppTheme.textPrimary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Form Input untuk Menguji didUpdateWidget()
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
                    const Text(
                      'Uji didUpdateWidget() via Konfigurasi Parent',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Ubah teks di bawah lalu tekan "Perbarui Konfigurasi". Parent akan merebuild dan mengirim props baru ke widget anak sehingga didUpdateWidget() terpanggil.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: AppTheme.textSecondary,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Konfigurasi',
                        hintText: 'Masukkan nama baru...',
                        prefixIcon: Icon(Icons.edit_rounded),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _updateChildConfiguration,
                            icon: const Icon(Icons.sync_rounded),
                            label: const Text('Perbarui Konfigurasi'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          tooltip: _isChildMounted
                              ? 'Unmount Child (Picu dispose())'
                              : 'Mount Child (Picu initState())',
                          icon: Icon(
                            _isChildMounted
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                          onPressed: () {
                            setState(() {
                              _isChildMounted = !_isChildMounted;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Target Child Widget (LifecycleObserverWidget)
            if (_isChildMounted)
              LifecycleObserverWidget(
                configuredName: _configuredName,
                configVersion: _configVersion,
                onLogEvent: (method, description, color) {
                  // Menerima notifikasi lifecycle dari widget anak
                  _addLog(method, description, color);
                },
              )
            else
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFCA5A5)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, color: AppTheme.errorColor),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Child Widget telah di-unmount dari tree. Method dispose() telah dijalankan!',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.errorColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Bagian Log Lifecycle Real-time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.history_edu_rounded,
                      size: 20,
                      color: AppTheme.primaryColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Live Lifecycle Event Logs',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_logs.length} Event',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Daftar Log Item
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _logs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final log = _logs[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: log.badgeColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          log.methodName,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: log.badgeColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              log.description,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              log.timestamp,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================================================
/// CHILD WIDGET UNTUK PENGUJIAN LIFECYCLE NYATA
/// ============================================================================
/// Widget ini menerima parameter konfigurasi dari Parent.
/// Setiap kali Parent mengubah nilai [configuredName] atau [configVersion],
/// Flutter mendeteksi perbedaan parameter widget dan memanggil:
/// -> didUpdateWidget(oldWidget)
/// ============================================================================
class LifecycleObserverWidget extends StatefulWidget {
  final String configuredName;
  final int configVersion;
  final Function(String method, String description, Color color) onLogEvent;

  const LifecycleObserverWidget({
    super.key,
    required this.configuredName,
    required this.configVersion,
    required this.onLogEvent,
  });

  @override
  State<LifecycleObserverWidget> createState() => _LifecycleObserverWidgetState();
}

class _LifecycleObserverWidgetState extends State<LifecycleObserverWidget> {
  int _childBuildCount = 0;

  // ===========================================================================
  // 1. initState() Child
  // Dipanggil 1x saat Child Widget pertama kali dibuat.
  // ===========================================================================
  @override
  void initState() {
    super.initState();
    // Beri sedikit microtask agar parent tidak memanggil setState saat sedang render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLogEvent(
        'initState()',
        'Child Widget diinisialisasi pertama kali dengan nama "${widget.configuredName}".',
        AppTheme.successColor,
      );
    });
  }

  // ===========================================================================
  // 2. didUpdateWidget()
  // Ini adalah method kunci untuk demonstrasi lifecycle saat konfigurasi berubah!
  // Flutter memanggil method ini saat Parent merebuild dan memberikan props
  // baru ke widget ini dengan runtimeType dan Key yang sama.
  // ===========================================================================
  @override
  void didUpdateWidget(covariant LifecycleObserverWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Memeriksa apakah properti konfigurasi benar-benar berubah dari konfigurasi lama
    if (oldWidget.configuredName != widget.configuredName ||
        oldWidget.configVersion != widget.configVersion) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onLogEvent(
          'didUpdateWidget()',
          'Konfigurasi diperbarui oleh Parent! '
          'Lama: "${oldWidget.configuredName}" (v${oldWidget.configVersion}) '
          '-> Baru: "${widget.configuredName}" (v${widget.configVersion}).',
          AppTheme.warningColor,
        );
      });
    }
  }

  // ===========================================================================
  // 3. dispose() Child
  // Dipanggil saat Child Widget dilepas/dihapus dari widget tree.
  // ===========================================================================
  @override
  void dispose() {
    // Mencatat di debug log saat widget anak dihapus
    debugPrint('[Child Widget] dispose() terpanggil. Resource dibersihkan.');
    super.dispose();
  }

  // ===========================================================================
  // 4. build() Child
  // Merender UI Child Widget berdasarkan parameter saat ini.
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    _childBuildCount++;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Child State',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'LifecycleObserverWidget',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Nama Konfigurasi Saat Ini: "${widget.configuredName}"',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Versi Konfigurasi: v${widget.configVersion} | Build Count: $_childBuildCount kali',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
