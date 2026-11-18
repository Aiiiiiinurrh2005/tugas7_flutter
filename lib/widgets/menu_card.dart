import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Widget reusable untuk menampilkan kartu menu pembelajaran di Dashboard & Tab Praktik
class MenuCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String moduleNumber;
  final VoidCallback onTap;
  final Color? iconBgColor;
  final Color? iconColor;

  const MenuCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.moduleNumber,
    required this.onTap,
    this.iconBgColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: AppTheme.secondaryColor.withValues(alpha: 0.5),
        highlightColor: AppTheme.secondaryColor.withValues(alpha: 0.2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container with soft background
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: iconBgColor ?? AppTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? AppTheme.primaryColor,
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),

              // Title, module tag & description
              Expanded(
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
                            color: AppTheme.secondaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            moduleNumber,
                            style: const TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text(
                          'Buka Praktik',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 15,
                          color: AppTheme.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
