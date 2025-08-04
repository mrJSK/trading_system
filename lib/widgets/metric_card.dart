// lib/widgets/metric_card.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final Color? valueColor;
  final IconData? icon;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.valueColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 16,
                    color: AppTheme.getTextSecondary(context),
                  ),
                  const SizedBox(width: 4),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.getTextSecondary(context),
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.getTextSecondary(context),
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
