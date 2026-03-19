import 'package:flutter/material.dart';

class DashboardStatsCardWidget extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final IconData icon;

  const DashboardStatsCardWidget({
    super.key,
    required this.value,
    required this.icon,
    required this.label,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.listTileTheme.tileColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              if (unit != null) ...[
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    unit!,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 6),

          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}
