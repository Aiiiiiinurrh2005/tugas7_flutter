import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// ============================================================================
/// MATERI 4: CALLBACK FUNCTION & EVENT PROPAGATION (CHILD WIDGET)
/// ============================================================================
/// LikeButton adalah Child Widget yang tidak menyimpan state jumlah like sendiri.
/// Sebaliknya, widget ini menerima 'VoidCallback' dari Parent Widget dan
/// memanggil callback tersebut ketika tombol ditekan ("Event Up").
///
/// Ketentuan:
/// - Child Widget berupa tombol LikeButton
/// - Menggunakan 'VoidCallback'
/// - Mengirim callback ke Parent tanpa memanipulasi state secara langsung
/// ============================================================================
class LikeButton extends StatefulWidget {
  // Callback function yang di-pass dari Parent Widget
  final VoidCallback onLike;
  final VoidCallback? onReset;

  const LikeButton({
    super.key,
    required this.onLike,
    this.onReset,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Animasi scale untuk feedback visual saat ditekan
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.90).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() async {
    // Memutar animasi tekan
    await _animationController.forward();
    await _animationController.reverse();

    // =========================================================================
    // EVENT PROPAGATION:
    // Memanggil callback function milik Parent.
    // Child tidak mengubah angka like sendiri; Child hanya memberitahu Parent:
    // "Hei Parent, tombol like baru saja ditekan!"
    // =========================================================================
    widget.onLike();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animasi tombol saat ditekan
        ScaleTransition(
          scale: _scaleAnimation,
          child: ElevatedButton.icon(
            onPressed: _handleTap,
            icon: const Icon(
              Icons.favorite_rounded,
              color: Colors.white,
              size: 22,
            ),
            label: const Text(
              'Tekan untuk Like ❤️',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              shadowColor: AppTheme.errorColor.withValues(alpha: 0.4),
            ),
          ),
        ),

        if (widget.onReset != null) ...[
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: widget.onReset,
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text(
              'Reset Like (Callback ke Parent)',
              style: TextStyle(fontSize: 13),
            ),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
