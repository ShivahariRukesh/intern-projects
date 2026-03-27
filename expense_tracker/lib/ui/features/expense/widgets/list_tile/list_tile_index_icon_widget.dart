import 'package:flutter/material.dart';

/// It is a widget to display the index icon for a list tile
class ListTileIndexIcon extends StatelessWidget {
  /// [listIndex] The index number of the list item to be displayed as a leading highlight.
  final int listIndex;

  /// Parameters:
  /// There are 2 named parameters:
  /// - [key]: An optional parameter that identifies the widget in the widget tree.
  /// - [listIndex]: A required integer parameter representing the index of the list item.
  const ListTileIndexIcon({
    super.key,
    required this.listIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: const Color(
          0xFF6366F1,
        ).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        (listIndex + 1).toString(),
        style: const TextStyle(
          color: Color(0xFF818CF8),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
