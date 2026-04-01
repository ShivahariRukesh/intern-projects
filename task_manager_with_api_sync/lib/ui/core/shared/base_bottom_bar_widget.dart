import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_with_api_sync/utils/bottom_navigation_bar_items.dart';

class BaseBottomBarWidget extends StatelessWidget {
  const BaseBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentUrl = GoRouterState.of(
      context,
    ).uri.toString();

    return BottomNavigationBar(
      onTap: (int index) => context.go(
        bottomNavigationBarItems[index]['path'] as String,
      ),
      currentIndex: bottomNavigationBarItems.indexWhere(
        (Map<String, Object> item) =>
            item['path'] as String == currentUrl,
      ),
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
