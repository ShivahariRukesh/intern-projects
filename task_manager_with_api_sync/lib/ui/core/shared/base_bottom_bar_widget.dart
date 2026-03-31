import 'package:flutter/material.dart';
import 'package:task_manager_with_api_sync/utils/bottom_navigation_bar_items.dart';

class BaseBottomBarWidget extends StatefulWidget {
  const BaseBottomBarWidget({super.key});

  @override
  State<BaseBottomBarWidget> createState() =>
      _BaseBottomBarWidgetState();
}

class _BaseBottomBarWidgetState
    extends State<BaseBottomBarWidget> {
  int tappedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) => setState(() {
        tappedItemIndex = index;
      }),
      currentIndex: tappedItemIndex,
      items: bottomNavigationBarItems
          .map(
            (Map<String, Object> item) =>
                BottomNavigationBarItem(
                  icon: item['icon'] as Icon,
                  label: item['label'] as String,
                ),
          )
          .toList(),
    );
  }
}
