import 'package:flutter/material.dart';

/// A dashboard screen widget that displays the information of specific topic.
class DashboardStatsCardWidget extends StatelessWidget {
  /// [label] identifies what the information is about
  final String label;

  /// [unit] holds a type of measurement
  final String? unit;

  /// [value] holds the numeric information about the entity
  final String value;

  /// [icon] is the pictorial representation of the entity
  final IconData icon;

  /// It takes five parameters
  /// - [key] helps to uniquely identify this widget in the widget tree
  /// - [value] is required named parameter of type [String]
  /// - [icon] is required named parameter of type [IconData]
  /// - [label] is required named parameter of type [String]
  /// - [unit] is optional nullable named parameter of type [String]
  const DashboardStatsCardWidget({
    super.key,
    required this.value,
    required this.icon,
    required this.label,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.listTileTheme.tileColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                value,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              ..._displayUnit(theme),
            ],
          ),
          const SizedBox(height: 6),
          Text(label, style: theme.textTheme.displayMedium),
        ],
      ),
    );
  }

  List<Widget> _displayUnit(ThemeData theme) {
    if (unit != null) {
      return <Widget>[
        const SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            unit!,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ];
    } else {
      return <Widget>[const SizedBox()];
    }
  }
}
