import 'package:flutter/material.dart';
import 'package:task_manager_with_api_sync/ui/core/shared/base_scaffold_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'Home',
      scaffoldBody: Container(
        child: const Text('Welcome to home screen'),
      ),
    );
  }
}
