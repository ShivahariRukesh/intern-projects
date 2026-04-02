import 'package:flutter/material.dart';
import 'package:task_manager_with_api_sync/ui/core/shared/base_scaffold_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      title: 'Profile',
      scaffoldBody: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[Text('Username'), Text('Email')],
      ),
    );
  }
}
