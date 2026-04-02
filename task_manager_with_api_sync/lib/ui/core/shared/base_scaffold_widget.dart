import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_with_api_sync/ui/core/shared/base_bottom_bar_widget.dart';

class BaseScaffoldWidget extends StatelessWidget {
  final Widget scaffoldBody;
  final String title;
  const BaseScaffoldWidget({
    super.key,
    required this.title,
    required this.scaffoldBody,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: scaffoldBody,
      bottomNavigationBar:
          GoRouterState.of(context).uri.toString() !=
              '/login'
          ? const BaseBottomBarWidget()
          : null,
    );
  }
}
